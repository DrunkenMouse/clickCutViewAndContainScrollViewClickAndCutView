//
//  FirstViewController.m
//  控制器的选择
//
//  Created by 王奥东 on 16/3/12.
//  Copyright © 2016年 王奥东. All rights reserved.
//

#import "FirstViewController.h"
#import "UIView+Frame.h"

static NSString *str = @"ContentCell";
#define W   [UIScreen mainScreen].bounds.size.width
#define H   [UIScreen mainScreen].bounds.size.height

@interface FirstViewController()<UICollectionViewDataSource,UICollectionViewDelegate>


//存放数据的数组
@property(nonatomic,strong)NSArray *items;

//滚动的标签
@property (nonatomic, strong) UIScrollView *channelScrollView;

//展示页面的collectionView
@property(nonatomic, strong)UICollectionView *contentCollectionView;

//collectionView的flowLayout
@property(nonatomic,strong)UICollectionViewFlowLayout *contentFlowLayout;

//控件数组
@property (nonatomic, strong) NSMutableArray *itemLabels;

//当前选中的currentSelectedLabel
@property (nonatomic, strong) UILabel *currentSelectedLabel;

//每个标签下面的view
@property(nonatomic,strong) UIView * bottomView;

@end


@implementation FirstViewController

#pragma mark - 懒加载设置item控件数组
-(NSMutableArray *)itemLabels{
    if (_itemLabels==nil) {
        _itemLabels = [NSMutableArray array];
    }
    return _itemLabels;
}


#pragma mark - 通过懒加载的方式生成contentFlowLayouyt
-(UICollectionViewFlowLayout *)contentFlowLayout{
    if (_contentFlowLayout == nil) {
        
        _contentFlowLayout = [[UICollectionViewFlowLayout alloc]init];

        //设置每个Cell的宽高
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat heigth = [UIScreen mainScreen].bounds.size.height - 64 - self.channelScrollView.h;
       _contentFlowLayout.itemSize = CGSizeMake(width, heigth);
        //设置cell的滚动方式为横向
        _contentFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置最小的行间距
        _contentFlowLayout.minimumLineSpacing = 0;
    }
    return _contentFlowLayout;
}

#pragma mark - 懒加载item数据数组
-(NSArray *)items{
    if (_items==nil) {
        _items = @[@"货币",@"货币",@"货币",@"货币",@"货币",@"货币",@"货币",@"货币",@"货币",];
    }
    return _items;
}

#pragma mark - 懒加载方式设置item的ScrollView的位置与宽高
-(UIScrollView *)channelScrollView{
    if (_channelScrollView==nil) {
        
        //给scrollView的每个控件添加标志用的红线
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(10, 42, 60, 2)];
        view.backgroundColor = [UIColor redColor];
        self.bottomView = view;
        
        //设置ScrollView的位置与大小
        _channelScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, W, 44)];
        
        //取消ScrollView的滑动条
        _channelScrollView.showsHorizontalScrollIndicator = NO;
        [_channelScrollView addSubview:view];
    }
    return _channelScrollView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加itme标签
    [self setupChannelLabels];
    
    //添加展示界面的collectionView
    self.contentCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, W, H) collectionViewLayout:self.contentFlowLayout];
    self.contentCollectionView.backgroundColor = [UIColor whiteColor];
    
    //注册原生的collectionViewCell
    [self.contentCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:str];
    
    self.contentCollectionView.delegate = self;
    self.contentCollectionView.dataSource = self;
    
    //取消滚动条并设置分页效果
    self.contentCollectionView.showsHorizontalScrollIndicator = NO;
    self.contentCollectionView.showsVerticalScrollIndicator = NO;
    self.contentCollectionView.pagingEnabled = YES;
    
    //将CollectionView与scrollView添加到自身view上
    [self.view addSubview:self.contentCollectionView];
    [self.view addSubview:self.channelScrollView];
}

#pragma mark 设置标签数组
- (void)setupChannelLabels{
    
    //1.遍历数组去创建item
    CGFloat channelLabelW = 80;
    CGFloat channelLabelH = self.channelScrollView.frame.size.height;
    CGFloat channelLabelY = 0;
    
    for (int i=0; i<self.items.count; i++) {
        
        UILabel *item = [[UILabel alloc] init];
        if (i==0) {
            item.textColor = [UIColor redColor];
        }
        
        item.frame = CGRectMake(channelLabelW*i, channelLabelY, channelLabelW, channelLabelH);
        
        
        item.text = self.items[i];
    
        //设置文字显示为居中模式
        item.textAlignment = UITextAlignmentCenter;
        
        //添加tag用来识别item
        item.tag = i;
        
        //给item添加手势
        item.userInteractionEnabled = YES;
        [item addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(channelLabelClick:)]];
        
        //把刚刚创建出来的item添加到控件数组与scrollView
        [self.itemLabels addObject:item];
        [self.channelScrollView addSubview:item];
        
    }
    
    //设置channelScrollView的ContentSize让其滚动
    self.channelScrollView.contentSize = CGSizeMake(channelLabelW * self.itemLabels.count, 0);
    
}



#pragma mark - CollectionView的数据源

//设置collectionView的cell个数为item数组的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}

//设置cell内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    

    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:str forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed: (arc4random() % 256 / 256.0) green:(arc4random() % 256 / 256.0) blue:(arc4random() % 256 / 256.0) alpha:1.0];
   
    
    return cell;
}


#pragma mark - 上下联动的方法:点击了上面的某个标签
- (void)channelLabelClick:(UITapGestureRecognizer *)recognizer{
    UILabel *channelLabel =  (UILabel *)recognizer.view;
    
    //将当前选中的Label赋值
    self.currentSelectedLabel = channelLabel;
   
    //调用最终的方法
    [self lastMethod];
    
    //让下面的显示内容的Collection滚动
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:channelLabel.tag inSection:0];
    [self.contentCollectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    int currentPage = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    self.currentSelectedLabel = self.itemLabels[currentPage];
    
    [self lastMethod];
}

#pragma mark 调整ScrollView中控件的显示方式
- (void)lastMethod{
    //居中
    //计算应该滚动多少
    CGFloat needScrollOffsetX = self.currentSelectedLabel.center.x - self.channelScrollView.bounds.size.width * 0.5;
    
    //最大允许滚动的距离
    CGFloat maxAllowScrollOffsetX = self.channelScrollView.contentSize.width - self.channelScrollView.bounds.size.width;
    
    if (needScrollOffsetX<0) {
        needScrollOffsetX = 0;
    }
    
    if (needScrollOffsetX>maxAllowScrollOffsetX) {
        needScrollOffsetX = maxAllowScrollOffsetX;
    }
    
    [self.channelScrollView setContentOffset:CGPointMake(needScrollOffsetX, 0) animated:YES];
    
    //2.重置所有的ChannelLabel的选中状态
    for (UILabel *channelLabel in self.itemLabels) {
        if (channelLabel == self.currentSelectedLabel) {
            
            channelLabel.textColor = [UIColor redColor];
            //改变标签底部的标志View的位置
            self.bottomView.frame = CGRectMake(channelLabel.tag*80+10, 42, 60, 2);
            
        }else {
            
            channelLabel.textColor = [UIColor blackColor];
        }
    }
}








@end
