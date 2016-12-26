//
//  DramaClubListViewController.h
//  EDU
//
//  Created by renxingguo on 2016/10/14.
//  Copyright © 2016年 YRYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DramaClubListViewController : UIViewController

@property(nonatomic,weak) IBOutlet UICollectionView *collectionView;
@property(nonatomic,assign) NSInteger maxShowCount;
@end
