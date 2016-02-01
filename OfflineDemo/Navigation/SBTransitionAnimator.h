//
//  SBTransitionAnimator.h
//  ABC360
//
//  Created by dog_47 on 1/29/16.
//  Copyright © 2016 abc360.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef  NS_ENUM (NSInteger,Transition_Animator_Type){
    Transition_Animator_Push,
    Transition_Animator_Scale,
    Transition_Animator_Lesson
};

@interface SBTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>


+(SBTransitionAnimator *)CreateAnimatorWithType:(Transition_Animator_Type)_type;

@end
