//
//  TouchMenu.m
//  TouchMenu
//
//  Created by Fan JinKun on 13-6-4.
//  Copyright (c) 2013年 WV. All rights reserved.
//

#import "TouchMenu.h"

@implementation TouchMenu

static inline float radians(double degrees) { return degrees * M_PI / 180; }

@synthesize delegate;

-(id)initWithFrame:(CGRect )frame size:(CGSize)size isFollowTouch:(BOOL)isFollow isLine:(BOOL)isLine imagesPath:(NSArray *)paths parent:(UIView *)view
{
    self = [self initWithFrame:frame];
    if(self){
        _arrImagesPath = [[NSMutableArray alloc] initWithArray:paths];
        _count = _arrImagesPath.count;
        _size = size;
        _position = CGPointZero;
        _isLine = isLine;
        _idx = 0;
        [self setBackgroundColor:[UIColor clearColor]];
        self.alpha = 0.0;
        UILongPressGestureRecognizer *longPressGR =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(handleLongPress:)];
        longPressGR.allowableMovement=NO;
        longPressGR.minimumPressDuration = 0.4;
        [view  addGestureRecognizer:longPressGR];
        [longPressGR release];
        linePoint = CGPointMake(-10.0f, -10.0f);
    }
    return self;
}

-(IBAction)handleLongPress:(id)sender{
    
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    switch(longPress.state){
        case UIGestureRecognizerStateBegan:{
            linePoint = CGPointMake(-10.0f, -10.0f);
            CGPoint point = [longPress locationInView:longPress.view];
            _position = CGPointMake(point.x ,point.y );
            [self setNeedsDisplay];
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 1.0;
            } completion:^(BOOL finished) {
            
            }];
//            [self performSelector:@selector(checkLine) withObject:nil afterDelay:0.1];
        };break;
        case UIGestureRecognizerStateEnded:{
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
                if(delegate){
                    if([delegate respondsToSelector:@selector(menuItemWithIndex:)]){
                        [delegate menuItemWithIndex:_idx];
                    }
                }
            }];
        };break;
        case UIGestureRecognizerStateChanged:{
            CGPoint point = [longPress locationInView:longPress.view];
            linePoint = point;
            [self setNeedsDisplay];
        };break;
        case UIGestureRecognizerStateCancelled:{
            
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
            }];
        };break;
        case UIGestureRecognizerStateFailed:{
            [UIView animateWithDuration:0.3 animations:^{
                self.alpha = 0.0;
            } completion:^(BOOL finished) {
            }];
        };break;
    }
}

+(id)createWithFrame:(CGRect )frame size:(CGSize)size isFollowTouch:(BOOL)isFollow isLine:(BOOL)isLine imagesPath:(NSArray *)paths parent:(UIView *)view{
    return [[self alloc] initWithFrame:frame size:size isFollowTouch:isFollow isLine:isLine imagesPath:paths parent:view];
}

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineCap(context, kCGLineCapRound);
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextBeginPath(context);
    
    float ragy = linePoint.y - _position.y;
    float ragx = linePoint.x - _position.x;
    
    float ragReal = atan(ragy/ragx)/M_PI * 180;
    if(ragy>0&&ragx>0){//++
        
    } else if(ragy <0 && ragx > 0){//+-
        ragReal += 360;
    }else if(ragy < 0 && ragx < 0){//--
        ragReal += 180;
    }else if(ragy > 0 && ragx < 0){//-+
        ragReal += 180;
    }else if(ragy==0&&ragx>0){
        ragReal = 0;
    }else if(ragy>0&&ragx==0){
        ragReal = 90;
    }else if(ragy==0&&ragx<0){
        ragReal = 180;
    }else if(ragy<0&&ragx==0){
        ragReal = 270;
    }
    
    for(int i = 1; i <= _count ; i ++){
        if(ragReal > (360.0f/_count * (i-1)) && ragReal < (360.0f/_count * i )){

            CGContextSetFillColorWithColor(context, [UIColor colorWithRed:0.7 green:0.7 blue:0.9 alpha:1].CGColor);
            _idx = i;
        }else{
            CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
        }
        CGContextMoveToPoint(context,_position.x  , _position.y);
        CGContextAddArc(context, _position.x , _position.y , _size.width*0.5 ,
                        radians(360.0f/_count * (i-1)) , radians(360.0f/_count * i)  , 0);
        
        CGContextClosePath(context);
        
        CGContextFillPath(context);
        
        CGContextSetLineWidth(context, 2.0f);
        
        CGContextMoveToPoint(context,_position.x  , _position.y);
        CGContextAddArc(context, _position.x , _position.y , _size.width*0.5 ,
                        radians(360.0f/_count * (i-1)) , radians(360.0f/_count * i)  , 0);
        
        CGContextClosePath(context);
        
        CGContextStrokePath(context);
    }
    
    if(_isLine){
        CGContextMoveToPoint(context, _position.x, _position.y);
        if(linePoint.x == -10.0f && linePoint.y == -10.0f){
            return;
        }
        
        CGContextSetLineWidth(context, 3);
        CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
        CGContextAddLineToPoint(context, linePoint.x, linePoint.y);
        
        CGContextClosePath(context);
        
        CGContextStrokePath(context);
    }
    
}

@end
