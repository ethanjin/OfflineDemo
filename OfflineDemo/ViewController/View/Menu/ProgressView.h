//
//  ProgressView.h
//  Progress
//
//  Created by dog_47 on 4/26/15.
//  Copyright (c) 2015 SnapFit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationBlockDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface ProgressView : UIView

@property(nonatomic, strong) UIColor *trackTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *progressTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong) UIColor *innerTintColor UI_APPEARANCE_SELECTOR;
@property(nonatomic) NSInteger roundedCorners UI_APPEARANCE_SELECTOR;
@property(nonatomic) CGFloat thicknessRatio UI_APPEARANCE_SELECTOR;
@property(nonatomic) NSInteger clockwiseProgress UI_APPEARANCE_SELECTOR;
@property(nonatomic) CGFloat progress;

@property(nonatomic) CGFloat indeterminateDuration UI_APPEARANCE_SELECTOR;
@property(nonatomic) NSInteger indeterminate UI_APPEARANCE_SELECTOR;

@property(nonatomic,assign) BOOL isStopAnimate;


-(void)animateFromPercent:(float)_value1 ToPercent:(float)_value2;


@end


