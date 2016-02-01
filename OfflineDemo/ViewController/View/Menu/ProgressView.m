//
//  ProgressView.m
//  Progress
//
//  Created by dog_47 on 4/26/15.
//  Copyright (c) 2015 SnapFit. All rights reserved.
//

#import "ProgressView.h"


@interface ProgressViewLayer : CALayer

@property(nonatomic, strong) UIColor *trackTintColor;
@property(nonatomic, strong) UIColor *progressTintColor;
@property(nonatomic, strong) UIColor *innerTintColor;
@property(nonatomic) NSInteger roundedCorners;
@property(nonatomic) CGFloat thicknessRatio;
@property(nonatomic) CGFloat progress;
@property(nonatomic) NSInteger clockwiseProgress;

@end

@implementation ProgressViewLayer

@dynamic trackTintColor;
@dynamic progressTintColor;
@dynamic innerTintColor;
@dynamic roundedCorners;
@dynamic thicknessRatio;
@dynamic progress;
@dynamic clockwiseProgress;

+ (BOOL)needsDisplayForKey:(NSString *)key
{
    if ([key isEqualToString:@"progress"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

- (void)drawInContext:(CGContextRef)context
{
    float scale;
    scale=0.5;
    CGRect rect = CGRectMake(self.bounds.origin.x*scale, self.bounds.origin.y*scale, self.bounds.size.width*scale, self.bounds.size.height*scale);
    //    CGPoint centerPoint = CGPointMake(rect.size.width / 2.0f, rect.size.height / 2.0f);
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
    
    CGFloat radius = MIN(rect.size.height, rect.size.width) / 2.0f;
    
    
    BOOL clockwise = (self.clockwiseProgress != 0);
    
    CGFloat progress = MIN(self.progress, 1.0f - FLT_EPSILON);
    CGFloat radians = 0;
    if (clockwise) {
        radians = (float)((progress * 2.0f * M_PI) - M_PI_2);
    } else {
        radians = (float)(3 * M_PI_2 - (progress * 2.0f * M_PI));
    }
    
    CGContextSetFillColorWithColor(context, self.trackTintColor.CGColor);
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, radius, (float)(2.0f * M_PI), 0.0f, TRUE);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    if (progress > 0.0f) {
        CGContextSetFillColorWithColor(context, self.progressTintColor.CGColor);
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, radius, (float)(3.0f * M_PI_2), radians, !clockwise);
        CGPathCloseSubpath(progressPath);
        CGContextAddPath(context, progressPath);
        CGContextFillPath(context);
        CGPathRelease(progressPath);
    }
    
    if (progress > 0.0f && self.roundedCorners) {
        CGFloat pathWidth = radius * self.thicknessRatio;
        CGFloat xOffset = radius * (1+1.0f + ((1.0f - (self.thicknessRatio / 2.0f)) * cosf(radians)));
        CGFloat yOffset = radius * (1+1.0f + ((1.0f - (self.thicknessRatio / 2.0f)) * sinf(radians)));
        CGPoint endPoint = CGPointMake(xOffset, yOffset);
        
        CGRect startEllipseRect = (CGRect) {
            .origin.x = centerPoint.x - pathWidth / 2.0f,
            .origin.y = centerPoint.y - self.bounds.size.height/4,
            .size.width = pathWidth,
            .size.height = pathWidth
        };
        
        //        CGRect startEllipseRect = (CGRect) {
        //            .origin.x = self.bounds.size.width / 2.0f-80,
        //            .origin.y = self.bounds.size.height / 2.0f,
        //            .size.width = pathWidth,
        //            .size.height = pathWidth
        //        };
        CGContextAddEllipseInRect(context, startEllipseRect);
        CGContextFillPath(context);
        
        CGRect endEllipseRect = (CGRect) {
            .origin.x = endPoint.x - pathWidth / 2.0f,
            .origin.y = endPoint.y - pathWidth / 2.0f,
            .size.width = pathWidth,
            .size.height = pathWidth
        };
        CGContextAddEllipseInRect(context, endEllipseRect);
        CGContextFillPath(context);
    }
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGFloat innerRadius = radius * (1.0f - self.thicknessRatio);
    CGRect clearRect = (CGRect) {
        .origin.x = centerPoint.x - innerRadius,
        .origin.y = centerPoint.y - innerRadius,
        .size.width = innerRadius * 2.0f,
        .size.height = innerRadius * 2.0f
    };
    CGContextAddEllipseInRect(context, clearRect);
    CGContextFillPath(context);
    
    if (self.innerTintColor) {
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGContextSetFillColorWithColor(context, [self.innerTintColor CGColor]);
        CGContextAddEllipseInRect(context, clearRect);
        CGContextFillPath(context);
    }
    
    
}
@end



@interface ProgressView ()
@end
@implementation ProgressView{
    CALayer *layer1;
    CALayer *layer2;
    CALayer *layer3;
    float percent;
    UIColor *DrawColor;
    BOOL changeDrawColor;
}

+ (void) initialize
{
    if (self == [ProgressView class]) {
        ProgressView *circularProgressViewAppearance = [ProgressView appearance];
        [circularProgressViewAppearance setTrackTintColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3f]];
        [circularProgressViewAppearance setProgressTintColor:[UIColor whiteColor]];
        [circularProgressViewAppearance setInnerTintColor:nil];
        [circularProgressViewAppearance setBackgroundColor:[UIColor clearColor]];
        [circularProgressViewAppearance setThicknessRatio:0.3f];
        [circularProgressViewAppearance setRoundedCorners:NO];
        [circularProgressViewAppearance setClockwiseProgress:YES];
        //        [circularProgressViewAppearance setIndeterminateDuration:2.0f];
        //        [circularProgressViewAppearance setIndeterminate:NO];
    }
}

