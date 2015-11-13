//
//  DDPageControl.h
//  DDPageController
//
//  Created by Crc on 11/13/15.
//  Copyright © 2015 Crc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DDPageControlDelegate <NSObject>

- (void)dd_pageControl:(NSInteger)index;

@end

@interface DDPageControl : UIView <UIScrollViewDelegate>


@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIScrollView *pageView;

@property (strong, nonatomic) UIImageView *indicatorView;

@property (strong, nonatomic) NSArray *dd_titles;

@property (assign, nonatomic) UIColor *dd_indicatorColor;

@property (assign, nonatomic) UIColor *dd_titleNormalColor;

@property (assign, nonatomic) UIColor *dd_titleSelectedColor;

@property (weak, nonatomic) id <DDPageControlDelegate> delegate;

- (void)setSelectPage:(NSInteger)index;

@end