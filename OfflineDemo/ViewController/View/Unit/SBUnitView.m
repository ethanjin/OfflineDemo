//
//  SBUnitView.m
//  ScrollViewContainer
//
//  Created by dog_47 on 1/12/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import "SBUnitView.h"
#import "SBLabel.h"


#define Close_height 90.0f
#define Open_height 187.5f
#define Close_animation_duration 0.2f
#define Open_animation_duration 0.3f
#define MoveUp_animation_duration 0.2f
#define MoveDown_animation_duration 0.3f
#define POINT_WIDTH 28
#define LINE_WIDTH 4


@interface SBUnitView ()

@property (assign,nonatomic) UnitType unitType;

@end


@implementation SBUnitView{
    UIView *_alphaView;
    UIView *_lineView;
    UIView *_pointView;
    UIView *_lineUp;
    UIView *_lineDown;
    SBLabel *_label1;
    SBLabel *_label2;
    SBLabel *_label3;
    SBUnitModel *_dataModel;
}



+(SBUnitView *)CreateUnitViewWithIndex:(NSInteger)_index andData:(SBUnitModel *)_model type:(UnitType)_type{
    id obj=[[SBUnitView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, Close_height) index:_index andData:_model type:_type];
    return obj;
}

-(id)initWithFrame:(CGRect)frame index:(NSInteger)_index andData:(SBUnitModel *)_model type:(UnitType)_type{
    self=[super initWithFrame:frame];
    if (self) {
        _unitType=_type ;
        _dataModel=_model;
        self.unitIndex=_index;
        [self initSettings];
        [self setUpPoint];
        [self setUpLabel];
    }
    return self;
}


-(void)initSettings{
    self.clipsToBounds=YES;
    _isOpen=NO;
    _offsetDistance=Open_height-Close_height;
    self.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent)];
    [self addGestureRecognizer:tap];
    
    
    _imgView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, Open_height)];
    [_imgView setImage:[UIImage imageNamed:_dataModel.image]];
    _imgView.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:_imgView];
    
    _alphaView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, Open_height)];
    _alphaView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.85f];
    [self addSubview:_alphaView];
    
    _lineView=[[UIView alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
    _lineView.backgroundColor=[UIColor colorWithRed:56/255.0f green:54/255.0f blue:53/255.0f alpha:1.0f];
    [self addSubview:_lineView];
    
    
}

-(void)setUpPoint{
    _pointView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, POINT_WIDTH, POINT_WIDTH)];
    _pointView.layer.cornerRadius=POINT_WIDTH/2.0f;
    _pointView.center=CGPointMake(15+POINT_WIDTH/2.0f, Close_height/2.0f);
    _pointView.backgroundColor=[UIColor whiteColor];
    if (_unitType==UnitNomal) {
        SBLabel *label=[SBLabel CreateLabelWithString:[NSString stringWithFormat:@"%ld",(long)(_unitIndex+1)] fontSize:16];
        label.textColor=[UIColor blackColor];
        label.center=CGPointMake(_pointView.frame.size.width/2.0f, _pointView.frame.size.height/2.0f);
        [_pointView addSubview:label];
    }else{
        UIImageView *img=[[UIImageView alloc]initWithFrame:_pointView.bounds];
        img.image=[UIImage imageNamed:@"SB_Unit_ceping"];
        img.center=CGPointMake(_pointView.frame.size.width/2.0f, _pointView.frame.size.height/2.0f);
        [_pointView addSubview:img];
    }
    
    _lineUp=[[UIView alloc]initWithFrame:CGRectMake(0, _pointView.center.y, LINE_WIDTH, -Close_height/2.0f)];
    _lineUp.center=CGPointMake(_pointView.center.x, _lineUp.center.y);
    _lineUp.backgroundColor=[UIColor whiteColor];
    if (_unitIndex!=0) {
        [self addSubview:_lineUp];
    }
    
    _lineDown=[[UIView alloc]initWithFrame:CGRectMake(0, _pointView.center.y, LINE_WIDTH, Close_height/2.0f)];
    _lineDown.center=CGPointMake(_pointView.center.x, _lineDown.center.y);
    _lineDown.backgroundColor=[UIColor whiteColor];
    [self addSubview:_lineDown];
    [self addSubview:_pointView];
}


-(void)setUpLabel{
    _label1=[SBLabel CreateLabelWithString:_dataModel.titleEN fontSize:16];
    [_label1 SBLabelSetOffset:CGPointMake(60, 5) withReferencePoint:CGPointZero];
    _label1.textColor=[UIColor colorWithRed:69/255.0f green:113/255.0f blue:145/255.f alpha:1.0f];
    [_label1 SBLabelSetFontSize:16];
    [self addSubview:_label1];
    
    _label2=[SBLabel CreateLabelWithString:_dataModel.titleCN fontSize:14];
    [_label2 SBLabelSetOffset:CGPointMake(0, 12) withReferencePoint:CGPointMake(_label1.frame.origin.x, _label1.frame.origin.y+_label1.frame.size.height)];
    _label2.textColor=[UIColor colorWithRed:148/255.0f green:148/255.0f blue:148/255.0f alpha:1.0f];
    [_label2 SBLabelSetFontSize:14];
    [self addSubview:_label2];
    
    _label3=[SBLabel CreateLabelWithString:[NSString stringWithFormat:@"%ld/%ld",(long)_dataModel.current_position.integerValue,(long)_dataModel.count.integerValue] fontSize:14];
    [_label3 SBLabelSetOffset:CGPointMake(0, 15) withReferencePoint:CGPointMake(_label2.frame.origin.x, _label2.frame.origin.y+_label2.frame.size.height)];
    _label3.textColor=[UIColor whiteColor];
    [_label3 SBLabelSetFontSize:14];
    [self addSubview:_label3];
    
}

