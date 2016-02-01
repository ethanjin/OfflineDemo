//
//  ContainerView.h
//  ScrollViewContainer
//
//  Created by dog_47 on 1/12/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBUnitListModel.h"

@protocol SBUnitContainerViewDelegate <NSObject>

-(void)selectedUnit:(NSInteger)_index;

@end

@interface SBUnitContainerView : UIView

@property (assign,nonatomic) id<SBUnitContainerViewDelegate> delegate;

+(SBUnitContainerView *)creatContainerViewWithData:(SBUnitListModel *)theModel;


@end
