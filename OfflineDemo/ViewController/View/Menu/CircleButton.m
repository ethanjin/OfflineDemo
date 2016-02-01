//
//  CircleButton.m
//  AnimatingButtons
//
//  Created by dog_47 on 1/7/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import "CircleButton.h"

#define BTN_WIDTH ([UIScreen mainScreen].bounds.size.height>=667 ? 70:([UIScreen mainScreen].bounds.size.height==568 ? 50 :40))
#define INNER_WIDTH ([UIScreen mainScreen].bounds.size.height>=667 ? 60:([UIScreen mainScreen].bounds.size.height==568 ? 50 :40))
#define IMG_WIDTH ([UIScreen mainScreen].bounds.size.height>=667 ? 28:([UIScreen mainScreen].bounds.size.height==568 ? 25 :20))


@implementation CircleButton{
    UIImageView *_img;
    UIView *_innerView;
    UILabel *_littleButton;
}


#pragma mark CircleButton.h
-(void)setButtonPosition:(CGPoint)_point{
    self.center=_point;
}



+(CircleButton *)creatButton{
    CGRect theFrame=CGRectMake(0, 0, BTN_WIDTH, BTN_WIDTH);
    id obj=[[CircleButton alloc]initWithFrame:theFrame];
    return obj;
}



#pragma mark init
-(id)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self initSettings];
    }
    return self;
}



#pragma mark setting
-(void)initSettings{
    
    
    self.layer.cornerRadius=BTN_WIDTH/2.0f;
    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f];
    _innerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, INNER_WIDTH, INNER_WIDTH)];
    _innerView.layer.cornerRadius=INNER_WIDTH/2.0f;
    _innerView.backgroundColor=[UIColor colorWithRed:78/255.0f green:84/255.0f blue:94/255.0f alpha:1.0f];
    _innerView.center=CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f);
    [self addSubview:_innerView];
    
    
    _img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IMG_WIDTH, IMG_WIDTH)];
    _img.center=CGPointMake(_innerView.frame.size.width/2.0f, _innerView.frame.size.height/2.0f);
    [_innerView addSubview:_img];
    
    
    
    //小圆点
    _littleButton = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
    _littleButton.backgroundColor = [UIColor whiteColor];
    _littleButton.textColor = [UIColor colorWithRed:0.063f green:0.063f blue:0.063f alpha:1.00f];
    _littleButton.layer.cornerRadius = 8.0;
    _littleButton.layer.masksToBounds = YES;
    _littleButton.font = [UIFont systemFontOfSize:8];
    _littleButton.textAlignment = NSTextAlignmentCenter;
    _littleButton.text = [NSString stringWithFormat:@"%d",(int)self.tag+1];
    
    
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    self.userInteractionEnabled=YES;
    [self addGestureRecognizer:tap1];
    
    
    
    //    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //    self.layer.shadowOpacity = 0.2;
    //    self.layer.shadowOffset = CGSizeMake(0, 1);
    //    self.layer.shadowRadius = 2;
    //    self.backgroundColor=[UIColor colorWithRed:150/255.0f green:150/255.0f blue:150/255.0f alpha:0.7];
    _littleButton.userInteractionEnabled=YES;
    _img.userInteractionEnabled=YES;
    _innerView.userInteractionEnabled=YES;
}

-(void)setLittleButtonPosition:(float)angle Text:(NSInteger)_index{
    float x,y;
    x=sin(angle*M_PI/180)*(BTN_WIDTH-(BTN_WIDTH-INNER_WIDTH))/2.0f;
    y=cos(angle*M_PI/180)*(BTN_WIDTH-(BTN_WIDTH-INNER_WIDTH))/2.0f;
    CGPoint thePoint=CGPointMake(self.frame.size.width/2.0f+x, self.frame.size.height/2.0f+y);
    _littleButton.center=thePoint;
    _littleButton.text=[NSString stringWithFormat:@"%ld",(long)_index];
    [self addSubview:_littleButton];
}

-(void)setLittleButtonHeighted:(BOOL)_value{
    if (_value) {
        _littleButton.backgroundColor=[UIColor colorWithRed:55/255.0f green:160/255.0f blue:244/255.0f alpha:1.0f];
    }else{
        _littleButton.backgroundColor=[UIColor whiteColor];
    }
}



-(void)tap{
    if ([_delegate respondsToSelector:@selector(selectButtonAtIndex:)]) {
        [_delegate selectButtonAtIndex:self.tag];
    }
}

-(void)setStateON:(BOOL)_value{
    if (_value==YES) {
        _innerView.backgroundColor=[UIColor colorWithRed:55/255.0f green:160/255.0f blue:244/255.0f alpha:1.0f];
    }else{
        _innerView.backgroundColor=[UIColor colorWithRed:78/255.0f green:84/255.0f blue:94/255.0f alpha:1.0f];
    }
}

-(void)setImg:(UIImage *)tmpImg{
    _img.image=tmpImg;
}

@end
