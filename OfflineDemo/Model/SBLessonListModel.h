//
//  SBLessonListModel.h
//  ABC360
//
//  Created by yushi on 16/1/20.
//  Copyright © 2016年 abc360.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBLessonListModel : NSObject
@property (nonatomic, strong) NSString *unitDescription;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSMutableArray *data;

@end


@interface SBLessonModel: NSObject //UVIdEntity
@property (nonatomic, strong) NSNumber *modelId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *titleEN;
@property (nonatomic, strong) NSString *titleCN;
@property (nonatomic, strong) NSString *image;

//todo eric 定义常量
@property (nonatomic, strong) NSNumber *type; //0为正常lesson, 1为上完所有lesson后的，1v2测评课
@property (nonatomic, strong) NSNumber *status; //0解锁，1为上锁

@end