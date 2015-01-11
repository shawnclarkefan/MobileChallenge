//
//  AppDelegate.h
//  MobileChallenge
//
//  Created by fan gang on 4/1/15.
//  Copyright (c) 2015 Shawn Fan. All rights reserved.
//


#define kBgQueue dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(void)downloadDataFromURL:(NSURL *)url withCompletionHandler:(void(^)(NSData *data))completionHandler;


@end

