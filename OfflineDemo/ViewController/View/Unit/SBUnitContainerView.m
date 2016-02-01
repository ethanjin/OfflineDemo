//
//  ContainerView.m
//  ScrollViewContainer
//
//  Created by dog_47 on 1/12/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import "SBUnitContainerView.h"
#import "SBUnitView.h"

typedef NS_ENUM(NSInteger,MOVE_Direction) {
    UNIT_UP,
    UNIT_DOWN
    
};


@interface SBUnitContainerView()<SBUnitViewDelegate>

@property (strong,nonatomic) UIScrollView *containerView;

@end

@implementation SBUnitContainerView{
    CGRect _frame;
    NSMutableArray *_allUnitViews;
    NSInteger _currentUnitIndex;
    SBUnitListModel *_dataModel;
}

+(SBUnitContainerView *)creatContainerViewWithData:(SBUnitListModel *)theModel{
    id obj=[[SBUnitContainerView alloc]initWithFrame:CGRectMake(0, 64 , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) andData:theModel];
    return obj;
}


-(id)initWithFrame:(CGRect)frame andData:(SBUnitListModel *)theModel{
    self=[super initWithFrame:frame];
    if (self) {
        _dataModel=theModel;
        _frame=frame;
        [self initSettings];
        [self initUnitView];
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        _frame=frame;
        [self initSettings];
        [self initUnitView];
    }
    return self;
}

-(void)initSettings{
    self.clipsToBounds=YES;
    _allUnitViews=[NSMutableArray array];
    self.backgroundColor=[UIColor clearColor];
    _containerView=[[UIScrollView alloc]initWithFrame:self.bounds];
    [_containerView setContentSize:CGSizeMake(self.frame.size.width, 90*_dataModel.data.count+97.5f)];
    _containerView.showsVerticalScrollIndicator=NO;
    _containerView.decelerationRate=0.01f;

    
    [self addSubview:_containerView];
    
    
    
}

-(void)initUnitView{
    NSInteger UnitCount=1;
    NSInteger TestCount=-1;
    for (NSInteger i=0; i<_dataModel.data.count; i++) {
        SBUnitModel *theModel=_dataModel.data[i];
        SBUnitView *unit;
        if (theModel.type.integerValue==UnitTest) {
            unit=[SBUnitView CreateUnitViewWithIndex:i andData:theModel type:UnitTest];
            UnitCount=TestCount;
            TestCount=TestCount-1;
        }else{
            unit=[SBUnitView CreateUnitViewWithIndex:i andData:theModel type:UnitNomal];
            unit.currentUnit=UnitCount;
            UnitCount++;
        }
        unit.delegate=self;
        unit.center=CGPointMake(self.frame.size.width/2.0f, 45+i*90);
        [_allUnitViews addObject:unit];
        [_containerView addSubview:unit];
    }
}



#pragma mark CollaseUnitView
-(void)firstStep{
    NSLog(@"第一步");
    __weak SBUnitContainerView *weak=self;
    for (NSInteger i=0; i<_allUnitViews.count; i++) {
        SBUnitView *tmpUnit=_allUnitViews[i];
        if (tmpUnit.isOpen==YES) {
            [tmpUnit collaspeAnimationCompletion:^(BOOL isOpen) {
                [weak secondStep];
            }];
            [self moveOtherUnitWithDirection:UNIT_UP UnitIndex:tmpUnit.unitIndex+1];
            break;
        }
    }
}

-(void)secondStep{
    NSLog(@"第二步\n\n");
    __weak SBUnitContainerView *weak=self;
    SBUnitView *tmpUnit=_allUnitViews[_currentUnitIndex];
    [tmpUnit collaspeAnimationCompletion:^(BOOL isOpen) {
        [weak allUnitViewTouchEnabel:YES];
    }];
    [self moveOtherUnitWithDirection:UNIT_DOWN UnitIndex:tmpUnit.unitIndex+1];
}


-(void)moveOtherUnitWithDirection:(MOVE_Direction)_value UnitIndex:(NSInteger)_index{
    for (NSInteger i=_index; i<_allUnitViews.count; i++) {
        SBUnitView *tmpUnit=_allUnitViews[i];
        if (tmpUnit.isOpen==NO) {
            if (_value==UNIT_UP) {
                [tmpUnit moveUp];
            }else{
                [tmpUnit moveDown];
            }
        }
    }
}


#pragma mark SBUnitViewTouchEnable
-(void)allUnitViewTouchEnabel:(BOOL)value{
    for (SBUnitView *tmp in _allUnitViews) {
        tmp.userInteractionEnabled=value;
    }
}

#pragma mark delegate
-(void)selectedUnit:(NSInteger)_index{
    //进入下个页面
    SBUnitView *selectedUnitView= [self getUnitViewWithIndex:_index];
    if (selectedUnitView.isOpen==YES) {
        if ([_delegate respondsToSelector:@selector(selectedUnit:)]) {
            [_delegate selectedUnit:selectedUnitView.unitIndex];
        }
        return;
    }
    
    
    //不push新页面
    [self allUnitViewTouchEnabel:NO];
    BOOL hasOneOpen=NO;
    for (SBUnitView *tmpUnit in _allUnitViews) {
        if (tmpUnit.isOpen==YES) {
            hasOneOpen=YES;
            break;
        }
    }
    __weak SBUnitContainerView *weak=self;
    _currentUnitIndex=_index;
    //无任何展开项
    if (hasOneOpen==NO) {
        SBUnitView *touchedUnit= [self getUnitViewWithIndex:_index];
        [touchedUnit collaspeAnimationCompletion:^(BOOL isOpen) {
            [weak allUnitViewTouchEnabel:YES];
        }];
        [self moveOtherUnitWithDirection:UNIT_DOWN UnitIndex:touchedUnit.unitIndex+1];
        
    }
    //已经存在展开项
    else{
        [self firstStep];
    }
    NSLog(@"选择了Unit %ld",_index);
}



#pragma mark UnitViewUtils
-(SBUnitView *)getUnitViewWithIndex:(NSInteger)_index{
    SBUnitView *theUnit;
    for (SBUnitView *tmpUnit in _allUnitViews) {
        if (tmpUnit.unitIndex==_index) {
            theUnit=tmpUnit;
            break;
        }
    }
    return theUnit;
}


@end
