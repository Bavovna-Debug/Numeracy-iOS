//
//  Numeracy
//
//  Copyright (c) 2014 Meine Werke. All rights reserved.
//

#import "HALApplicationDelegate.h"
#import "HALBrain.h"
#import "HALJournal.h"
#import "HALMainViewController.h"

@interface HALApplicationDelegate ()

@property (nonatomic, strong) HALMainViewController *mainViewController;

@end

@implementation HALApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [application setStatusBarHidden:NO];
    
    [application setIdleTimerDisabled:YES];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    
    self.window = [[UIWindow alloc] initWithFrame:bounds];
    
    self.mainViewController = [[HALMainViewController alloc] init];
    
    [[HALBrain sharedBrain] loadData];
    [[HALJournal sharedJournal] loadJournal];

    self.window.rootViewController = self.mainViewController;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[HALBrain sharedBrain] saveData];
    [[HALJournal sharedJournal] saveJournalIfNeeded];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[HALBrain sharedBrain] saveData];
    [[HALJournal sharedJournal] saveJournalIfNeeded];
}

@end