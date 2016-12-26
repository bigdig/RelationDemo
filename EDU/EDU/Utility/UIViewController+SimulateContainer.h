//
//  UIViewController+SimulateContainer.h
//  DressingCollection
//
//  Created by renxingguo on 15/11/9.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SimulateContainer)

-(void)bindConstainer:(NSString*)identifier withView:(UIView*)view;

-(void)bindConstainerTo:(UIViewController*)controller withView:(UIView*)view;
@end
