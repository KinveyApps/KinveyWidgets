//
//  KWSignInViewController.h
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
//  Created by Michael Katz on 10/5/12.
//


#import <UIKit/UIKit.h>
#import "KWSignInViewControllerDelegate.h"

//helper to compile out code that isn't on iOS6
#define _IS_IOS_6 __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000 

@class KWSignInViewController;
@class KWResetPasswordController;

/** Constant to specify that the Login screen sohuld show a 'Sign In with Facebook' button. 
 @see [KWSignInViewController socialLogins]
 */
FOUNDATION_EXPORT NSString* const KWSignInFacebook;
/** Constant to specify that the Login screen sohuld show a 'Sign In with Twitter' button.
 @see [KWSignInViewController socialLogins]
 */
FOUNDATION_EXPORT NSString* const KWSignInTwitter;
/** Constant to specify that the Login screen sohuld show a 'Sign In with LinkedIn' button.
 @see [KWSignInViewController socialLogins]
 */
FOUNDATION_EXPORT NSString* const KWSignInLinkedIn;


/** Enum switch to control if the Sign In view uses text or an image for the title area. 
 @see [KWSignInViewController titleType]
 */
typedef enum : NSUInteger {
    /** Use a logo image for the title view
        @see [KWSignInViewController logo] 
     */
    KWSIgnInViewControllerTitleImage,
    /** Use a string label for the title view
     @see [KWSignInViewController title]
     */
    KWSIgnInViewControllerTitleText
} KWSignInViewControllerTitleType;


/** A View Controller that presents a sign-in form. 
 
 By default this presents a view with an entry area for a username and password with a sign-in button. Also provides buttons for creating a new account, 
 resetting the password, and sign-in with twitter and facebook. The view has a pleasant gradient background, and displays a title using an image: logo.png. In addition to the main view controller, the button actions can present separate views for creating a new account, resetting a password, and for resending an email confirmation.
 
 This controller must be presented inside a UINavigationController. This is used to push the subordinate views onto the stack. Use `- [KWSignInViewController showModally]` to present this view modally. This will create a navigation controller with this as the root controller, and then present that navigation stack modally.
 
 Assign a `signInDelegate` to receive the actions from this and the subordinate controlers. This is used to performing various actions such as signing in and creating an account. The delegate should be responsible for dismissing this controller. 
 
 */
#if _IS_IOS_6
@interface KWSignInViewController : UIViewController <UIViewControllerRestoration>
#else
@interface KWSignInViewController : UIViewController
#endif

/// @name Delegate

/** The delegate to receive all the action callbacks */
@property (nonatomic, retain) id<KWSignInViewControllerDelegate> signInDelegate;

/// @name Title View Customization

/** The image to use in the title view. This should be about 55 px in height. By default this is the Kinvey logo.*/
@property (nonatomic, strong) UIImage* logo;
/** The title string to use in the title view, if using a  `KWSIgnInViewControllerTitleText`.*/
@property (nonatomic, copy) NSString* title;
/** Use this to switch between text and image for the title area on the screen. By default this uses the image in `logo.png`.*/
@property (nonatomic) KWSignInViewControllerTitleType titleType;

/// @name Colors

/** The colors for the background view gradient, from the upper left to the lower right. */
@property (nonatomic, copy) NSArray* backgroundGradientColors;
/** The color for the gradient sign in button */
@property (nonatomic, strong) UIColor* buttonColor;
/** The color for the dividing line */
@property (nonatomic) UIColor* lineColor;

/// @name Basic Sign In Widgets

/** the textfield where the user enters his or her username */
@property (nonatomic, strong) UITextField* usernameField;
/** the textfield where the user enters his or her password */
@property (nonatomic, strong) UITextField* passwordField;
/** the sign-in button */
@property (nonatomic, strong) UIButton* signInButton;
/** set to `NO` to not show the in-button activity indicators when the button is pressed. Shows by default */
@property (nonatomic) BOOL showsActivityIndicator;

/** the "forgot password?" button */
@property (nonatomic, strong) UIButton* resetPasswordButton;
/** set to `NO` to hide the forgot password button. Shown by default */
@property (nonatomic) BOOL showsResetPasswordButton;

/** the create a new account button */
@property (nonatomic, strong) UIButton* createAccountButton;
/** set to `NO` to hide the create account button. Shown by default */
@property (nonatomic) BOOL showsCreateAccountButton;

/// @name social service sign-in

/** an array of identifiers for the social signin service providers to show. 
 
 Values are:
 
 * `KWSignInFacebook` : Sign In With Facebook
 * `KWSignInTwitter` : Sign In Wit Twitter
 
 By default, both Facebook and Twitter buttons are shown 
 */
@property (nonatomic) NSArray* socialLogins;

/// @name delegate call-ins

/** Called when action is complete. This re-enables buttons and turns off activity indicators */
- (void) actionComplete;
/** Called to start the sign-in process. */
- (void) signInWithUsername:(NSString*)username password:(NSString*)password;
/** Called to display a view indicating to the user that they need to accept email verificaiton to use the app, and provide a button to resend */
- (void) showEmailVerificationScreen:(NSString*)username;

/// @name Showing the view
/** Constructs a UINavigationController and uses that to present this controller in a modal fashion. Transition and presentation styles are transferred from this controller to its new parent */
- (void) showModally;
@end
