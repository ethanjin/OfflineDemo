//
//  SBLessonController.m
//  ABC360
//
//  Created by dog_47 on 1/13/16.
//  Copyright © 2016 abc360.com. All rights reserved.
//

#import "SBLessonController.h"
#import "SBCollectionViewLayout.h"
#import "SBLessonCollectionViewCell.h"
#import "SBMenuViewController.h"
#import "SBLabel.h"
#import "SBLessonListModel.h"


#define Card_Width  ([UIScreen mainScreen].bounds.size.height>=667 ? 150:([UIScreen mainScreen].bounds.size.height==568 ? 150 :150*0.8f))
#define Card_Height ([UIScreen mainScreen].bounds.size.height>=667 ? 290:([UIScreen mainScreen].bounds.size.height==568 ? 290 :290*0.8f))
#define Card_insect ([UIScreen mainScreen].bounds.size.height>667 ? 149:([UIScreen mainScreen].bounds.size.height==667 ? 130 :([UIScreen mainScreen].bounds.size.height==568 ? 103 :103)))

@interface SBLessonController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) SBLessonListModel *model;
@property (strong,nonatomic) UICollectionView *myCollectionView;
@end

@implementation SBLessonController{
    SBLabel *_label1;
    SBLabel *_label2;
    SBLabel *_label3;
    UIImageView *_backgroundIMG;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSettings];
    [self fakeData];
//    [self loadData];
}


-(void)fakeData{
    SBLessonListModel *fakeModel=[[SBLessonListModel alloc]init];
    fakeModel.unitDescription=@"初入职场，该如何用英语和同事们熟络起来呢？快点来学习！另外，你还将认识到很多有趣的人和事情，赶紧开始学起来吧。";
    fakeModel.data=[NSMutableArray new];
    NSInteger num=19;
    for (NSInteger i=0; i<num; i++) {
        SBLessonModel *currentModel=[SBLessonModel new];
        currentModel.name=[NSString stringWithFormat:@"Unit %ld",(long)i];
        currentModel.titleEN=@"The Office NewComer";
        currentModel.titleCN=@"新人报到，请多关照";
        currentModel.status=@(0);
        if (i>5) {
            currentModel.status=@(1);
        }
        int x = (arc4random() % 4)+1;
        currentModel.image=[NSString stringWithFormat:@"%d",x];
        [fakeModel.data addObject:currentModel];
    }
    _model=fakeModel;
    [self initCollectionView];
}

#pragma mark loadData
//-(void)loadData {
//    __weak SBLessonController *weak=self;
//    
//    [_request exec:^{
//        _model = [_sbApi getLessonList:_unitId];
//        
//    } finish:^(UVError* error){
//        if (error != nil) {
//            [weak onLoadDataError:error];
//        } else {
//            if (_model == nil || _model.data == nil || _model.data.count == 0) {
//                DDLogError(@"got nil model");
//                return;
//            }
//            [weak initCollectionView];
//            
//        }
//        
//    }];
//    
//}
//
//-(void)onLoadDataError:(UVError*)error {
//    DDLogError(@"onLoadDataError, error:%@", error.message);
//}


-(void)initSettings{
    if (_unitTitle!=nil) {
        self.title=_unitTitle;
    }

    self.view.backgroundColor=[UIColor colorWithRed:33/255.0f green:35/255.0f blue:47/255.0f alpha:1.0f];
    _backgroundIMG=[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [_backgroundIMG setImage:[UIImage imageNamed:@"lesson_background"]];
    [self.view addSubview:_backgroundIMG];
    UIView *alphaView=[[UIView alloc]initWithFrame:_backgroundIMG.bounds];
    alphaView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f];
    [_backgroundIMG addSubview:alphaView];
 
    _label1=[SBLabel CreateLabelWithString:_titleEN fontSize:18];
    _label1.textColor=[UIColor whiteColor];
    [_label1 SBLabelSetOffset:CGPointMake(0, 59) withReferencePoint:CGPointMake(0, 64)];
    if ([UIScreen mainScreen].bounds.size.height==568) {
        [_label1 SBLabelSetOffset:CGPointMake(0, 20) withReferencePoint:CGPointMake(0, 64)];
    }
    if ([UIScreen mainScreen].bounds.size.height==480) {
        [_label1 SBLabelSetOffset:CGPointMake(0, 10) withReferencePoint:CGPointMake(0, 64)];
        [_label1 SBLabelSetFontSize:14];
    }
    
    _label1.center=CGPointMake(self.view.frame.size.width/2.0f, _label1.center.y);
    [self.view addSubview:_label1];
    
    _label2=[SBLabel CreateLabelWithString:_titleCN fontSize:18];
    _label2.textColor=[UIColor whiteColor];
    [_label2 SBLabelSetOffset:CGPointMake(0, 20) withReferencePoint:CGPointMake(0, _label1.frame.origin.y+_label1.frame.size.height)];
    if ([UIScreen mainScreen].bounds.size.height==480) {
        [_label2 SBLabelSetOffset:CGPointMake(0, 10) withReferencePoint:CGPointMake(0, _label1.frame.origin.y+_label1.frame.size.height)];
        [_label2 SBLabelSetFontSize:14];
    }
    _label2.center=CGPointMake(self.view.frame.size.width/2.0f, _label2.center.y);
    [self.view addSubview:_label2];
    
    
}