-(void)tapEvent{
    if ([_delegate respondsToSelector:@selector(selectedUnit:)]) {
        [_delegate selectedUnit:self.unitIndex];
    }
}



-(void)collaspeAnimationCompletion:(void (^)(BOOL isOpen))_completion{
    __weak SBUnitView *weak=self;
    [UIView animateWithDuration:_isOpen ? Close_animation_duration : Open_animation_duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _isOpen ? Close_height : Open_height);
        if (_isOpen==YES) {
            //收缩
            [weak first_closeContent];
        }else{
            //展开
            [weak first_openContent];
        }
         
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:_isOpen ? Close_animation_duration : Open_animation_duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            if (_isOpen==YES) {
                //收缩完成
                [weak second_closeComplete];
            }else{
                //展开完成
                [weak second_openComplete];
            }
        } completion:^(BOOL finished) {

        }];
        
        
        
        _isOpen=!_isOpen;
        if (_completion != NULL) {
            _completion(_isOpen);
        }
    }];
}


#pragma mark changeContent
-(void)first_openContent{
    _alphaView.alpha=0.3;
    _lineUp.hidden=YES;
    _lineDown.hidden=YES;
    _pointView.center=CGPointMake(_pointView.center.x, Open_height/2.0f);
    _lineUp.frame=CGRectMake(_lineUp.frame.origin.x, Open_height/2.0f,LINE_WIDTH, 0);
    _lineDown.frame=CGRectMake(_lineDown.frame.origin.x, Open_height/2.0f,LINE_WIDTH, 0);
    _lineView.frame=CGRectMake(0, Open_height-1, self.frame.size.width, 1);
}

-(void)first_closeContent{
    _alphaView.alpha=1;
    _pointView.center=CGPointMake(_pointView.center.x, Close_height/2.0f);
    _lineUp.frame=CGRectMake(_lineUp.frame.origin.x, Close_height/2.0f,LINE_WIDTH, -Close_height/2.0f);
    _lineDown.frame=CGRectMake(_lineDown.frame.origin.x, Close_height/2.0f,LINE_WIDTH, Close_height/2.0f);
    _lineView.frame=CGRectMake(0, Close_height-1, self.frame.size.width, 1);
    
    [_label1 SBLabelSetOffset:CGPointMake(60, 5) withReferencePoint:CGPointZero];
    _label1.textColor=[UIColor colorWithRed:69/255.0f green:113/255.0f blue:145/255.f alpha:1.0f];
    
    [_label2 SBLabelSetOffset:CGPointMake(0, 12) withReferencePoint:CGPointMake(_label1.frame.origin.x, _label1.frame.origin.y+_label1.frame.size.height)];
    _label2.textColor=[UIColor colorWithRed:148/255.0f green:148/255.0f blue:148/255.0f alpha:1.0f];
    
    [_label3 SBLabelSetOffset:CGPointMake(0, 15) withReferencePoint:CGPointMake(_label2.frame.origin.x, _label2.frame.origin.y+_label2.frame.size.height)];
    _label3.textColor=[UIColor whiteColor];
}


-(void)second_openComplete{
    _lineUp.hidden=NO;
    _lineDown.hidden=NO;
    [UIView animateWithDuration:Open_animation_duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        _lineUp.frame=CGRectMake(_lineUp.frame.origin.x, Open_height/2.0f,LINE_WIDTH, -Open_height/2.0f);
        _lineDown.frame=CGRectMake(_lineDown.frame.origin.x, Open_height/2.0f,LINE_WIDTH, Open_height/2.0f);
        _lineView.frame=CGRectMake(0, Open_height-1, self.frame.size.width, 1);
        
        _label1.center=CGPointMake(self.frame.size.width/2.0f, self.frame.size.height/2.0f-20);
        _label2.center=CGPointMake(self.frame.size.width/2.0f, _label1.center.y+_label1.frame.size.height/2.0f+15);
        _label3.center=CGPointMake(self.frame.size.width/2.0f, _label2.center.y+_label2.frame.size.height/2.0f+15);
        _label1.textColor=[UIColor whiteColor];
        _label2.textColor=[UIColor whiteColor];
        _label3.textColor=[UIColor whiteColor];
    } completion:^(BOOL finished) {
    
    }];
}

-(void)second_closeComplete{

}

-(void)pointAnimation{

}
-(void)lineAnimation{

}

#pragma mark SBUnitView.h
-(void)moveUp{
    [UIView animateWithDuration:MoveUp_animation_duration delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.frame=CGRectMake(0, self.frame.origin.y-(Open_height-Close_height), self.frame.size.width, self.frame.size.height);
    } completion:nil];
}

-(void)moveDown{
    [UIView animateWithDuration:MoveDown_animation_duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame=CGRectMake(0, self.frame.origin.y+(Open_height-Close_height), self.frame.size.width, self.frame.size.height);
    } completion:nil];
}

-(void)setPosition:(CGPoint)_point{
    self.frame=CGRectMake(_point.x, _point.y, self.frame.size.width, self.frame.size.height);
}

-(void)setUpLabelWithArray:(NSArray *)_array{
    NSString *str1=_array[0];
    NSString *str2=_array[1];
    NSString *str3=_array[2];
    [_label1 SBLabelSetText:str1];
    [_label2 SBLabelSetText:str2];
    [_label3 SBLabelSetText:str3];
    
    
}


@end
