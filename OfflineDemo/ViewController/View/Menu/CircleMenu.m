//
//  CircleMenu.m
//  AnimatingButtons
//
//  Created by dog_47 on 1/6/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import "CircleMenu.h"
#import "CircleButton.h"
#import "CenterButton.h"
#import "ProgressView.h"
#import "SBLabel.h"

#define NUM_OF_BUTTONS 7
#define BTN_DISTANCE ([UIScreen mainScreen].bounds.size.height>=667 ? 150:([UIScreen mainScreen].bounds.size.height==568 ? 120 :100))
#define PROGESS_SIZE ([UIScreen mainScreen].bounds.size.height>=667 ? 300:([UIScreen mainScreen].bounds.size.height==568 ? 250 :220))
#define Label_Animation_duration 0.3f

@interface CircleMenu ()<CircleButtonDelegate>


@end

@implementation CircleMenu{
    CGPoint _centerButtonPosition;
    CenterButton *_centerButton;
    NSMutableArray *_buttonsArray;
    ProgressView *_outCircle;
    CGPoint theCenterPoint;
    NSMutableArray *_lableArray;
}


#pragma mark init
+(CircleMenu *)CreatMenu{
    id obj=[[CircleMenu alloc]initWithFrame:[UIScreen mainScreen].bounds];
    return obj;
}



-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        theCenterPoint=CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f+70);
        [self initSettings];
        [self initCenterButton];
        
    }
    return self;
}


#pragma mark Setting
-(void)initSettings{
    //    self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.backgroundColor=[UIColor clearColor];
    _buttonsArray=[NSMutableArray array];
    _lableArray=[NSMutableArray array];
    _outCircle =[[ProgressView alloc]initWithFrame:CGRectMake(theCenterPoint.x-PROGESS_SIZE/2.0f, theCenterPoint.y-PROGESS_SIZE/2.0f, PROGESS_SIZE, PROGESS_SIZE)];
    _outCircle.thicknessRatio=0.2f;
    _outCircle.trackTintColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f];
    [_outCircle animateFromPercent:0 ToPercent:4.0f/7.0f];
    [self addSubview:_outCircle];
    
}


-(void)initCenterButton{
    _centerButton=[CenterButton creatCenterButton];
    [_centerButton setButtonPosition:theCenterPoint];
    _centerButton.alpha=0;
    _centerButton.transform=CGAffineTransformMakeScale(0.001, 0.001);
    [UIView animateWithDuration:0.3 animations:^{
        _centerButton.alpha=1;
        _centerButton.transform=CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        [self initButtons];
    }];
    [self addSubview:_centerButton];
}

-(void)initButtons{
    for (NSInteger i=0; i<NUM_OF_BUTTONS; i++) {
        [self setLabelWithTag:i];
        CircleButton *button=[CircleButton creatButton];
        [button setLittleButtonPosition:[self getButtonAngleWithIndex:i]Text:i+1];
        button.tag=i;
        button.alpha=0;
        button.userInteractionEnabled=YES;
        button.delegate=self;
        [button setButtonPosition:[self getPositionWithIndex:i]];
        button.transform = CGAffineTransformMakeScale(0.001, 0.001);
        switch (i) {
            case 0:
                [button setImg:[UIImage imageNamed:@"lesson_film"]];
                break;
            case 1:
                [button setImg:[UIImage imageNamed:@"lesson_keyword"]];
                break;
            case 2:
                [button setImg:[UIImage imageNamed:@"lesson_Headphones"]];
                break;
            case 3:
                [button setImg:[UIImage imageNamed:@"lesson_roleplay"]];
                break;
            case 4:
                [button setImg:[UIImage imageNamed:@"lesson_1on1class"]];
                break;
            case 5:
                [button setImg:[UIImage imageNamed:@"lesson_videoclass"]];
                break;
            case 6:
                [button setImg:[UIImage imageNamed:@"lesson_tryshare"]];
                break;
                
            default:
                break;
        }
        
        
        [_buttonsArray addObject:button];
        [self addSubview:button];
        [self bringSubviewToFront:button];
        
    }
    for (NSInteger i=0; i<_buttonsArray.count; i++) {
        CircleButton *button=_buttonsArray[i];
        float delayTime = (float) (i * 0.06);
        [self performSelector:@selector(showBubbleWithAnimation:) withObject:button afterDelay:delayTime];
    }
    
    
    
}


