//
//  CircleButton.h
//  AnimatingButtons
//
//  Created by dog_47 on 1/7/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol CircleButtonDelegate <NSObject>

-(void)selectButtonAtIndex:(NSInteger)_index;

@end


@interface CircleButton : UIView
+(CircleButton *)creatButton;


@property (assign,nonatomic) id<CircleButtonDelegate> delegate;
-(void)setButtonPosition:(CGPoint)_point;
-(void)setLittleButtonPosition:(float)angle Text:(NSInteger)_index;
-(void)setLittleButtonHeighted:(BOOL)_value;
-(void)setImg:(UIImage *)_img;
-(void)setStateON:(BOOL)_value;
@end
