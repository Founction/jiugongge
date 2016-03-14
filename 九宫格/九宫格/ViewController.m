#import "ViewController.h"

@interface ViewController ()
//由于shopsView要反复使用，所以用strong
@property(strong,nonatomic)UIView *shopsView;
//当你除了生成一个按钮，而且还要设置按钮都在不同方法中时，要设置下属性，而不仅仅是方法中。
//相当于一个全局的变量。addBtn、removeBtn就需要在该处声明下。
@property(weak,nonatomic) UIButton *addBtn;
@property(weak,nonatomic) UIButton *removeBtn;
@property(strong,nonatomic)NSArray *shops;
@end

@implementation ViewController
//重写get方法，懒加载
-(NSArray *)shops
{
    if (_shops == nil)
    {
         NSBundle *bundle = [NSBundle mainBundle];
    
        NSString *file = [bundle pathForResource:@"shop.plist" ofType:nil];
    
        self.shops = [NSArray arrayWithContentsOfFile:file];
    
    }
    //NSLog(@"%d",__LINE__);打印当前行
    return _shops;
    
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.shopsView = [[UIView alloc] init];
//    self.shopsView.frame = CGRectMake(0, 90, 375, 550);
//    self.shopsView.backgroundColor = [UIColor redColor];
    _shopsView = [[UIView alloc] init];
    _shopsView.frame = CGRectMake(0, 90, 375, 550);
    _shopsView.backgroundColor = [UIColor redColor];
    
    self.addBtn = [self addButtonWithImage:@"add" highImage:@"add_highlighted" disableImage:@"add_disabled" frame:CGRectMake(30, 30, 50, 50) action:@selector(add)];
    
    self.removeBtn = [self addButtonWithImage:@"remove" highImage:@"remove_highlighted" disableImage:@"remove_disabled" frame:CGRectMake(250, 30, 50, 50) action:@selector(removebtn)];
    
//    //数据通过plist方法获得数据
//    NSBundle *bundle = [[NSBundle alloc] init];
//    
//    NSString *path = [bundle pathForResource:@"shop.plist" ofType:nil];
//    //NSString *path = [bundle pathForResource:shop ofType:plist];
//    
    
 
    
}

-(UIButton *)addButtonWithImage:(NSString *)image highImage:(NSString *)hightimage disableImage:(NSString *)disableImage frame:(CGRect)frame action:(SEL)action
{
    //创建按钮
    UIButton *btn = [[UIButton alloc]init];
    
    //设置背景颜色
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage imageNamed:hightimage] forState:UIControlStateHighlighted];
    
    [btn setBackgroundImage:[UIImage imageNamed:disableImage] forState:UIControlStateDisabled];
    
    //设置位置和尺寸
    btn.frame = frame;
    
    //设置监听按钮
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    return btn;
}

-(void)add
{
    int cols = 4;
    //图片的显示大小
    CGFloat shopsW = 50;
    CGFloat shopsH = 70;
    
    //创建一个父控件UIView放置一个图片和文本
    UIView *shopView = [[UIView alloc] init];
    
    //  shopView.backgroundColor = [UIColor blueColor];//颜色设置可选
    
    //确定列距
    CGFloat colMargin = (self.view.frame.size.width - cols * shopsW) / (cols + 1);
    // 确定行距 假设有十行
    CGFloat rowMargin = (self.view.frame.size.height - 10 * shopsH) / 10;
    // 求设备的大小CGRect
    //CGRect screenRect = [[UIScreen mainScreen]bounds];
    
    //商品的索引，来计算总攻添加了几幅图片了，确定该图片存放的坐标
    NSUInteger index = self.shopsView.subviews.count;
    
    //判断当前子视图个数，为了0个子视图，可以添加个UIview，通过计算该UIview的子视图个数
    NSLog(@"%lu",(unsigned long)self.shopsView.subviews.count);
    
    //商品图片的坐标算法包括x和y
    //1.除以列数能够确定在该行的图片有几个，就是一行有几个图片。一行的x值加上前边的图片
    NSUInteger col = index % cols;
    NSInteger shopsX = (col + 1)* colMargin + col * shopsW;
    //2.通过对列数的求余计算得出该图片在行中的位置。一行中所有图片的y值都相同。
    NSUInteger row = index / cols;
    NSInteger shopsY = (row + 1) * rowMargin + row * shopsH + 80;
    
    shopView.frame = CGRectMake(shopsX, shopsY, 50, 70);
    [self.shopsView addSubview:shopView];
    //创建一个图片视图来存放商品图片一个商品图片对应一个UIImageView
    //    UIImage *imageName = [UIImage imageNamed:@"danjianbao"];
    //    UIImageView *iconView = [[UIImageView alloc] initWithImage:imageName];
    NSDictionary *shop = self.shops[index];
    NSLog(@"%d",__LINE__);
    //设置图片信息
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:shop[@"icon"]];
    imageView.frame = CGRectMake(0, 0, shopsW, shopsW);
    [shopView addSubview:imageView];
    //设置文本信息
    UILabel *lable = [[UILabel alloc] init];
    lable.text = shop[@"name"];
    lable.adjustsFontSizeToFitWidth = YES;//文字设置同文本框大小适配
    lable.frame = CGRectMake(0,shopsW,shopsW,shopsH - shopsW);
    [shopView addSubview:lable];
    
    [self.view addSubview:self.shopsView];
    
    [self checkState];
}
#pragma removeBtn
- (void)removebtn
{
    //删除最后一个元素
    [[self.shopsView.subviews lastObject] removeFromSuperview];
    
    [self checkState];
    
    
}

#pragma mark 检查状态：按钮状态
- (void)checkState
{
//    if (self.shopsView.subviews.count == _shops.count)
//        self.addBtn.enabled = NO;
//    else
//        self.addBtn.enabled = YES;
//    
//    if (self.shopsView.subviews.count <= _shops.count)
//        self.removeBtn.enabled = YES;
//    else
//        self.removeBtn.enabled = YES;
    
    
    self.addBtn.enabled = (self.shopsView.subviews.count < self.shops.count);
    
    self.removeBtn.enabled = (self.shopsView.subviews.count > 0);
    
    
    UILabel *lableHUD = [[UILabel alloc] init];
    lableHUD.frame = CGRectMake(50, 150, 200, 50);
    lableHUD.adjustsFontSizeToFitWidth = YES;
    
    NSString *text = nil;
    
    if (self.shopsView.subviews.count == self.shops.count)
    {
        text = @"商品一经添加满";
    }
    if(self.shopsView.subviews.count == 0)
    {
        text = @"商品一经删除完";
    }
    if (text == nil) {
        return;
    }
    
    lableHUD.text = text;
    lableHUD.alpha = 1.0;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        lableHUD.alpha = 0.0;
    });
    [self.view addSubview:lableHUD];
}


@end
