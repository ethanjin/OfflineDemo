//
//  BusinessNavigationBar.h
//  ABC360
//
//  Created by dog_47 on 1/11/16.
//  Copyright © 2016 abc360.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBNavigationBar : UINavigationBar


@property (strong,nonatomic) UIColor *defaultBarColor;

/**
 *   设置NavigationBar透明度 百分比,动画时间
 */
-(void)SBNavigationBarsetBackgroundAlphaWithPencentage:(float)value duration:(float)_time;

/**
 *   设置NavigationBar颜色
 */
-(void)SBNavigationBarsetColor:(UIColor *)_color;


/**
 *   设置后必须在ViewWillDisappear中重置NavigationBar，避免全局影响
 */
-(void)SBNavigationBarResetToDeFault;

@end
