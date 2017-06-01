//
//  MainViewController.m
//  BKAutoPageScrollViewDemo
//
//  Created by 张加宁 on 2017/6/1.
//  Copyright © 2017年 BlackKnife. All rights reserved.
//

#import "MainViewController.h"
#import "BKAutoPageScrollView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FifthViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSMutableArray *mainImagesMarr = [[NSMutableArray alloc] init];
    [mainImagesMarr addObject:@"IMG_01.png"];
    [mainImagesMarr addObject:@"IMG_02.png"];
    [mainImagesMarr addObject:@"IMG_03.png"];
    [mainImagesMarr addObject:@"IMG_04.png"];
    [mainImagesMarr addObject:@"IMG_05.png"];
    
    BKAutoPageScrollView *mainScrollView = [[BKAutoPageScrollView autoPageScrollView] initImagesNameArray:mainImagesMarr];
    mainScrollView.blockToTapImageViewAction = ^(NSInteger tagOfImageView)
    {
        switch (tagOfImageView)
        {
            case 100:
            {
                FirstViewController *firstCtl = [[FirstViewController alloc] init];
                [self.navigationController pushViewController:firstCtl animated:YES];
            }break;
                
            case 101:
            {
                SecondViewController *secondCtl = [[SecondViewController alloc] init];
                [self.navigationController pushViewController:secondCtl animated:YES];
            }break;
                
            case 102:
            {
                ThirdViewController *thirdCtl = [[ThirdViewController alloc] init];
                [self.navigationController pushViewController:thirdCtl animated:YES];
            }break;
                
            case 103:
            {
                FourthViewController *fourthCtl = [[FourthViewController alloc] init];
                [self.navigationController pushViewController:fourthCtl animated:YES];
            }break;
                
            case 104:
            {
                FifthViewController *fifthCtl = [[FifthViewController alloc] init];
                [self.navigationController pushViewController:fifthCtl animated:YES];
            }break;
                
            default:
                break;
        }
    };
    [mainScrollView loadAutoPageScrollViewMainFunction];
    
    [self.view addSubview:mainScrollView];
}



@end
