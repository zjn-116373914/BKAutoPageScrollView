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
        
        self.delegate = self;
        
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
    //设置UIScrollView基本参数
    self.contentSize = CGSizeMake(self.width*(self.mainImagesNameMarr.count+2), self.height);
    self.pagingEnabled= YES;
    self.showsHorizontalScrollIndicator = NO;
    //-----------------------------------------------------------
    
    //设置UIScrollView主要图像加载
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
        
        [self addSubview:mainImgView];
    }
    //-----------------------------------------------------------
    
    //设置UIScrollView[首端图像加载]
    UIImageView *firstImgView = [[UIImageView alloc] init];
    firstImgView.width = self.width;
    firstImgView.height = self.height;
    firstImgView.x = 0;
    firstImgView.y = 0;
    [firstImgView setImage:[UIImage imageNamed:[self.mainImagesNameMarr lastObject]]];
    [self addSubview:firstImgView];
    //-----------------------------------------------------------
    
    //设置UIScrollView[尾端图像加载]
    UIImageView *lastImgView = [[UIImageView alloc] init];
    lastImgView.width = self.width;
    lastImgView.height = self.height;
    lastImgView.x = (self.mainImagesNameMarr.count+1)*lastImgView.width;
    lastImgView.y = 0;
    [lastImgView setImage:[UIImage imageNamed:[self.mainImagesNameMarr firstObject]]];
    [self addSubview:lastImgView];
    //-----------------------------------------------------------

    //设置UIScrollView运行操作
    self.contentOffset = CGPointMake(1*self.width, 0);
    [self playMainTimerAction];
    //-----------------------------------------------------------
    
    
}

#pragma mark ---------------------------------------------------------------------------

#pragma mark - UIScrollViewDelegate
/*UIScrollView[滚动减速结束后]调用该方法*/
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger indexOfPages = scrollView.contentOffset.x/scrollView.width;
    if (indexOfPages == 0)
    {
        [self setContentOffset:CGPointMake((self.mainImagesNameMarr.count)*self.width, 0)];
    }
    else if(indexOfPages == (self.mainImagesNameMarr.count+1))
    {
        [self setContentOffset:CGPointMake(1*self.width, 0)];
    }
    
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
    NSInteger indexOfPageCurrent = self.contentOffset.x/self.width;
    NSInteger indexOfPageNext = (indexOfPageCurrent+1)%(self.mainImagesNameMarr.count+1);
    if(indexOfPageNext == 0)
    {
        indexOfPageNext = 1;
    }
    self.contentOffset = CGPointMake(indexOfPageNext*self.width, 0);
}

#pragma mark ---------------------------------------------------------------------------


#pragma mark - 控件以及手势[点击事件]
- (void)TapGestureAction:(UIGestureRecognizer*)sender
{
    self.blockToTagImageViewAction(sender.view.tag);
    
}
#pragma mark ---------------------------------------------------------------------------






@end
