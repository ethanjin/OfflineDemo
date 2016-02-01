//
//  SBLessonListModel.m
//  ABC360
//
//  Created by yushi on 16/1/20.
//  Copyright © 2016年 abc360.com. All rights reserved.
//

#import "SBLessonListModel.h"

@implementation SBLessonListModel

@end

@implementation SBLessonModel
-(NSString *)description {
    return [NSString stringWithFormat:@"modelId:%ld, name:%@, titleEN:%@, titleCN:%@, image:%@, type:%ld, status:%ld",
            (long)_modelId.integerValue, _name, _titleEN, _titleCN, _image, (long)_type.integerValue, (long)_status.integerValue];
}
@end