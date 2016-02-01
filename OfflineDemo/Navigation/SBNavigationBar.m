//
//  BusinessNavigationBar.m
//  ABC360
//
//  Created by dog_47 on 1/11/16.
//  Copyright © 2016 abc360.com. All rights reserved.
//

#import "SBNavigationBar.h"


@interface SBNavigationBar ()
@property (nonatomic,strong)UIView *systemDefaultBackgroundView;
@end



@implementation SBNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
                _systemDefaultBackgroundView = view;
            }
        }
        
        
        
        if ([self respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
            
            NSArray *list=self.subviews;
            
            for (id obj in list) {
                
                if ([obj isKindOfClass:[UIImageView class]]) {
                    
                    UIImageView *imageView=(UIImageView *)obj;
                    
                    NSArray *list2=imageView.subviews;
                    
                    for (id obj2 in list2) {
                        
                        if ([obj2 isKindOfClass:[UIImageView class]]) {
                            
                            UIImageView *imageView2=(UIImageView *)obj2;
                            
                            imageView2.hidden=YES;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        
    }
    self.translucent=YES;
    return self;
}


-(void)SBNavigationBarsetBackgroundAlphaWithPencentage:(float)value duration:(float)_time{
    [UIView animateWithDuration:_time animations:^{
        _systemDefaultBackgroundView.alpha=value;
    }];
}


-(void)SBNavigationBarsetColor:(UIColor *)_color{
    _systemDefaultBackgroundView.backgroundColor=_color;
}

-(void)SBNavigationBarResetToDeFault{
    self.tintColor=_defaultBarColor;
    _systemDefaultBackgroundView.alpha=1;
}

@end
