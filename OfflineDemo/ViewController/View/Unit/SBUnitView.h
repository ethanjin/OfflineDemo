//
//  SBUnitView.h
//  ScrollViewContainer
//
//  Created by dog_47 on 1/12/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBUnitListModel.h"


@protocol SBUnitViewDelegate <NSObject>

-(void)selectedUnit:(NSInteger)_index;

@end


@interface SBUnitView : UIView

@property (assign,nonatomic) BOOL isOpen;
@property (assign,nonatomic) id<SBUnitViewDelegate> delegate;
@property (assign,nonatomic) float offsetDistance;
@property (assign,nonatomic) NSInteger currentUnit;
@property (assign,nonatomic) NSInteger unitIndex;
@property (strong,nonatomic) UIImageView *imgView;

+(SBUnitView *)CreateUnitViewWithIndex:(NSInteger)_index andData:(SBUnitModel *)_model type:(UnitType)_type;

-(void)collaspeAnimationCompletion:(void (^)(BOOL isOpen))completion;
-(void)setPosition:(CGPoint)_point;


-(void)moveUp;
-(void)moveDown;
-(void)setUpLabelWithArray:(NSArray *)_array;
@end

