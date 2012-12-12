//
//  AppDelegate.m
//  KinveyWidgets
//
//  Copyright 2012 Kinvey, Inc
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  Created by Michael Katz on 10/17/12.
//

#import "AppDelegate.h"

#import <KinveyKit/KinveyKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "KWSignInViewController.h"
#import "KCSSignInDelegate.h"

@interface AppDelegate () <KCSSignInResponder>
@property (nonatomic, retain) FBSession* session;
@end

@implementation AppDelegate

- (void) setupApplication
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ //don't call twice but make sure is called on both iOS5 & iOS6
        // Kinvey use Code
        // if not using Twitter for sign in - remove these options keys (set to nil), otherwise supply your app's Twitter credentials
        (void)[[KCSClient sharedClient] initializeKinveyServiceForAppKey:@"<#Kinvey App Key#>"
                                                           withAppSecret:@"<#Kinvey App Secret#>"
                                                            usingOptions:@{KCS_TWITTER_CLIENT_KEY : @"<#Twitter Client Key#>", KCS_TWITTER_CLIENT_SECRET : @"<#Twitter Client Secret#>"}];
        
#warning remove if Not using facebook SDK
        //If not using Facebookf or sign in - remove all the FBSession stuff from your code, otherwise supply your app's Facebook credentials
        //You'll also need supply the appropriate fb### URL callback in the Info.plist file
        self.session = [[FBSession alloc] initWithAppID:@"<#Facebook App Id#>"
                                            permissions:nil
                                        urlSchemeSuffix:nil
                                     tokenCacheStrategy:nil];
        
        
        //Create the Sign-In stuff:
        KCSSignInDelegate* signindelegate = [[KCSSignInDelegate alloc] init];
        signindelegate.signInResponder = self;
        
        //Uncomment to turn on email verification - it's NO by default
        //signindelegate.shouldSendEmailVerificationAfterSignup = YES;
        signindelegate.emailVerificationRequired = YES; //separate bool to check that verification is required to use the app - some apps allow use even if not verified
        self.signInDelegate = signindelegate;
        
        KWSignInViewController* signInViewController = [[KWSignInViewController alloc] init];
        signInViewController.signInDelegate = signindelegate;
        signInViewController.socialLogins = @[KWSignInFacebook, KWSignInTwitter, KWSignInLinkedIn];
        
        //Uncomment to use text instead of an image as the Title
        //view.title = @"Welcome to Kinvey SignIn";
        //view.titleType = KWSIgnInViewControllerTitleText;
        
        // set up window
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        self.window.backgroundColor = [UIColor whiteColor];
        
        //Create a navigation controller to put hold signin controller (required)
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:signInViewController];
        nav.navigationBar.barStyle = UIBarStyleBlack;
#if _IS_IOS_6
        nav.restorationIdentifier = @"nav";
#endif
        self.window.rootViewController = nav;
        
        //Uncomment and replace above code with something similiar to show the login controller as a modal view instead of added to the hierarchy
        //    UIViewController* blank = [[UIViewController alloc] init];
        //    blank.view = [[UIView alloc] init];
        //    self.window.rootViewController = blank;
        //    [view showModally];
        //#if _IS_IOS_6
        //    blank.restorationIdentifier = @"blankViewController";
        //#endif
        
        [self.window makeKeyAndVisible];
    });
}

- (BOOL)application:(UIApplication *)application willFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupApplication];
    return YES;
}

- (BOOL) application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupApplication];
    return YES;
}

- (void)userSucessfullySignedIn:(KCSUser *)user
{
    UIViewController* mainAppViewController = [[UIViewController alloc] init];
    UILabel* label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"User '%@' signed in", user.username];
    label.textAlignment = NSTextAlignmentCenter;
    mainAppViewController.view = label;
    self.window.rootViewController = mainAppViewController;
}

// FBSample logic
// The native facebook application transitions back to an authenticating application when the user
// chooses to either log in, or cancel. The url passed to this method contains the token in the
// case of a successful login. By passing the url to the handleOpenURL method of a session object
// the session object can parse the URL, and capture the token for use by the rest of the authenticating
// application; the return value of handleOpenURL indicates whether or not the URL was handled by the
// session object, and does not reflect whether or not the login was successful; the session object's
// state, as well as its arguments passed to the state completion handler indicate whether the login
// was successful; note that if the session is nil or closed when handleOpenURL is called, the expression
// will be boolean NO, meaning the URL was not handled by the authenticating application
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [self.session handleOpenURL:url];
}

#pragma mark - State Restoration

// Uncomment to support State Restoration
//
//- (BOOL)application:(UIApplication *)application shouldSaveApplicationState:(NSCoder *)coder
//{
//    return YES;
//}
//
//- (BOOL)application:(UIApplication *)application shouldRestoreApplicationState:(NSCoder *)coder
//{
//    return YES;
//}


@end
