//
//  BizUnitListModel.m
//  ABC360
//
//  Created by yushi on 16/1/20.
//  Copyright © 2016年 abc360.com. All rights reserved.
//

#import "SBUnitListModel.h"

@implementation SBUnitListModel

@end

@implementation SBUnitModel
- (NSString *)description {
    return [NSString stringWithFormat:@"id:%ld, titleEN:%@, titleCN:%@, count:%ld, current_position:%ld, image:%@, type:%ld, status:%ld",
            (long)_modelId.integerValue, _titleEN, _titleCN, (long)_count.integerValue, (long)_current_position.integerValue, _image, (long)_type.integerValue, (long)_status.integerValue];
}
@end