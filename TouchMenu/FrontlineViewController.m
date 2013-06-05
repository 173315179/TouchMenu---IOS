//
//  FrontlineViewController.m
//  TouchMenu
//
//  Created by Fan JinKun on 13-6-4.
//  Copyright (c) 2013年 WV. All rights reserved.
//

#import "FrontlineViewController.h"

@interface FrontlineViewController ()

@end

@implementation FrontlineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    TouchMenu *tm = [TouchMenu createWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) size:CGSizeMake(200, 200) isFollowTouch:YES isLine:NO imagesPath:@[@"",@"",@""] parent:self.view];
    [tm setDelegate:self];
    [self.view addSubview:tm];
}

-(void)menuItemWithIndex:(int)idx{
    NSLog(@"touch index : %d",idx);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
