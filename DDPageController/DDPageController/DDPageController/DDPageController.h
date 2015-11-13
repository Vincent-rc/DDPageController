//
//  DDPageController.h
//  DDPageController
//
//  Created by Crc on 11/13/15.
//  Copyright © 2015 Crc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDPageController : UIViewController

@property (nonatomic, strong) NSArray *dd_viewControllers;

@property (nonatomic, strong) NSArray *dd_titles;

@property (assign, nonatomic) UIColor *dd_indicatorColor;

@property (assign, nonatomic) UIColor *dd_titleNormalColor;

@property (assign, nonatomic) UIColor *dd_titleSelectedColor;

@end
