//
//  UIViewController+SimulateContainer.m
//  DressingCollection
//
//  Created by renxingguo on 15/11/9.
//  Copyright © 2015年 北京伊人依美科技有限公司. All rights reserved.
//

#import "UIViewController+SimulateContainer.h"

@implementation UIViewController (SimulateContainer)

-(void)bindConstainer:(NSString*)identifier withView:(UIView*)view
{
    if (self.storyboard) {
        
        UIViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
        [self addChildViewController:controller];
        
        UIView *destView = controller.view;
//        destView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
        destView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        [view addSubview:destView];
        [controller didMoveToParentViewController:self];
    }
    
}

-(void)bindConstainerTo:(UIViewController*)controller withView:(UIView*)view
{
    if (self.storyboard) {
        [self addChildViewController:controller];
        
        UIView *destView = controller.view;
        //        destView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
        destView.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        [view addSubview:destView];
        [controller didMoveToParentViewController:self];
    }
    
}

@end
