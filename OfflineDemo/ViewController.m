//
//  ViewController.m
//  OfflineDemo
//
//  Created by dog_47 on 2/1/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import "ViewController.h"
#import "SBUnitController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title=@"透明NavigationBar";
    self.view.backgroundColor=[UIColor purpleColor];
    UIButton *button=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
    [button setTitle:@"Push" forState:UIControlStateNormal];
    button.center=CGPointMake(self.view.frame.size.width/2.0f, self.view.frame.size.height/2.0f);
    button.layer.cornerRadius=5;
    button.backgroundColor=[UIColor lightGrayColor];
    [button addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    

}


-(void)push{
    [self.navigationController pushViewController:[SBUnitController new] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
