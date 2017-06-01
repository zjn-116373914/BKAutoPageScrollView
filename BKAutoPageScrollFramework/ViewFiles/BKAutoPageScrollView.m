#import "BKAutoPageScrollView.h"
#import "UIView+Layout.h"

/**宏定义屏幕长宽以及其他参数**/
#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height
#define HeadHeight    20
#define NavigationItemHeight 44
#define TabBarItemHeight     49


@interface BKAutoPageScrollView()<UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *mainImagesNameMarr;
@property (nonatomic, strong) NSTimer *mainTimer;

@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) UIPageControl *mainPageView;

@end

@implementation BKAutoPageScrollView
#pragma mark - 系统方法
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.mainImagesNameMarr = [[NSMutableArray alloc] init];
        
        self.width = ScreenWidth;
        self.height = ScreenHeight/3;
        self.x = 0;
        self.y = NavigationItemHeight + HeadHeight;
        
        [self addSubview:self.mainScrollView];
        [self addSubview:self.mainPageView];
    }
    return self;
}

#pragma mark ---------------------------------------------------------------------------

#pragma mark - [外部开放]方法
/**[初始化]**/
+ (instancetype)autoPageScrollView
{
    return  [[self alloc] init];
}
/**[重构方法]**/
- (instancetype)initImagesNameArray:(NSArray*)imagesNameArray
{
    self = [super init];
    if (self)
    {
        self.mainImagesNameMarr = [NSMutableArray arrayWithArray:imagesNameArray];
    }
    return self;
}

/**[添加单一图像]到主视图中**/
- (void)addImageNameToMainViewArray:(NSString*)imageName
{
    [self.mainImagesNameMarr addObject:imageName];
}

/**[设置主试图坐标]**/
- (void)setPositionWithX:(CGFloat)x Y:(CGFloat)y
{
    self.x = x;
    self.y = y;
}


/**[设置主试图大小]**/
- (void)setSizeWithWidth:(CGFloat)width Height:(CGFloat)height
{
    self.width = width;
    self.height = height;
}


/**最终加载[主方法]**/
- (void)loadAutoPageScrollViewMainFunction
{
    //设置UIScrollView主要图像加载
    self.mainScrollView.contentSize = CGSizeMake((self.mainImagesNameMarr.count+2)*self.mainScrollView.width, self.mainScrollView.height);
    for (int i=0; i<self.mainImagesNameMarr.count; i++)
    {
        UIImageView *mainImgView = [[UIImageView alloc] init];
        mainImgView.image = [UIImage imageNamed:self.mainImagesNameMarr[i]];
        mainImgView.width = self.width;
        mainImgView.height = self.height;
        mainImgView.x = self.width * (i+1);
        mainImgView.y = 0;
        
        mainImgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapGestureAction:)];
        [mainImgView addGestureRecognizer:tap];
        mainImgView.tag = 100 + i;
        
        [self.mainScrollView addSubview:mainImgView];
    }
    
    //设置UIScrollView[首端图像加载]
    UIImageView *firstImgView = [[UIImageView alloc] init];
    firstImgView.width = self.width;
    firstImgView.height = self.height;
    firstImgView.x = 0;
    firstImgView.y = 0;
    [firstImgView setImage:[UIImage imageNamed:[self.mainImagesNameMarr lastObject]]];
    [self.mainScrollView addSubview:firstImgView];
    //-----------------------------------------------------------
    
    //设置UIScrollView[尾端图像加载]
    UIImageView *lastImgView = [[UIImageView alloc] init];
    lastImgView.width = self.width;
    lastImgView.height = self.height;
    lastImgView.x = (self.mainImagesNameMarr.count+1)*lastImgView.width;
    lastImgView.y = 0;
    [lastImgView setImage:[UIImage imageNamed:[self.mainImagesNameMarr firstObject]]];
    [self.mainScrollView addSubview:lastImgView];
    //-----------------------------------------------------------
    
    //设置UIScrollView运行操作
    self.mainScrollView.contentOffset = CGPointMake(1*self.width, 0);
    [self playMainTimerAction];
    //-----------------------------------------------------------

    //设置UIPageControl底部[页码器]基本参数
    self.mainPageView.numberOfPages = self.mainImagesNameMarr.count;
    self.mainPageView.currentPage = 0;
    //-----------------------------------------------------------

}

