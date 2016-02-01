//
//  SBLessonCollectionViewCell.m
//  ABC360
//
//  Created by dog_47 on 1/15/16.
//  Copyright © 2016 abc360.com. All rights reserved.
//

#import "SBLessonCollectionViewCell.h"

@implementation SBLessonCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"SBLessonCollectionViewCell" owner:self options:nil];
        
        
        if (arrayOfViews.count < 1)
        {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]])
        {
            return nil;
        }

        self = [arrayOfViews objectAtIndex:0];
        self.layer.cornerRadius=5;
        self.backgroundColor=[UIColor whiteColor];

        _alphaView=[[UIView alloc]initWithFrame:self.bounds];
        _alphaView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f];
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 38, 45)];
        img.center=CGPointMake(_alphaView.frame.size.width/2.0f/1.2f, 110/1.2f);
        img.image=[UIImage imageNamed:@"SB_Lesson_lock"];
        [_alphaView addSubview:img];
        [self addSubview:_alphaView];
    }
    return self;
}


@end
