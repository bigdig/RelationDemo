//
//  VerifyCodeButton.h
//  DressingCollection
//
//  Created by renxingguo on 15/9/25.
//  Copyright (c) 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VerifyCodeButton : UIButton

- (void)requestVerifyCode:(NSString*)phoneNumber;

- (void)beginTime;
@end
