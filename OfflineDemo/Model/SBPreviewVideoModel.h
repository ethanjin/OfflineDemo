//
//  BizPreviewVideoModel.h
//  ABC360
//
//  Created by yushi on 16/1/21.
//  Copyright © 2016年 abc360.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBPreviewVideoModel : NSObject
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSMutableArray *data;
@end

@interface SBPreviewQuestionModel: NSObject
@property (nonatomic, strong) NSString *question;
@property (nonatomic, strong) NSMutableArray<NSString*> *options;
@property (nonatomic, strong) NSNumber *answer;
@property (nonatomic, strong) NSNumber *goBackTime;
@property (nonatomic, strong) NSNumber *showTime;
@end



