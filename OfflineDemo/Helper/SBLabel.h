//
//  XJLLabel.h
//  XJLLabel
//
//  Created by dog_47 on 1/19/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBLabel : UILabel


//初始化时，string允许为空
+(SBLabel *)CreateLabelWithString:(NSString *)_str fontSize:(NSInteger)_size;

-(void)SBLabelSetOffset:(CGPoint)_setPoint withReferencePoint:(CGPoint)_thePoint;

-(void)SBLabelSetWidth:(float)_width;

-(void)SBLabelSetWidth:(float)_width atCenterPoint:(CGPoint)_point;

-(void)SBLabelSetNumOfLines:(NSInteger)_num;

-(void)SBLabelSetFontSize:(NSInteger)_fontSize;

-(void)SBLabelSetText:(NSString *)_str;

@end
