//
//  XJLLabel.m
//  XJLLabel
//
//  Created by dog_47 on 1/19/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import "SBLabel.h"

@implementation SBLabel{
    CGSize _labelSize;
}


+(SBLabel *)CreateLabelWithString:(NSString *)_str fontSize:(NSInteger)_size{
    id obj=[[SBLabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0) Str:_str fontSize:_size];
    return obj;
}

-(id)initWithFrame:(CGRect)frame Str:(NSString *)_str fontSize:(NSInteger)_size{
    if (self=[super initWithFrame:frame]) {
        
        self.font=[UIFont systemFontOfSize:_size];
        
        if (_str!=nil) {
            self.text=_str;
            NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
            CGSize sizeText = [self.text boundingRectWithSize:CGSizeMake(1000, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
            self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeText.width, sizeText.height);
        }
    }
    return self;
}

-(void)SBLabelSetOffset:(CGPoint)_setPoint withReferencePoint:(CGPoint)_thePoint{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
    CGSize sizeText = [self.text boundingRectWithSize:CGSizeMake(1000, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.frame=CGRectMake(_thePoint.x+_setPoint.x, _thePoint.y+_setPoint.y,sizeText.width, sizeText.height);
}

-(void)SBLabelSetWidth:(float)_width{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
    CGSize sizeText = [self.text boundingRectWithSize:CGSizeMake(1000, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, _width, sizeText.height);
}

-(void)SBLabelSetWidth:(float)_width atCenterPoint:(CGPoint)_point{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
    CGSize sizeText = [self.text boundingRectWithSize:CGSizeMake(1000, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.frame=CGRectMake(_point.x-_width/2.0f, _point.y-sizeText.height/2.0f, _width, sizeText.height);
}

-(void)SBLabelSetNumOfLines:(NSInteger)_num{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
    CGSize sizeText = [self.text boundingRectWithSize:CGSizeMake(1000, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.numberOfLines=_num;
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, sizeText.height*_num);
}

-(void)SBLabelSetFontSize:(NSInteger)_fontSize{
    self.font=[UIFont systemFontOfSize:_fontSize];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:_fontSize],NSFontAttributeName,nil];
    CGSize sizeText = [self.text boundingRectWithSize:CGSizeMake(1000, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeText.width, sizeText.height);
}

-(void)SBLabelSetText:(NSString *)_str{
    self.text=_str;
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:self.font,NSFontAttributeName,nil];
    CGSize sizeText = [self.text boundingRectWithSize:CGSizeMake(1000, [UIScreen mainScreen].bounds.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeText.width, sizeText.height);
}


@end
