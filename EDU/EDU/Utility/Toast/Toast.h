//
//  Toast.h
//  零用贷
//
//  Created by chyjoyboy on 14-10-11.
//  Copyright (c) 2014年 chyjoyboy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Toast : UIView

@property (retain, nonatomic) NSString* message ;

-(id) initWithMessage:(NSString*) message ;
-(void) show ;
+(Toast *)sharedToast;
@end
