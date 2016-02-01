//
//  SBLessonCollectionViewCell.h
//  ABC360
//
//  Created by dog_47 on 1/15/16.
//  Copyright © 2016 abc360.com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SBLessonCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property (weak, nonatomic) IBOutlet UILabel *lable3;
@property (weak, nonatomic) IBOutlet UIImageView *cardImg;
@property (strong,nonatomic) UIView *alphaView;

@end
