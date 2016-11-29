//
//  AppDelegate.m
//  Demo
//
//  Created by songyutao on 2016/11/29.
//  Copyright © 2016年 Creditease. All rights reserved.
//

#import "AppDelegate.h"
#import "YTSegmentedControl.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIImage *selectedImage = [[UIImage imageNamed:@"segmented_selected"] stretchableImageWithLeftCapWidth:[UIImage imageNamed:@"segmented_selected"].size.width/2 topCapHeight:[UIImage imageNamed:@"segmented_selected"].size.height/2];
    UIImage *unSelectedImage = [[UIImage imageNamed:@"segmented_bg"] stretchableImageWithLeftCapWidth:[UIImage imageNamed:@"segmented_bg"].size.width/2 topCapHeight:[UIImage imageNamed:@"segmented_bg"].size.height/2];
    [[YTSegmentedControl appearance] setSelectedItemBgImage:selectedImage];
    [[YTSegmentedControl appearance] setNormalItemBgImage:unSelectedImage];
    [[YTSegmentedControl appearance] setNormalAttributeDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor blueColor]}];
    [[YTSegmentedControl appearance] setSelectedAttributeDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor grayColor]}];
    [[YTSegmentedControl appearance] setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [[YTSegmentedControl appearance] setItemWidth:80];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
