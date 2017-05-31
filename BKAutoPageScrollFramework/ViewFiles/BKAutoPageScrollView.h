#import <UIKit/UIKit.h>

@interface BKAutoPageScrollView : UIScrollView
typedef void(^blockOfAutoPageScrollView)(NSInteger);

@property(nonatomic,copy) blockOfAutoPageScrollView blockToTagImageViewAction;

/**[初始化]**/
+ (instancetype)autoPageScrollView;
- (instancetype)initImagesNameArray:(NSArray*)imagesNameArray;

/**[添加单一图像]到主视图中**/
- (void)addImageNameToMainViewArray:(NSString*)imageName;

/**[设置主试图坐标]**/
- (void)setPositionWithX:(CGFloat)x Y:(CGFloat)y;
/**[设置主试图大小]**/
- (void)setSizeWithWidth:(CGFloat)width Height:(CGFloat)height;


/**最终加载[主方法]**/
- (void)loadAutoPageScrollViewMainFunction;


/*mainTimer计时器[启动]*/
- (void)playMainTimerAction;
/*mainTimer计时器[关闭]*/
- (void)stopMainTimerAction;


@end
