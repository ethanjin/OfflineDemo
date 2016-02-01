//
//  BusinessMainController.m
//  ABC360
//
//  Created by dog_47 on 1/11/16.
//  Copyright © 2016 abc360.com. All rights reserved.
//

#import "SBUnitController.h"
#import "SBNavigationController.h"
#import "SBNavigationBar.h"
#import "SBUnitContainerView.h"
#import "SBLessonController.h"
#import "SBUnitListModel.h"
#import "SBTransitionAnimator.h"

@interface SBUnitController ()<SBUnitContainerViewDelegate>
@property(nonatomic, strong) SBUnitListModel *model;
@end

@implementation SBUnitController{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initPushSettings];
    [self initSettings];
    [self fakeData];
//    [self loadData];
}


-(void)initPushSettings{
    self.view.backgroundColor = [UIColor purpleColor];
    SBNavigationBar *navBar =(SBNavigationBar*)self.navigationController.navigationBar;
    [navBar SBNavigationBarsetBackgroundAlphaWithPencentage:0 duration:0];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"prepare_exercises_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItems = @[left];
    self.navigationController.navigationBar.hidden=NO;
}

-(void)back{
    [self.tabBarController setSelectedIndex:0];
    self.tabBarController.tabBar.hidden=NO;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden=YES;
}




-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    SBNavigationBar *navBar =(SBNavigationBar*)self.navigationController.navigationBar;
    [navBar SBNavigationBarResetToDeFault];
}



#pragma mark initSettins
-(void)initSettings{
    self.title=@"Smile Business";
    self.view.backgroundColor=[UIColor colorWithRed:33/255.0f green:35/255.0f blue:47/255.0f alpha:1.0f];
}

-(void)initUnitView{
    SBUnitContainerView *containerView=[SBUnitContainerView creatContainerViewWithData:_model];
    containerView.backgroundColor=[UIColor colorWithRed:54/255.0f green:54/255.0f blue:54/255.0f alpha:1.0f];
    containerView.delegate=self;
    [self.view addSubview:containerView];
    self.automaticallyAdjustsScrollViewInsets=NO;
    

}


-(void)fakeData{
    SBUnitListModel *fakeModel=[[SBUnitListModel alloc]init];
    fakeModel.data=[NSMutableArray new];
    NSInteger num=19;
    for (NSInteger i=0; i<num; i++) {
        SBUnitModel *currentModel=[SBUnitModel new];
        currentModel.name=[NSString stringWithFormat:@"Unit %ld",(long)i];
        currentModel.titleEN=@"The Office NewComer";
        currentModel.titleCN=@"新人报到，请多关照";
        currentModel.count=@(num);
        currentModel.current_position=@(i+1);
        currentModel.type=@(0);
        if (i==19) {
            currentModel.type=@(1);
        }
        int x = (arc4random() % 4)+1;
        currentModel.image=[NSString stringWithFormat:@"%d",x];
        [fakeModel.data addObject:currentModel];
    }
    _model=fakeModel;
    [self initUnitView];
}

//-(void)loadData {
//    __weak SBUnitController *weak=self;
//    
//    [_request exec:^{
//        _model = [_sbApi getUnitList];
//    } finish:^(UVError* error){
//        if (error != nil) {
//            [weak onLoadDataError:error];
//        } else {
//            if (_model == nil || _model.data == nil || _model.data.count == 0) {
//                DDLogError(@"got nil model");
//                return;
//            }
//            [weak initUnitView];
//            
//        }
//        
//    } showProgressInView:self.view message:nil showToast:true];
//}
//
//-(void)onLoadDataError:(UVError*)error {
//    DDLogError(@"onLoadDataError, error:%@", error.message);
//}


#pragma mark delegat
-(void)selectedUnit:(NSInteger)_index{
    NSLog(@"进入Unit:%ld",_index);
    SBUnitModel *themodel=_model.data[_index];
    
    SBLessonController *view=[[SBLessonController alloc]init];
    view.unitTitle=themodel.name;
    view.unitId=themodel.modelId;
    view.titleCN=themodel.titleCN;
    view.titleEN=themodel.titleEN;
    [self.navigationController pushViewController:view animated:YES];
}




@end
