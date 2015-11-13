//
//  ViewController.m
//  DDPageController
//
//  Created by Crc on 11/13/15.
//  Copyright © 2015 Crc. All rights reserved.
//

#import "ViewController.h"

#import "ViewControllerA.h"
#import "ViewControllerB.h"
#import "DDPageController/DDPageController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark selectors

- (IBAction)push:(id)sender{
    UIStoryboard* dd_storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *A = [dd_storyboard instantiateViewControllerWithIdentifier:@"A"];
    UIViewController *B = [dd_storyboard instantiateViewControllerWithIdentifier:@"B"];
//    ViewControllerA *A = [[ViewControllerA alloc] init];
//    ViewControllerB *B = [[ViewControllerB alloc] init];
    ViewController *C = [[ViewController alloc] init];
    DDPageController *ddPage = [[DDPageController alloc] init];
    ddPage.dd_viewControllers = @[A,B,C];
    ddPage.dd_titles = @[@"AAA",@"BBB",@"CCC"];
    ddPage.dd_titleNormalColor = [UIColor grayColor];
    ddPage.dd_titleSelectedColor = [UIColor blueColor];
    ddPage.dd_indicatorColor = [UIColor redColor];
    [self.navigationController pushViewController:ddPage animated:YES];
}

@end
