//
//  FrontlineAppDelegate.h
//  TouchMenu
//
//  Created by Fan JinKun on 13-6-4.
//  Copyright (c) 2013年 WV. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrontlineAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
