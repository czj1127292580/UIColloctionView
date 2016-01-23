//
//  ImagesCell.h
//  自定义CelloctionView
//
//  Created by Mac on 15/3/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ImagesCell : UICollectionViewCell

@property (nonatomic, copy) NSString *image;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (assign, nonatomic) id delegete;
@end
