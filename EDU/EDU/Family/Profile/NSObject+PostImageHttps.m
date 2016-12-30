//
//  NSObject+PostImageHttps.m
//  EDU
//
//  Created by renxingguo on 2016/12/30.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import "NSObject+PostImageHttps.h"

@implementation NSObject (PostImageHttps)

- (void)requestPostUrlWithImage: (NSString *)serviceName parameters:(NSDictionary *)dictParams image:(UIImage *)image success:(void (^)(NSDictionary *responce))success failure:(void (^)(NSError *error))failure {
    
    NSString *strService = [NSString stringWithFormat:@"%@%@",BASEURL,serviceName];
    
    NSData *fileData = image?UIImageJPEGRepresentation(image, 0.5):nil;
    
    NSError *error;
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:strService parameters:dictParams constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        if(fileData){
            [formData appendPartWithFileData:fileData
                                        name:@"uploadFile"
                                    fileName:@"face.jpg"
                                    mimeType:@"image/jpeg"];
        }
    } error:&error];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    __weak AFURLSessionManager* weakManager = manager;
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession *session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing *_credential) {
        
        SecTrustRef serverTrust = [[challenge protectionSpace] serverTrust];
        /**
         *  导入多张CA证书（Certification Authority，支持SSL证书以及自签名的CA），请替换掉你的证书名称
         */
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];//自签名证书
        NSData* caCert = [NSData dataWithContentsOfFile:cerPath];
        NSSet *cerArray = [NSSet setWithObject:caCert];
        weakManager.securityPolicy.pinnedCertificates = cerArray;
        
        SecCertificateRef caRef = SecCertificateCreateWithData(NULL, (__bridge CFDataRef)caCert);
        NSCAssert(caRef != nil, @"caRef is nil");
        
        NSArray *caArray = @[(__bridge id)(caRef)];
        NSCAssert(caArray != nil, @"caArray is nil");
        
        OSStatus status = SecTrustSetAnchorCertificates(serverTrust, (__bridge CFArrayRef)caArray);
        SecTrustSetAnchorCertificatesOnly(serverTrust,NO);
        NSCAssert(errSecSuccess == status, @"SecTrustSetAnchorCertificates failed");
        
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential = nil;
        if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            if ([weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                if (credential) {
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
        
        return disposition;
    }];
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager uploadTaskWithStreamedRequest:request progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"Wrote %f", uploadProgress.fractionCompleted);
    }
                                      completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                                          if (error)
                                          {
                                              failure(error);
                                          }
                                          else
                                          {
                                              NSLog(@"POST Response  : %@",responseObject);
                                              success(responseObject);
                                          }
                                      }];
    
    [uploadTask resume];
    
}


@end