#pragma mark Animation
-(void)showBubbleWithAnimation:(CircleButton *)bubble
{
    
    __weak CircleMenu *weak=self;
    CGPoint toPoint=bubble.center;
    bubble.center=_centerButton.center;
    [UIView animateWithDuration:0.25 animations:^{
        bubble.center = toPoint;
        bubble.alpha = 1;
        bubble.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.15 animations:^{
            bubble.transform = CGAffineTransformMakeScale(0.8, 0.8);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.15 animations:^{
                bubble.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                NSArray *tmp=[weak getLabelArrayWithIndex:bubble.tag];
                for (UILabel *label  in tmp) {
                    [UIView animateWithDuration:Label_Animation_duration animations:^{
                        label.alpha=1;
                    }];
                }
            }];
        }];
    }];
}


#pragma mark SetLabel
-(void )setLabelWithTag:(NSInteger)_index{
    CGPoint tmpPoint=[self getPositionWithIndex:_index];
    CGPoint thePoint=CGPointMake(tmpPoint.x, tmpPoint.y+70/2.0f);
    
    SBLabel *label1=[SBLabel CreateLabelWithString:nil fontSize:12];
    label1.textColor=[UIColor whiteColor];
    SBLabel *label2=[SBLabel CreateLabelWithString:nil fontSize:12];
    label2.textColor=[UIColor whiteColor];
    
    
    label1.alpha=0;
    label2.alpha=0;

    
    switch (_index) {
        case 0:
            [label1 SBLabelSetText:@"ABC360 Film"];
            [label2 SBLabelSetText:@"情景剧"];
            break;
        case 1:
            [label1 SBLabelSetText:@"Key Words"];
            [label2 SBLabelSetText:@"关键词"];
            break;
        case 2:
            [label1 SBLabelSetText:@"Listen"];
            [label2 SBLabelSetText:@"听对话"];
            break;
        case 3:
            [label1 SBLabelSetText:@"Role Play"];
            [label2 SBLabelSetText:@"角色扮演"];
            break;
        case 4:
            [label1 SBLabelSetText:@"1 on 1 Class"];
            [label2 SBLabelSetText:@"真人外教课"];
            break;
        case 5:
            [label1 SBLabelSetText:@"Video Class"];
            [label2 SBLabelSetText:@"讲解视频"];
            break;
        case 6:
            [label1 SBLabelSetText:@"Try&Share"];
            [label2 SBLabelSetText:@"配音秀"];
            break;
            
        default:
            break;
    }
    [label1 SBLabelSetOffset:CGPointMake(0, 5) withReferencePoint:thePoint];
    label1.center=CGPointMake(thePoint.x, label1.center.y);
    
    [label2 SBLabelSetOffset:CGPointMake(0, 5) withReferencePoint:CGPointMake(0, label1.frame.origin.y+label1.frame.size.height)];
    label2.center=CGPointMake(thePoint.x, label2.center.y);
    
    [self addSubview:label1];
    [self addSubview:label2];


    
    NSArray *array=@[label1,label2];
    [_lableArray addObject:array];
}

-(NSArray *)getLabelArrayWithIndex:(NSInteger)_index{
    NSArray *tmp=_lableArray[_index];
    return tmp;
}



#pragma mark CalculatePosition
-(CGPoint)getPositionWithIndex:(NSInteger)_index{
    return [self getPositionWithDistance:BTN_DISTANCE index:_index];
}

-(CGPoint)getLabelPositionWithIndex:(NSInteger)_index{
    return [self getPositionWithDistance:BTN_DISTANCE-32 index:_index];
}

- (CGPoint)getPositionWithDistance:(CGFloat)distance index:(NSInteger)_index {
    float x,y;
    float angle=-(_index/(float)NUM_OF_BUTTONS)*360+180;
    x=sin(angle*M_PI/180)*distance;
    y=cos(angle*M_PI/180)*distance;
    CGPoint thePoint=CGPointMake(_centerButton.center.x+x, _centerButton.center.y+y);
    NSLog(@"thePoint %@  index:%ld x:%.0f y:%.0f angle:%f",NSStringFromCGPoint(thePoint),_index,x,y,angle);
    if (_index==0) {
        thePoint=CGPointMake(thePoint.x, thePoint.y-20);
    }
    return thePoint;
}

-(float)getButtonAngleWithIndex:(NSInteger)_index{
    float angle=-(_index/(float)NUM_OF_BUTTONS)*360;
    return angle;
}

#pragma mark Delegat
-(void)selectButtonAtIndex:(NSInteger)_index{
    if ([_delegate respondsToSelector:@selector(circleMenuSelected:)]) {
        [_delegate circleMenuSelected:_index];
    }
    
}

-(void)setButtonState:(CircleMenuState)_state heighted:(BOOL)_value index:(NSInteger)_index{
    CircleButton *selectedButton=_buttonsArray[_index];
    if (_state==Menu_State_Complete) {
        CircleButton *selectedButton=_buttonsArray[_index];
        [selectedButton setStateON:_value];
    }else{
        [selectedButton setLittleButtonHeighted:_value];
    }
}


@end
