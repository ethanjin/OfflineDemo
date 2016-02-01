//
//  CenterButton.m
//  AnimatingButtons
//
//  Created by dog_47 on 1/8/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import "CenterButton.h"


#define BUTTON_WIDTH  ([UIScreen mainScreen].bounds.size.height>=667 ? 110:([UIScreen mainScreen].bounds.size.height==568 ? 90 :80))

@interface CenterButton()
@property (nonatomic,strong) SBLabel *lable1;
@property (nonatomic,strong) SBLabel *lable2;

@end

@implementation CenterButton

#pragma mark CenterButton.h
-(void)setButtonPosition:(CGPoint)_point{
    self.center=_point;
}

+(CenterButton *)creatCenterButton{
    CGRect theRect=CGRectMake(0, 0,BUTTON_WIDTH , BUTTON_WIDTH);
    id obj=[[CenterButton alloc]initWithFrame:theRect];
    return obj;
}

#pragma makr init
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        [self initSettings];
    }
    return self;
}



-(void)initSettings{
    self.backgroundColor=[UIColor colorWithRed:55/255.0f green:160/255.0f blue:244/255.0f alpha:1.0f];
    self.layer.cornerRadius=BUTTON_WIDTH/2.0f;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.2;
    self.layer.shadowOffset = CGSizeMake(0, 1);
    self.layer.shadowRadius = 2;
    
    _lable1=[SBLabel CreateLabelWithString:@"Continue" fontSize:16];
    [_lable1 SBLabelSetOffset:CGPointMake(0, -20) withReferencePoint:CGPointMake(0, self.frame.size.height/2.0f)];
    _lable1.textColor=[UIColor whiteColor];
    _lable1.center=CGPointMake(self.frame.size.width/2.0f, _lable1.center.y);
    [self addSubview:_lable1];
    
    _lable2=[SBLabel CreateLabelWithString:@"Key words" fontSize:12];
    [_lable2 SBLabelSetOffset:CGPointMake(0, 10) withReferencePoint:CGPointMake(0, _lable1.frame.origin.y+_lable1.frame.size.height)];
    _lable2.center=CGPointMake(self.frame.size.width/2.0f, _lable2.center.y);
    _lable2.textColor=[UIColor whiteColor];
    [self addSubview:_lable2];
    
    
}


@end
