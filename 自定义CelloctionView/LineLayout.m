//
//  LineLayout.m
//  自定义CelloctionView
//
//  Created by Mac on 15/3/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "LineLayout.h"

static const CGFloat ItemWH = 100;

@implementation LineLayout

- (instancetype)init{
    
    if (self = [super init]) {
            }
    return self;
}

/**
 *  一些初始化工作最好在这里实现
 */
- (void)prepareLayout{
    
    [super prepareLayout];
    self.itemSize = CGSizeMake(ItemWH, ItemWH);
    
    CGFloat inset = (self.collectionView.frame.size.width - ItemWH) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    // 设置水平滚动
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = ItemWH;

}


/**
 *  用来设置collectionView停止滚动的那一刻的位置
 *
 *  @param proposedContentOffset 原本scrollView停止滚动的那一刻的位置
 *  @param velocity              滚动速度
 */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity{
    
    // 计算出scrollView最后会停留的范围
    CGRect lastRect;
    lastRect.origin = proposedContentOffset;
    lastRect.size = self.collectionView.frame.size;
    
    
    // 计算屏幕最中间的x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    // 取出这个范围内的所有属性
    NSArray *array = [self layoutAttributesForElementsInRect:lastRect];
    
    // 遍历所有属性
    CGFloat adjustOffsetX = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(attrs.center.x - centerX) < adjustOffsetX) {
            adjustOffsetX = attrs.center.x - centerX;
        }
    }
    
    
    return CGPointMake(proposedContentOffset.x + adjustOffsetX, proposedContentOffset.y);
}


/**
 *  只要显示的边界发生改变就会重新布局
 内部会重新调用layoutAttributesForElementsInRect方法获得所有的cell的布局属性
 *
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    // 计算可见的矩形框
    CGRect visiableRect;
    visiableRect.size = self.collectionView.frame.size;
    visiableRect.origin = self.collectionView.contentOffset;
    
//   取出默认的cell的UICollectionViewLayoutAttributes
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    // 计算屏幕最中间的x
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.frame.size.width * 0.5;
    
    // 遍历所有的布局属性
    for (UICollectionViewLayoutAttributes *attrs in array) {
        
        if (!CGRectIntersectsRect(visiableRect, attrs.frame)) continue;
        // 每一个item的中点x
        CGFloat itemCenterX = attrs.center.x;
        
        // 差距越小，缩放比例越大
        
        // 取绝对值，根据跟屏幕最中间的距离计算缩放比例
       CGFloat scale = 1 + 0.7 * (1 - (ABS(itemCenterX - centerX) / self.collectionView.frame.size.width));
        
        attrs.transform3D = CATransform3DMakeScale(scale, scale, 1.0);
    }
    
    return array;
}


@end
