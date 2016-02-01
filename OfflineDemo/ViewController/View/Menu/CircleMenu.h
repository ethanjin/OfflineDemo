//
//  CircleMenu.h
//  AnimatingButtons
//
//  Created by dog_47 on 1/6/16.
//  Copyright © 2016 dog-47.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,CircleMenuState) {
    Menu_State_Learning,
    Menu_State_Complete
};



@protocol CircleMenuDelegate <NSObject>

-(void)circleMenuSelected:(NSInteger)_index;

@end

@interface CircleMenu : UIView

@property (assign,nonatomic) id<CircleMenuDelegate> delegate;
+(CircleMenu *)CreatMenu;
-(void)setButtonState:(CircleMenuState)_state heighted:(BOOL)_value index:(NSInteger)_index;

@end