+ (Class)layerClass
{
    return [ProgressViewLayer class];
}

- (ProgressViewLayer *)circularProgressLayer
{
    return (ProgressViewLayer *)self.layer;
}



-(instancetype)initWithFrame:(CGRect)frame{
    if(self=[super initWithFrame:frame]){
        self.progressTintColor=[UIColor colorWithRed:55/255.0f green:160/255.0f blue:244/255.0f alpha:1.0f];
        [self initLayer:frame];
        self.isStopAnimate=YES;
    }
    return self;
}

- (void)didMoveToWindow
{
    CGFloat windowContentsScale = self.window.screen.scale;
    self.circularProgressLayer.contentsScale = windowContentsScale;
    [self.circularProgressLayer setNeedsDisplay];
}

- (CGFloat)progress
{
    return self.circularProgressLayer.progress;
}

-(void)initLayer:(CGRect)frame{
    self.trackTintColor = [UIColor clearColor];
    self.roundedCorners=YES;
    self.thicknessRatio=0.22;
    CGSize theSize=frame.size;
//    if(layer1==nil){
//        CGRect theFrame=CGRectMake(theSize.width*0.32, theSize.height*0.30, theSize.width*0.07,theSize.height*0.07 );
//        layer1=[CALayer layer];
//        layer1.frame=theFrame;
//        layer1.cornerRadius=theFrame.size.width/2;
//        layer1.backgroundColor=self.progressTintColor.CGColor;
//        layer1.opacity=0.0;
//        [self.layer addSublayer:layer1];
//    }
//    if(layer2==nil){
//        CGRect theFrame2=CGRectMake(theSize.width*0.40, theSize.height*0.18, theSize.width*0.05,theSize.height*0.05 );
//        layer2=[CALayer layer];
//        layer2.frame=theFrame2;
//        layer2.cornerRadius=theFrame2.size.width/2;
//        layer2.backgroundColor=self.progressTintColor.CGColor;
//        layer2.opacity=0.0;
//        [self.layer addSublayer:layer2];
//    }
//    if(layer3==nil){
//        CGRect theFrame3=CGRectMake(theSize.width*0.23, theSize.height*0.32, theSize.width*0.04,theSize.height*0.04 );
//        layer3=[CALayer layer];
//        layer3.frame=theFrame3;
//        layer3.cornerRadius=theFrame3.size.width/2;
//        layer3.backgroundColor=self.progressTintColor.CGColor;
//        layer3.opacity=0.0;
//        [self.layer addSublayer:layer3];
//    }
    
}



-(void)animateFromPercent:(float)_value1 ToPercent:(float)_value2{
    CGFloat fromValue;
    fromValue = MIN(MAX(_value1, 0.0f), 1.0f);
    self.circularProgressLayer.progress=fromValue;
    [self.circularProgressLayer setNeedsDisplay];
    
    [self runAnimationWithPercent:_value2];
    
}

-(void)runAnimationWithPercent:(float)_value{
    
    CGFloat pinnedProgress = MIN(MAX(_value, 0.0f), 1.0f);
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
    animation.duration = 1;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:pinnedProgress];
    //animation.beginTime = CACurrentMediaTime() + 1;
    //animation.repeatCount=1;
    animation.removedOnCompletion=NO;
    animation.delegate=[AnimationBlockDelegate animationDelegateWithBeginning:nil completion:^(BOOL finished){
        //[self drawPoint];
    }];
    [self.circularProgressLayer addAnimation:animation forKey:@"progress"];
    
}