-(void)initCollectionView{
//    [_backgroundIMG loadRemoteImageByUrl:_model.image holder:[UIImage imageNamed:@"lesson_background"]];
    
    
    SBCollectionViewLayout *flowLayout= [[SBCollectionViewLayout alloc]init];
    flowLayout.itemSize=CGSizeMake(Card_Width/(flowLayout.scaleFactor+1), Card_Height/(flowLayout.scaleFactor+1));

    flowLayout.sectionInset=UIEdgeInsetsMake(0, Card_insect, 0, Card_insect);
    flowLayout.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    _myCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-70-Card_Height, self.view.frame.size.width, Card_Height*(flowLayout.scaleFactor+1)) collectionViewLayout:flowLayout];

    _myCollectionView.showsHorizontalScrollIndicator=NO;
    _myCollectionView.clipsToBounds=YES;
    _myCollectionView.backgroundColor = [UIColor clearColor];
    [_myCollectionView registerClass:[SBLessonCollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    _myCollectionView.delegate = self;
    _myCollectionView.dataSource = self;
    [self.view addSubview:_myCollectionView];
    
    _label3 =[SBLabel CreateLabelWithString:_model.unitDescription fontSize:14];
    _label3.textColor=[UIColor whiteColor];
    [_label3 SBLabelSetOffset:CGPointMake(0, 20) withReferencePoint:CGPointMake(0, _label2.frame.origin.y+_label2.frame.size.height)];
    if ([UIScreen mainScreen].bounds.size.height==480) {
        [_label3 SBLabelSetOffset:CGPointMake(0, 10) withReferencePoint:CGPointMake(0, _label2.frame.origin.y+_label2.frame.size.height)];
        [_label3 SBLabelSetFontSize:12];
    }
    _label3.center=CGPointMake(self.view.frame.size.width/2.0f, _label3.center.y);
    [_label3 SBLabelSetWidth:[UIScreen mainScreen].bounds.size.width-100 atCenterPoint:_label3.center];
    [_label3 SBLabelSetNumOfLines:3];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_label3.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_label3.text length])];
    _label3.attributedText = attributedString;
    [_label3 sizeToFit];
    [self.view addSubview:_label3];
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _model.data.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SBLessonModel *currentModel=_model.data[indexPath.row];
    if (currentModel.status.integerValue==0) {
        SBMenuViewController *view=[[SBMenuViewController alloc]init];
        view.imgStr=currentModel.image;
        view.title1=currentModel.titleEN;
        view.title2=currentModel.titleCN;
        view.lessonIndex=indexPath.row+1;
        [self.navigationController pushViewController:view animated:YES];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


//- (void)collectionView:(UICollectionView *)collectionView
//  didEndDisplayingCell:(UICollectionViewCell *)cell
//    forItemAtIndexPath:(NSIndexPath *)indexPath {
//    // 获取当前显示的cell的下标
//    NSIndexPath *firstIndexPath = [[self.myCollectionView indexPathsForVisibleItems] firstObject];
//    // 赋值给记录当前坐标的变量
//    
//    // 更新底部的数据
//    // ...
//}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SBLessonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"SBLessonCollectionViewCell" owner:self options:nil];
        if(!cell)
        {
            cell= nib.firstObject;
    
        }
    SBLessonModel *currentModel=_model.data[indexPath.row];
    cell.cardImg.image=[UIImage imageNamed:@"lesson_card_background"];
    cell.label1.text=currentModel.name;
    cell.lable2.text=currentModel.titleEN;
    cell.lable3.text=currentModel.titleCN;
    if (currentModel.status.integerValue==0) {
        cell.alphaView.hidden=YES;
    }else{
        cell.alphaView.hidden=NO;
    }
    
        return cell;
}

@end
