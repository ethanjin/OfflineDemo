//
//  SBMenuViewController.m
//  ABC360
//
//  Created by dog_47 on 1/15/16.
//  Copyright © 2016 abc360.com. All rights reserved.
//

#import "SBMenuViewController.h"
//#import "SBPreviewVideoViewController.h"
//#import "SBTeachVideoViewController.h"
//#import "ABC360-Swift.h"
#import "CircleMenu.h"
#import "SBLabel.h"
//#import "SBApi.h"

//#import "SBKeywordsViewController.h"

@interface SBMenuViewController ()<CircleMenuDelegate>
@property (strong,nonatomic) UIImageView *bg;
@property (strong,nonatomic) CircleMenu *menu;
@end

@implementation SBMenuViewController{
    UIView *alphaView;
    SBLabel *_label1;
    SBLabel *_label2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSettings];
    [self initMenu];
//    [self addNotificationObserver];
}

- (void)dealloc {
//    [self removeNotificationObserver];
}


#pragma mark - UI
-(void)initSettings{
    self.title=[NSString stringWithFormat:@"Lesson %ld",(long)_lessonIndex];
    self.view.backgroundColor=[UIColor colorWithRed:33/255.0f green:35/255.0f blue:47/255.0f alpha:1.0f];
    _bg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    _bg.clipsToBounds=YES;
    [_bg setImage:[UIImage imageNamed:@"3_background"]];
    _bg.center=CGPointMake(self.view.frame.size.width/2.0f, (self.view.frame.size.height-64)/2.0f+64);
    [self.view addSubview:_bg];
    
    alphaView=[[UIView alloc]initWithFrame:_bg.bounds];
    alphaView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f];
    [_bg addSubview:alphaView];
    
    _label1=[SBLabel CreateLabelWithString:@"Meeting Your New Boss" fontSize:18];
    [_label1 SBLabelSetOffset:CGPointMake(0, 60) withReferencePoint:CGPointMake(0, 64)];
    if ([UIScreen mainScreen].bounds.size.height==480) {
        [_label1 SBLabelSetOffset:CGPointMake(0, 20) withReferencePoint:CGPointMake(0, 64)];
    }
    
    _label1.textColor=[UIColor whiteColor];
    _label1.center=CGPointMake(self.view.frame.size.width/2.0f, _label1.center.y);
    [self.view addSubview:_label1];
    
    _label2=[SBLabel CreateLabelWithString:_title2 fontSize:18];
    [_label2 SBLabelSetOffset:CGPointMake(0, 12) withReferencePoint:CGPointMake(0, _label1.frame.origin.y+_label1.frame.size.height)];
    _label2.textColor=[UIColor whiteColor];
    _label2.center=CGPointMake(self.view.frame.size.width/2.0f, _label2.center.y);
    [self.view addSubview:_label2];
    
}

-(void)initMenu{
    _menu=[CircleMenu CreatMenu];
    _menu.delegate = self;
    [self.view addSubview:_menu];
}


#pragma mark - Private Methods
- (void)onLessionStatusChanged:(NSNotification *)notif {
    NSDictionary *info = notif.userInfo;
    NSInteger index = [info[@"idx"] integerValue];      // 序号 从1开始
    NSInteger status = [info[@"status"] integerValue];  //1 代表学习中  2代表学习完成
    NSLog(@"课程：%d, 状态：%d",(int)index,(int)status);
    
    // 刷新本地视图
    [_menu setButtonState:((status==1)? Menu_State_Learning :Menu_State_Complete) heighted:YES index:index-1];
    
    // 更新服务端数据
}


#pragma mark - NewWork 网络请求



#pragma mark - Lesson Action 
// 视频预习 情景剧
//- (void)showPrepareVideo {
//    // 获取视频相关信息
//    __block SBPreviewVideoModel *model   = [SBPreviewVideoModel new];
//    __weak  typeof(self)        weakSelf = self;
//    [_request exec:^{
//        model = [weakSelf.sbApi getPreviewVideo:@1];
//    } finish:^(UVError *error) {
//        if (error) {
//            return;
//        }
//        SBPreviewVideoViewController *videoController = [[SBPreviewVideoViewController alloc] init];
//        videoController.previewModel = model;
//        videoController.url          = [NSURL URLWithString:model.url];
//        [weakSelf presentViewController:videoController animated:true completion:^{}];
//    } showProgressInView:nil
//      message:nil
//      showToast:YES];
//}
//
//// 关键词
//- (void)showKeyWordsView {
//    SBKeywordsViewController *controller = [SBKeywordsViewController new];
//    [self.navigationController pushViewController:controller animated:YES];
//}
//
//// 听对话
//- (void)showListenView {
//    __weak  typeof(self) weakSelf = self;
//    __block NSArray *    lists;
//    [_request exec:^{
//        lists = [weakSelf.sbApi listenList];
//    } finish:^(UVError *error) {
//        if (error) {
//            return;
//        }
//        SBListenViewController *listenController = [[SBListenViewController alloc] init];
//        listenController.audioList = lists;
//        [self.navigationController pushViewController:listenController animated:YES];
//    } showProgressInView:nil
//           message:nil
//         showToast:YES];
//}
//
//// 角色扮演
//- (void)showRolePlayView {
//    
//}
//
//// 真人外教
//- (void)showOneOnOneClassView {
//    
//}
//
//// 讲解视屏
//- (void)showVideoClassView {
//    // 获取视频相关信息
//    __block SBPreviewVideoModel *model   = [SBPreviewVideoModel new];
//    __weak  typeof(self)        weakSelf = self;
//    [_request exec:^{
//        model = [weakSelf.sbApi getPreviewVideo:@1];
//    } finish:^(UVError *error) {
//        if (error) {
//            return;
//        }
//        SBTeachVideoViewController *videoController = [[SBTeachVideoViewController alloc] init];
////        videoController.previewModel = model;
//        videoController.url          = [NSURL URLWithString:model.url];
//        [weakSelf presentViewController:videoController animated:true completion:^{}];
//    } showProgressInView:nil
//      message:nil
//      showToast:YES];
//}
//
//// 配音秀
//- (void)showTryShareView {
//    
//}
//
//
//#pragma mark - CircleMenuDelegate
//-(void)circleMenuSelected:(NSInteger)_index{
//    switch (_index) {
//        case 0:
//            [self showPrepareVideo];
//            break;
//        case 1:
//            [self showKeyWordsView];
//            break;
//        case 2:
//            [self showListenView];
//            break;
//        case 3:
//            [self showRolePlayView];
//            break;
//        case 4:
//            [self showOneOnOneClassView];
//            break;
//        case 5:
//            [self showVideoClassView];
//            break;
//        case 6:
//            [self showTryShareView];
//            break;
//            
//        default:
//            break;
//    }
//}
//
//
//#pragma mark - Observer
//- (void)addNotificationObserver {
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onLessionStatusChanged:) name:kOnFinishedLessionNotification object:nil];
//}
//
//- (void)removeNotificationObserver {
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
//}



@end
