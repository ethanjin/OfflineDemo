//
//  BizUnitListModel.h
//  ABC360
//
//  Created by yushi on 16/1/20.
//  Copyright © 2016年 abc360.com. All rights reserved.
//

//#import "UVIdEntity.h"
#import "SBUnitListModel.h"
#import <Foundation/Foundation.h>

typedef NS_ENUM(BOOL,UnitType) {
    UnitNomal=0,
    UnitTest=1
};

@interface SBUnitListModel : NSObject
@property (nonatomic, strong) NSMutableArray *data;
@end

@interface SBUnitModel: NSObject //UVIdEntity
@property (nonatomic, strong) NSNumber *modelId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *titleEN;
@property (nonatomic, strong) NSString *titleCN;
@property (nonatomic, strong) NSNumber *count;
@property (nonatomic, strong) NSNumber *current_position;
@property (nonatomic, strong) NSString *image;

//todo eric 定义常量
@property (nonatomic, strong) NSNumber *type; //0为正常unit, 1为上完10个单元后的单元测评课本
@property (nonatomic, strong) NSNumber *status; //0解锁，1为上锁

@end


