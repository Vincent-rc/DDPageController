//
//  DDPageControl.m
//  DDPageController
//
//  Created by Crc on 11/13/15.
//  Copyright © 2015 Crc. All rights reserved.
//

#import "DDPageControl.h"

@implementation DDPageControl

#define kButtonIndex 100

static CGFloat const DDPageControllerIndicatorViewHeight = 2.0f;
static CGFloat const DDPageControllerIndicatorViewSpace = 20.0f;

#pragma mark -
#pragma mark properties

- (void)setDd_titles:(NSArray *)dd_titles{
    if (dd_titles) {
        _dd_titles = dd_titles;
        
        CGRect frame = self.frame;
        
        UIColor *kTitleNormalColor = [UIColor grayColor];
        UIColor *kTitleSelectedColor = [UIColor blueColor];
        UIColor *kIndicatorViewColor = [UIColor redColor];
        
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _contentView.backgroundColor = [UIColor colorWithRed:240.0 / 255.0 green:240.0 / 255.0 blue:240.0 / 255.0 alpha:1.0];
        [self addSubview:_contentView];
        
        float width = frame.size.width;
        float height = frame.size.height;
        NSInteger titleCount = dd_titles.count;
        
        for (int i = 0; i < titleCount; i ++)
        {
            UIButton * aButton = [[UIButton alloc] initWithFrame:CGRectMake(0 + (width / titleCount) * i, 0, width / titleCount, frame.size.height)];
            aButton.tag =  kButtonIndex + i;
            [aButton setTitle:[dd_titles objectAtIndex:i] forState:UIControlStateNormal];
            [aButton setTitle:[dd_titles objectAtIndex:i] forState:UIControlStateHighlighted];
            [aButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            aButton.titleLabel.font = [UIFont systemFontOfSize:15];
            [aButton setTitleColor:kTitleNormalColor forState:UIControlStateNormal];
            [aButton setTitleColor:kTitleSelectedColor forState:UIControlStateSelected];
            [aButton setTitleColor:kTitleSelectedColor forState:UIControlStateHighlighted];
            [aButton addTarget:self action:@selector(aButtonPressed:) forControlEvents:UIControlEventTouchUpInside];

            [_contentView addSubview:aButton];
        }
        [((UIButton *)[_contentView viewWithTag:kButtonIndex]) setSelected:YES];
        
        _pageView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, height - 10, width, 10)];
        _pageView.showsHorizontalScrollIndicator = YES;
        _pageView.showsVerticalScrollIndicator = YES;
        
        _pageView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        _pageView.backgroundColor = [UIColor clearColor];
        _pageView.pagingEnabled = YES;
        _pageView.delegate = self;
        _pageView.contentSize = CGSizeMake(self.frame.size.width * titleCount, _pageView.frame.size.height);
        [self addSubview:_pageView];
        
        UIView *aLine = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-0.5, frame.size.width, 0.5)];
        aLine.backgroundColor = [UIColor grayColor];
        [_contentView addSubview:aLine];
        
        _indicatorView = [[UIImageView alloc] initWithFrame:CGRectMake((width / titleCount) * 0 + DDPageControllerIndicatorViewSpace, height - DDPageControllerIndicatorViewHeight, (width / titleCount)-DDPageControllerIndicatorViewSpace*2, DDPageControllerIndicatorViewHeight)];
        _indicatorView.backgroundColor = kIndicatorViewColor;
        [_contentView addSubview:_indicatorView];
    }
}

- (void)setDd_titleNormalColor:(UIColor *)dd_titleNormalColor{
    _dd_titleNormalColor = dd_titleNormalColor;
    for (int i = 0; i < self.dd_titles.count; i ++)
    {
        [((UIButton *)[_contentView viewWithTag:kButtonIndex + i]) setTitleColor:dd_titleNormalColor forState:UIControlStateNormal];
    }
}

- (void)setDd_titleSelectedColor:(UIColor *)dd_titleSelectedColor{
    _dd_titleSelectedColor = dd_titleSelectedColor;
    for (int i = 0; i < self.dd_titles.count; i ++)
    {
        [((UIButton *)[_contentView viewWithTag:kButtonIndex + i]) setTitleColor:dd_titleSelectedColor forState:UIControlStateHighlighted];
        [((UIButton *)[_contentView viewWithTag:kButtonIndex + i]) setTitleColor:dd_titleSelectedColor forState:UIControlStateSelected];
    }
}

- (void)setDd_indicatorColor:(UIColor *)dd_indicatorColor{
    _dd_indicatorColor = dd_indicatorColor;
    self.indicatorView.backgroundColor = dd_indicatorColor;
}


- (void)aButtonPressed:(UIButton *)sender
{
    NSInteger tag = sender.tag - kButtonIndex;
    for (int i = 0; i < self.dd_titles.count; i ++)
    {
        [((UIButton *)[_contentView viewWithTag:kButtonIndex + i]) setSelected:NO];
    }
    
    [sender setSelected:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        [_indicatorView setFrame:CGRectMake((self.frame.size.width / self.dd_titles.count) * tag + DDPageControllerIndicatorViewSpace, _indicatorView.frame.origin.y, _indicatorView.frame.size.width, _indicatorView.frame.size.height)];
    }];
    
    
    if ([_delegate respondsToSelector:@selector(dd_pageControl:)])
    {
        [self.delegate dd_pageControl:tag];
    }
}

-(void)setIndicatorViewColor:(UIColor *)color
{
    _indicatorView.backgroundColor = color;
}

- (void)setSelectPage:(NSInteger)index
{
    for (int i = 0; i < self.dd_titles.count; i ++)
    {
        [((UIButton *)[_contentView viewWithTag:kButtonIndex + i]) setSelected:NO];
    }
    
    [((UIButton *)[_contentView viewWithTag:kButtonIndex + index]) setSelected:YES];
    
    [UIView animateWithDuration:0.2 animations:^{
        [_indicatorView setFrame:CGRectMake((self.frame.size.width / self.dd_titles.count) * index + DDPageControllerIndicatorViewSpace, _indicatorView.frame.origin.y, _indicatorView.frame.size.width, _indicatorView.frame.size.height)];
    }];

}

#pragma mark UIScrollowView delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = _pageView.frame.size.width;
    
    int page = floor((_pageView.contentOffset.x - pageWidth / 2)  / pageWidth) + 1;
    
    NSLog(@"currentPage = %d",page);
    
    if ([_delegate respondsToSelector:@selector(dd_pageControl:)])
    {
        [self.delegate dd_pageControl:page];
    }
    
}


@end
