//
//  BusinessNavigationController.m
//  ABC360
//
//  Created by dog_47 on 1/11/16.
//  Copyright © 2016 abc360.com. All rights reserved.
//

#import "SBNavigationController.h"
#import "SBNavigationBar.h"


#define DEFAULT_NAVIGATIONBAR_COLOR  [UIColor whiteColor]

@interface SBNavigationController ()


@end

@implementation SBNavigationController


#pragma mark initialize
+ (void)initialize
{
    // 设置导航条的初始化颜色
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    navBar.barTintColor = DEFAULT_NAVIGATIONBAR_COLOR;
    

    // 设置导航条标题的字体和颜色
    NSDictionary *titleAttr = @{
                                NSForegroundColorAttributeName:[UIColor whiteColor],
                                NSFontAttributeName:[UIFont systemFontOfSize:22]
                                };
    [navBar setTitleTextAttributes:titleAttr];

    //设置返回按钮的样式
    //tintColor是用于导航条的所有Item
    navBar.tintColor = [UIColor whiteColor];
    UIBarButtonItem *navItem = [UIBarButtonItem appearanceWhenContainedIn:self, nil];

    //设置Item的字体大小
    [navItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]} forState:UIControlStateNormal];
}


#pragma mark ViewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigationBar];
    


}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SBNavigationBar *navBar =(SBNavigationBar*)self.navigationController.navigationBar;
    [navBar SBNavigationBarsetBackgroundAlphaWithPencentage:0 duration:0];
}

-(void)initNavigationBar{
    SBNavigationBar *navBar = [[SBNavigationBar alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 44)];
    navBar.defaultBarColor=DEFAULT_NAVIGATIONBAR_COLOR;
    
    navBar.translucent=YES;
    [self setValue:navBar forKey:@"navigationBar"];
    [navBar SBNavigationBarsetBackgroundAlphaWithPencentage:0 duration:0];
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        NSArray *list=self.navigationController.navigationBar.subviews;
        
        for (id obj in list) {
            
            if ([obj isKindOfClass:[UIImageView class]]) {
                
                UIImageView *imageView=(UIImageView *)obj;
                
                NSArray *list2=imageView.subviews;
                
                for (id obj2 in list2) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *imageView2=(UIImageView *)obj2;
                        
                        imageView2.hidden=YES;
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    for (UIView *view in self.navigationBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            view.hidden=YES;
        }
    }

    
}



#pragma mark memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//防止约课界面出横竖屏bug
#pragma mark Orientation
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate
{
    return YES;
}








@end