#pragma mark ---------------------------------------------------------------------------


#pragma mark - UIScrollViewDelegate
/*UIScrollView[滚动减速结束后]调用该方法*/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //如果UIScrollView处在[前端]或者[后端],进行[跳跃]操作
    NSInteger indexOfPages = scrollView.contentOffset.x/scrollView.width;
    if (indexOfPages == 0)
    {
        [self.mainScrollView setContentOffset:CGPointMake((self.mainImagesNameMarr.count)*self.width, 0)];
    }
    else if(indexOfPages == (self.mainImagesNameMarr.count+1))
    {
        [self.mainScrollView setContentOffset:CGPointMake(1*self.width, 0)];
    }
    //-----------------------------------------------------------
    
    //滑动完成后,[底部页码器]进行[页码跳动]操作
    indexOfPages = scrollView.contentOffset.x/scrollView.width - 1;
    self.mainPageView.currentPage = indexOfPages;
    //-----------------------------------------------------------
    
    //开启[自动翻页]计时器
    [self playMainTimerAction];
}

/*UIScrollView[开始滑动时]调用该方法*/
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopMainTimerAction];
}


#pragma mark ---------------------------------------------------------------------------

#pragma mark - mainTimer计时器操作方法
/*mainTimer计时器[启动]*/
- (void)playMainTimerAction
{
    if(self.mainTimer == nil)
    {
        self.mainTimer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(autoPageAction) userInfo:nil repeats:YES];
    }
}

/*mainTimer计时器[关闭]*/
- (void)stopMainTimerAction
{
    if(self.mainTimer != nil)
    {
        [self.mainTimer invalidate];
        self.mainTimer = nil;
    }
}

/*mainTimer计时器[执行方法]*/
- (void)autoPageAction
{
    //如果UIScrollView处在[前端]或者[后端],进行[跳跃]操作
    NSInteger indexOfPageCurrent = self.mainScrollView.contentOffset.x/self.width;
    NSInteger indexOfPageNext = (indexOfPageCurrent+1)%(self.mainImagesNameMarr.count+1);
    if(indexOfPageNext == 0)
    {
        indexOfPageNext = 1;
    }
    self.mainScrollView.contentOffset = CGPointMake(indexOfPageNext*self.width, 0);
    //-----------------------------------------------------------

    //自动翻页完成后,[底部页码器]进行[页码跳动]操作
    indexOfPageCurrent = self.mainScrollView.contentOffset.x/self.mainScrollView.width;
    NSInteger indexOfPages = indexOfPageCurrent - 1;
    self.mainPageView.currentPage = indexOfPages;
    //-----------------------------------------------------------
}

#pragma mark ---------------------------------------------------------------------------




#pragma mark - 控件以及手势[点击事件]
- (void)TapGestureAction:(UIGestureRecognizer*)sender
{
    self.blockToTagImageViewAction(sender.view.tag);
    
}
#pragma mark ---------------------------------------------------------------------------


#pragma mark - GettingAndSetting
-(UIScrollView *)mainScrollView
{
    if(!_mainScrollView)
    {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 0, self.width, self.height);
        _mainScrollView.pagingEnabled = YES;
        _mainScrollView.showsHorizontalScrollIndicator = NO;
        
        _mainScrollView.delegate = self;
    }
    
    return _mainScrollView;
}

-(UIPageControl *)mainPageView
{
    if(!_mainPageView)
    {
        _mainPageView = [[UIPageControl alloc] init];
        _mainPageView.width = self.width/3;
        _mainPageView.height = 20;
        _mainPageView.x = self.width/2 - _mainPageView.width/2;
        _mainPageView.y = self.height - _mainPageView.height;
    }
    
    return _mainPageView;
}

#pragma mark ---------------------------------------------------------------------------

@end
