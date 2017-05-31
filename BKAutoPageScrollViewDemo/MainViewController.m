//
//  MainViewController.m
//  BKAutoPageScrollViewDemo
//
//  Created by 张加宁 on 2017/5/18.
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
    
    NSMutableArray *mainImagesMarr = [[NSMutableArray alloc] init];
    [mainImagesMarr addObject:@"IMG_01.png"];
    [mainImagesMarr addObject:@"IMG_02.png"];
    [mainImagesMarr addObject:@"IMG_03.png"];
    [mainImagesMarr addObject:@"IMG_04.png"];
    [mainImagesMarr addObject:@"IMG_05.png"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    BKAutoPageScrollView *mainScrollView = [[BKAutoPageScrollView autoPageScrollView] initImagesNameArray:mainImagesMarr];
    mainScrollView.blockToTagImageViewAction = ^(NSInteger tagOfImageView)
    {
        FirstViewController *firstCtl = [[FirstViewController alloc] init];
        SecondViewController *secondCtl = [[SecondViewController alloc] init];
        ThirdViewController *thirdCtl = [[ThirdViewController alloc] init];
        FourthViewController *fourthCtl = [[FourthViewController alloc] init];
        FifthViewController *fifthCtl = [[FifthViewController alloc] init];
        
        switch (tagOfImageView)
        {
            case 100:
            {
                [self.navigationController pushViewController:firstCtl animated:YES];
            }break;
                
            case 101:
            {
                [self.navigationController pushViewController:secondCtl animated:YES];
            }break;
                
            case 102:
            {
                [self.navigationController pushViewController:thirdCtl animated:YES];
            }break;
                
            case 103:
            {
                [self.navigationController pushViewController:fourthCtl animated:YES];
            }break;
                
            case 104:
            {
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