-(void)drawPoint{
    layer1.opacity=1.0;
    CABasicAnimation *opAnim = [self createPointAnimation:1];
    opAnim.delegate=[AnimationBlockDelegate animationDelegateWithBeginning:nil completion:^(BOOL finished){
        layer2.opacity=1.0;
        CABasicAnimation *opAnim2 = [self createPointAnimation:2];
        opAnim2.delegate=[AnimationBlockDelegate animationDelegateWithBeginning:nil completion:^(BOOL finished){
            layer3.opacity=1.0;
            CABasicAnimation *opAnim3 = [self createPointAnimation:3];
            opAnim3.delegate=[AnimationBlockDelegate animationDelegateWithBeginning:nil completion:^(BOOL finished){
    
                [self loopAnimation];
                //[self performSelector:@selector(loopAnimation) withObject:nil afterDelay:0.2];
                
            }];
            [layer3 addAnimation:opAnim3 forKey:@"animateOpacity"];
        }];
        [layer2 addAnimation:opAnim2 forKey:@"animateOpacity"];
    }];
    [layer1 addAnimation:opAnim forKey:@"animateOpacity"];
    
}

-(CABasicAnimation*)createPointAnimation:(int)Size{
    CABasicAnimation *opAnim = [CABasicAnimation animationWithKeyPath:@"bounds"];
    opAnim.duration = 0.3;
    opAnim.fromValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
    
    switch (Size) {
        case 1:
            opAnim.toValue= [NSValue valueWithCGRect:layer1.bounds];
            break;
        case 2:
            opAnim.toValue= [NSValue valueWithCGRect:layer2.bounds];
            break;
        case 3:
            opAnim.toValue= [NSValue valueWithCGRect:layer3.bounds];
            break;
    }
    //opAnim.toValue= [NSValue valueWithCGRect:layer1.bounds];
    opAnim.repeatCount = 1;
    opAnim.fillMode = kCAFillModeForwards;
    opAnim.removedOnCompletion=NO;
    return opAnim;
}

-(void)loopAnimation{
    [self.circularProgressLayer removeAllAnimations];
    [layer1 removeAllAnimations];
    [layer2 removeAllAnimations];
    [layer3 removeAllAnimations];
    [self drawWithPercent:0.0f];
    if(self.isStopAnimate==NO){
//        [self runAnimation];
    }
}

-(void)animate{
    if(self.isStopAnimate){
        self.isStopAnimate=NO;
        [self.circularProgressLayer setNeedsDisplay];
        [self drawWithPercent:0.0f];
//        [self runAnimation];
    }
}

-(void)endAnimate{
    self.isStopAnimate=YES;
    [self.circularProgressLayer removeAllAnimations];
    [layer1 removeAllAnimations];
    [layer2 removeAllAnimations];
    [layer3 removeAllAnimations];
    [self drawWithPercent:0.0];
}





-(void)drawWithPercent:(float)thePercent{
    CGFloat pinnedProgress;
    pinnedProgress = MIN(MAX(thePercent, 0.0f), 1.0f);
//    CGFloat pinnedProgress;
//    if (thePercent<=0.8f) {
//        pinnedProgress = MIN(MAX(thePercent, 0.0f), 1.0f);
//        layer1.opacity=0.0;
//        layer2.opacity=0.0;
//        layer3.opacity=0.0;
//    }else{
//        pinnedProgress = MIN(MAX(0.8f, 0.0f), 1.0f);
//        if (thePercent>0.8 && thePercent<=0.86) {
//            layer1.opacity=1.0;
//            layer2.opacity=0.0;
//            layer3.opacity=0.0;
//        }else if (thePercent>0.86 && thePercent<=0.93){
//            layer1.opacity=1.0;
//            layer2.opacity=1.0;
//            layer3.opacity=0.0;
//        }else if (thePercent>0.93 &&thePercent<=1){
//            layer1.opacity=1.0;
//            layer2.opacity=1.0;
//            layer3.opacity=1.0;
//        }
//    }
    self.circularProgressLayer.progress=pinnedProgress;
    [self.circularProgressLayer setNeedsDisplay];
}



- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    self.circularProgressLayer.trackTintColor = trackTintColor;
    [self.circularProgressLayer setNeedsDisplay];
}

- (UIColor *)progressTintColor
{
    return self.circularProgressLayer.progressTintColor;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    self.circularProgressLayer.progressTintColor = progressTintColor;
    [self.circularProgressLayer setNeedsDisplay];
    
    layer1.backgroundColor=progressTintColor.CGColor;
    layer2.backgroundColor=progressTintColor.CGColor;
    layer3.backgroundColor=progressTintColor.CGColor;
}



- (void)setRoundedCorners:(NSInteger)roundedCorners
{
    self.circularProgressLayer.roundedCorners = roundedCorners;
    [self.circularProgressLayer setNeedsDisplay];
}


- (void)setThicknessRatio:(CGFloat)thicknessRatio
{
    self.circularProgressLayer.thicknessRatio = MIN(MAX(thicknessRatio, 0.f), 1.f);
    [self.circularProgressLayer setNeedsDisplay];
}


- (NSInteger)clockwiseProgress
{
    return self.circularProgressLayer.clockwiseProgress;
}

- (void)setClockwiseProgress:(NSInteger)clockwiseProgres
{
    self.circularProgressLayer.clockwiseProgress = clockwiseProgres;
    [self.circularProgressLayer setNeedsDisplay];
}

@end
