//
//  KWSignInViewControllerDelegate.h
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
//  Created by Michael Katz on 10/19/12.
//

#import <Foundation/Foundation.h>

@class KWSignInViewController;
@class KWResetPasswordController;
@class KWCreateAccountViewController;

/** Sign-in delegate protocol. Implementations of this class will receive actions from the KWSignInViewController and its subordinate views controllers, one it is set as `signInDelegate` property. It is the responsbility of this protocol's implementation to call the various services for sign-in and account management.
 
 See `KCSSignInDelegate` for an example implementation. 
 */
@protocol KWSignInViewControllerDelegate <NSObject>

/** Called when the user presses the "Sign In" button. 
 
 This class can show an alert view to display failures, such as incorrect password. If sign-in is successful, this class can dismiss the view controller and bring the user futher into the application.
 
 @param sigInController the calling controller. Be sure to call `[signInController actionComplete]` once the action completes: sucessful or otherwise.
 @param username the username as typed in the text field
 @param password the password as typed in the text field
 */
- (void) doSignIn:(KWSignInViewController*)signInController username:(NSString*)username password:(NSString*)password;

@optional

/** Called when the user presses the "reset password" button in the `KWResetPasswordController` sub-view.
 
 The current set up provides a form to have the password reset through email. If your application provides another way of resetting or recovering passwords, modify `KWResetPasswordController`.
 
 @param pwResetController the reset password screen. Be sure to call `[pwResetController actionComplete]` once the action completes: sucessful or otherwise.
 @param username the username as entered on the reset pw screen
 */
- (void) doResetPassword:(KWResetPasswordController*)pwResetController username:(NSString*)username;

/** Called when the user presses the "create account" button in the `KWCreateAccountViewController` sub-view.
 
 This controller stack assumes that passwords are to be used also as usernames. If you have different usernames and passwords, then a separate field will have to be added to the `KWCreateAccountViewController` and additional parameter to this method.
 
 The only verification performed by the calling controller is that the user entered the same password twice. This does not do any other kind of validation on password or other fields. If your app has specific requirements on these fields, it can be checked here or by modifying the `KWCreateAccountViewController`.
 
 @param createAccountController the create account screen. Be sure to call `[createAccountController actionComplete]` once the action completes: sucessful or otherwise.
 @param givenname the user's entered given (first) name
 @param surname the user's entered sur (last) name
 @param email the user's entered email
 @param password the user's entered password.
 */
- (void) doCreateAccount:(KWCreateAccountViewController*)createAccountController
               givenname:(NSString*)givenname
                 surname:(NSString*)surname
                   email:(NSString*)email
                password:(NSString*)password;

/** Called when the user presses a "Sign in with XX service" button.
 
 This class can show an alert view to display failures, such as the user rejecting access to his/her account. If sign-in is successful, this class can dismiss the view controller and bring the user futher into the application.
 
 @param sigInController the calling controller. Be sure to call `[signInController actionComplete]` once the action completes: sucessful or otherwise.
 @param signInProvider a string matching one of the ones defined in KWSignInViewController.h,  representing the identifer of a particular identity service
 */
- (void) doSoicalSignIn:(KWSignInViewController*)signInController provider:(NSString*)signInProvider;

/** Called when the user presses the "resend email verification" butotn. 
 @param username the username of the current user
 */
- (void) doSendEmailVerification:(NSString*)username;
@end