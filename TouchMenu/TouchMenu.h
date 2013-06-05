//
//  TouchMenu.h
//  TouchMenu
//
//  Created by Fan JinKun on 13-6-4.
//  Copyright (c) 2013年 WV. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TouchMenuDelegate <NSObject>

-(void)menuItemWithIndex:(int)idx;

@end

@interface TouchMenu : UIView
{
    NSMutableArray *_arrImagesPath;
    CGPoint _oldPoint;
    CGPoint linePoint;
    CGPoint _position;
    CGSize _size;
    BOOL _isLine;
    int _count;
    int _idx;
    id<TouchMenuDelegate> delegate;
}

-(id)initWithFrame:(CGRect )frame size:(CGSize)size isFollowTouch:(BOOL)isFollow isLine:(BOOL)isLine imagesPath:(NSArray *)paths parent:(UIView *)view;

+(id)createWithFrame:(CGRect )frame size:(CGSize)size isFollowTouch:(BOOL)isFollow isLine:(BOOL)isLine imagesPath:(NSArray *)paths parent:(UIView *)view;

@property (nonatomic,assign) id<TouchMenuDelegate> delegate;

@end
