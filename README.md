# BKAutoPageScrollView
该框架是一个UIScrollView扩展框架,在原来UIScrollView基础上添加了自动翻页功能,以及对每一张图像的点击事件功能.并且该框架在主视图的底部还添加了页码器,可以及时标记总图像数以及当前页码.

例如:

    //框架外[核心代码]
    NSMutableArray *mainImagesMarr = [[NSMutableArray alloc] init];
    [mainImagesMarr addObject:@"IMG_01.png"];
    [mainImagesMarr addObject:@"IMG_02.png"];
    [mainImagesMarr addObject:@"IMG_03.png"];
    [mainImagesMarr addObject:@"IMG_04.png"];
    [mainImagesMarr addObject:@"IMG_05.png"];
    
    BKAutoPageScrollView *mainScrollView = [[BKAutoPageScrollView autoPageScrollView] initImagesNameArray:mainImagesMarr];
    mainScrollView.blockToTapImageViewAction = ^(NSInteger tagOfImageView)
    {
        NSLog(@"%ld", tagOfImageView);
    };
    [mainScrollView loadAutoPageScrollViewMainFunction];
    //------------------------------------------------------------
    
    [self.view addSubview:mainScrollView];

