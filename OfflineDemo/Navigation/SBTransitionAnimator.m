//
//  SBTransitionAnimator.m
//  ABC360
//
//  Created by dog_47 on 1/29/16.
//  Copyright © 2016 abc360.com. All rights reserved.
//

#import "SBTransitionAnimator.h"

@implementation SBTransitionAnimator{
    Transition_Animator_Type _theType;
}



+(SBTransitionAnimator *)CreateAnimatorWithType:(Transition_Animator_Type)_type{
    id obj;
    obj=[[SBTransitionAnimator alloc]initWithType:_type];
    return obj;
}


-(id)initWithType:(Transition_Animator_Type)_type{
    if (self=[super init]) {
        _theType=_type;
    }
    return self;
}
    

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return [self getDurantion];
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    
    if (_theType==Transition_Animator_Scale) {
        UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [[transitionContext containerView] addSubview:toViewController.view];
        toViewController.view.alpha = 0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.transform = CGAffineTransformMakeScale(0.1, 0.1);
            toViewController.view.alpha = 1;
        } completion:^(BOOL finished) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
        return;
    }
    
}

-(NSTimeInterval)getDurantion{
    if (_theType==Transition_Animator_Scale) {
        return 1;
    }
    
    
    return 1;
}


@end
