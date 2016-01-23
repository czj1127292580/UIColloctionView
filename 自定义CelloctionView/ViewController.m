//
//  ViewController.m
//  自定义CelloctionView
//
//  Created by Mac on 15/3/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "ImagesCell.h"
#import "LineLayout.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    ImagesCell *cell;
}
@property (nonatomic, strong) NSMutableArray *images;
@property (nonatomic, weak) UICollectionView *collectionView;
@end

@implementation ViewController

static NSString *const ID = @"image";

- (NSMutableArray *)images{

    if (!_images) {
        self.images = [[NSMutableArray alloc] init];
        for (int i = 1; i <= 20; i++) {
            [self.images addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    return _images;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CGFloat w = self.view.frame.size.width;
    CGRect rect = CGRectMake(0, 100, w, 200);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:[[LineLayout alloc] init]];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerNib:[UINib nibWithNibName:@"ImagesCell" bundle:nil] forCellWithReuseIdentifier:ID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{

    if ([self.collectionView.collectionViewLayout isKindOfClass:[LineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[UICollectionViewFlowLayout alloc] init] animated:YES];
    }else{
    [self.collectionView setCollectionViewLayout:[[LineLayout alloc] init] animated:YES];
    }
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.images.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.delegete = self;
//    cell.backgroundColor = [UIColor redColor];
    cell.image = self.images[indexPath.item];
    return cell;
}

//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//
//    // 删除模型数据
//    [self.images removeObjectAtIndex:indexPath.item];
//    // 刷新UI
//    [collectionView deleteItemsAtIndexPaths:@[indexPath]];
//    
//}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    NSString *str1 = [NSString stringWithFormat:@"%f",scrollView.contentOffset.x];
//    
//    int str2 = [str1 intValue];
//    
//    if (str2 % 200 == 0) {
//        cell.imageBtn.hidden = NO;
//    }else{
//        cell.imageBtn.hidden = YES;
//    }
//    [self.collectionView reloadData];
//}






@end
