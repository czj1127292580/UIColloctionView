//
//  ImagesCell.m
//  自定义CelloctionView
//
//  Created by Mac on 15/3/21.
//  Copyright (c) 2015年 Mac. All rights reserved.
//

#import "ImagesCell.h"

@interface ImagesCell()


@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ImagesCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.layer.borderWidth = 3;
    self.imageView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageView.layer.cornerRadius = 5;
    self.imageView.clipsToBounds = YES;
}

- (void)setImage:(NSString *)image{

    _image = [image copy];
    self.imageView.image = [UIImage imageNamed:image];
    
}

@end
