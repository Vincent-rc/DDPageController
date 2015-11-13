//
//  DDPageController.m
//  DDPageController
//
//  Created by Crc on 11/13/15.
//  Copyright © 2015 Crc. All rights reserved.
//

#import "DDPageController.h"
#import "DDPageControl.h"

@interface DDPageController ()<DDPageControlDelegate,UIScrollViewDelegate>

@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DDPageControl *ddPageContrl;

@end

static CGFloat const DDPageControllerButtonHeight = 50.0f;

@implementation DDPageController

- (instancetype)init{
    if (self = [super init]) {
        [self setupView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.modalPresentationCapturesStatusBarAppearance = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark views

- (void)setupView{
    //Setup container view.
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0.0f,
                                                                     DDPageControllerButtonHeight,
                                                                     CGRectGetWidth(self.view.frame),
                                                                     CGRectGetHeight(self.view.frame) - DDPageControllerButtonHeight)];
    self.containerView = containerView;
    [self.view addSubview:self.containerView];
    
    
    self.ddPageContrl = [[DDPageControl alloc] init];
    self.ddPageContrl.frame = CGRectMake(0.0f,
                                         0.0f,
                                         CGRectGetWidth(self.view.frame),
                                         DDPageControllerButtonHeight);
    self.ddPageContrl.backgroundColor = [UIColor purpleColor];
    self.ddPageContrl.delegate = self;
    [self.view addSubview:self.ddPageContrl];
    

    
    self.scrollView = [UIScrollView new];
    self.scrollView.frame = self.containerView.bounds;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.bounces = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.containerView addSubview:self.scrollView];

    self.containerView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    self.scrollView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
}

#pragma mark -
#pragma mark properties

- (void)setDd_viewControllers:(NSArray *)dd_viewControllers{
    if (dd_viewControllers) {
        
        _dd_viewControllers = dd_viewControllers;
        
        self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.containerView.frame) * dd_viewControllers.count, 0);
        
        for (UIViewController *childVC in dd_viewControllers) {
            NSInteger index = [dd_viewControllers indexOfObject:childVC];
            childVC.view.frame = CGRectMake(self.containerView.frame.size.width * index, 0, self.containerView.bounds.size.width, self.containerView.bounds.size.height);
            [self addChildViewController:childVC];
            [self.scrollView addSubview:childVC.view];
            [childVC didMoveToParentViewController:self];
        }
    }

}

- (void)setDd_titles:(NSArray *)dd_titles{
    if (dd_titles) {
        _dd_titles = dd_titles;
        
        _ddPageContrl.dd_titles = _dd_titles;
    }
}

- (void)setDd_titleNormalColor:(UIColor *)dd_titleNormalColor{
    _dd_titleNormalColor = dd_titleNormalColor;
    _ddPageContrl.dd_titleNormalColor = dd_titleNormalColor;
}

- (void)setDd_titleSelectedColor:(UIColor *)dd_titleSelectedColor{
    _dd_titleSelectedColor = dd_titleSelectedColor;
    _ddPageContrl.dd_titleSelectedColor = dd_titleSelectedColor;
}

- (void)setDd_indicatorColor:(UIColor *)dd_indicatorColor{
    _dd_indicatorColor = dd_indicatorColor;
    _ddPageContrl.dd_indicatorColor = dd_indicatorColor;
}

#pragma mark -
#pragma mark DDPageControlDeleegate

- (void)dd_pageControl:(NSInteger)index{
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.frame.size.width, 0) animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate


#pragma mark UIScrollowView delegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    
    NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2)  / pageWidth) + 1;
    
    [self.ddPageContrl setSelectPage:page];
    
}


@end
