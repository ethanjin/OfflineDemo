//
//  SBWord.h
//  ABC360
//
//  Created by chenjiaxin on 16/1/27.
//  Copyright © 2016年 abc360.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SBWord : NSObject
//单词拼写
@property (nonatomic) NSString *word;
//单词音标
@property (nonatomic) NSString *phonogram;
//词性
@property (nonatomic) NSString *word_class;
//中文释义
@property (nonatomic) NSString *meaning_cn;
//英文释义
@property (nonatomic) NSString *meaning_en;
//单词发音url
@property (nonatomic) NSString *word_sound_url;
//英文例句
@property (nonatomic) NSString *example_en;
//例句中高亮单词
@property (nonatomic) NSString *example_word;
//例句中文翻译
@property (nonatomic) NSString *example_cn;
//例句mp3 URL 
@property (nonatomic) NSString *example_sound_url;

@property (nonatomic)BOOL wordSoundPlaying;
@property (nonatomic)BOOL exampleSoundPlaying;
@end
