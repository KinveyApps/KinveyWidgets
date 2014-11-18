//
//  KCSSignInDelegate.m
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
//  Created by Michael Katz on 10/8/12.
//

#import "KCSSignInDelegate.h"
#import <KinveyKit/KinveyKit.h>
#import <FacebookSDK/FacebookSDK.h>

#import "KWResetPasswordController.h"
#import "KWCreateAccountViewController.h"

@implementation KCSSignInDelegate

#pragma mark - Sign In
- (void) handleSignInSuccess:(KWSignInViewController *)signInController user:(KCSUser*)user
{
    if (_emailVerificationRequired && user.emailVerified == NO) {
        [signInController.navigationController popToRootViewControllerAnimated:NO];
        //if email verificaiton is required to use the app and the user has not verified his/her email, send them to the resend screen
        [signInController showEmailVerificationScreen:user.username];
    } else {
        [signInController.navigationController popToRootViewControllerAnimated:YES];
        [_signInResponder userSucessfullySignedIn:user];
    }
}

//calls Kinvey's login
- (void) doSignIn:(KWSignInViewController *)signInController username:(NSString *)username password:(NSString *)password
{
    [KCSUser loginWithUsername:username password:password withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
        [signInController actionComplete]; //stop the spinners
        if (result != KCSUserFound && errorOrNil != nil) { //something went wrong
            NSString* message = [errorOrNil localizedDescription];
            if (errorOrNil.code == KCSLoginFailureError) {
                message = NSLocalizedString(@"Check that the username and password are correct and try again.", @"Invalid username or password mesasge");
                //other error possiblities include that the server could not be reached
            }
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sign in failed", @"Sign in failed")
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                                  otherButtonTitles: nil];
            [alert show];
        } else {
            [self handleSignInSuccess:signInController user:user];
        }
    }];
}

#pragma mark - Social login

//helper to create an error for twitter
- (void) twitterLoginFailed:(NSError*) error
{
    NSString* message = [error localizedDescription];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sign in with Twitter failed", @"Sign in with Twitter failed error alert")
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                          otherButtonTitles: nil];
    [alert show];
}

- (void) twitterSignIn:(KWSignInViewController*)signInController
{
    //Use Kinvey's special method to get the twitter access information from the default account; requires iOS 5+
    //To use secondary accounts or to not use the iOS-wide Twitter account, you will have to do something different
    [KCSUser getAccessDictionaryFromTwitterFromPrimaryAccount:^(NSDictionary *accessDictOrNil, NSError *errorOrNil) {
        if (errorOrNil == nil && accessDictOrNil != nil) {
            //if we were able to successfully get the twitter credentials, use them to log in to kinvey
            [KCSUser loginWithSocialIdentity:KCSSocialIDTwitter accessDictionary:accessDictOrNil withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
                [signInController actionComplete];
                if (errorOrNil == nil) {
                    [_signInResponder userSucessfullySignedIn:user];
                } else {
                    [self twitterLoginFailed:errorOrNil];
                }
            }];
        } else {
            [signInController actionComplete];
            [self twitterLoginFailed:errorOrNil];
        }
    }];
}

//helper to perform the FB login
- (void) facebookSignInWithFBSession:(FBSession*)session controller:(KWSignInViewController *)signInController
{
    NSString* accessToken = session.accessTokenData.accessToken;
    [KCSUser loginWithSocialIdentity:KCSSocialIDFacebook
                    accessDictionary:@{ KCSUserAccessTokenKey : accessToken} //construct the special access dictionary for using FB with Kinvey
                 withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
                     [signInController actionComplete];
                     if (errorOrNil == nil) {
                         [_signInResponder userSucessfullySignedIn:user];
                     } else {
                         UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sign in with Facebook failed", @"Sign in with fb failed error title")
                                                                         message:[errorOrNil localizedDescription]
                                                                        delegate:nil
                                                               cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                                               otherButtonTitles: nil];
                         [alert show];
                     }
                 }];
    
}
//make use of the Facebook SDK to get the current user's credentials
- (void) facebookSignIn:(KWSignInViewController *)signInController
{
    FBSession* session = [(id)[[UIApplication sharedApplication] delegate] session];
    void (^failBlock)(void) = ^{
        [signInController actionComplete];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sign in with Facebook failed", @"Sign in with fb failed error title")
                                                        message:NSLocalizedString(@"Could not open Facebook session", @"FB session not open error message")
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                              otherButtonTitles: nil];
        [alert show];
    };
    
    if (!session) {
        failBlock();
        return;
    }
    if (!session.isOpen) {
        [session openWithCompletionHandler:^(FBSession *session,
                                             FBSessionState status,
                                             NSError *error) {
            if (status == FBSessionStateOpen) {
                [self facebookSignInWithFBSession:session controller:signInController];
            } else {
                failBlock();
            }
        }];
    } else {
        [self facebookSignInWithFBSession:session controller:signInController];
    }
}

//helper to create an error for twitter
- (void) linkedInLoginFailed:(NSError*) error
{
    NSString* message = [error localizedDescription];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sign in with LinkedIn failed", @"Sign in with LinkedIn failed error alert")
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                          otherButtonTitles: nil];
    [alert show];
}

- (void) linkedInSignIn:(KWSignInViewController*)signInController
{
    //Create a modal web view to show in the interface. This will be used by `getAccessDictionaryFromLinkedIn:usingWebView:`
    //to diplay the web form the user to enter his LinkedIn credentials
    UIWebView* webView = [[UIWebView alloc] init];
    UIViewController* controller = [[UIViewController alloc] init];
    controller.view = webView;
    controller.modalPresentationStyle = UIModalPresentationPageSheet;
    controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [signInController presentViewController:controller animated:YES completion:^{
    
        [KCSUser getAccessDictionaryFromLinkedIn:^(NSDictionary *accessDictOrNil, NSError *errorOrNil) {
            [signInController dismissViewControllerAnimated:YES completion:^{
                if (errorOrNil == nil && accessDictOrNil != nil) {
                    //if we were able to successfully get the linkedin credentials, use them to log in to kinvey
                    [KCSUser loginWithSocialIdentity:KCSSocialIDLinkedIn accessDictionary:accessDictOrNil withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
                        [signInController actionComplete];
                        if (errorOrNil == nil) {
                            [_signInResponder userSucessfullySignedIn:user];
                        } else {
                            [self linkedInLoginFailed:errorOrNil];
                        }
                    }];
                } else {
                    [signInController actionComplete];
                    [self linkedInLoginFailed:errorOrNil];
                }
                
            }];
        } usingWebView:webView];
        
    }];
}


//choose the method based on the provider to obtain credentials
- (void) doSoicalSignIn:(KWSignInViewController *)signInController provider:(NSString *)signInProvider
{
    if (signInProvider == KWSignInTwitter) {
        [self twitterSignIn:signInController];
    } else if (signInProvider == KWSignInFacebook) {
        [self facebookSignIn:signInController];
    } else if (signInProvider == KWSignInLinkedIn) {
        [self linkedInSignIn:signInController];
    } else {
        @throw [NSException exceptionWithName:@"SocialIDNotSupported" reason:[NSString stringWithFormat:@"social provider '%@' not supported", signInProvider] userInfo:nil];
    }
}

#pragma mark - Password Reset

// given the username, sends the reset password link email to the user
- (void)doResetPassword:(KWResetPasswordController *)pwResetController username:(NSString *)username
{
    [KCSUser sendPasswordResetForUser:username withCompletionBlock:^(BOOL emailSent, NSError *errorOrNil) {
        [pwResetController actionComplete];
        
        //in this case show a pop-up alert to let the user know something happened, either way
        NSString* message;
        NSString* title;
        if (errorOrNil != nil) {
            message = [errorOrNil localizedDescription];
            title = NSLocalizedString(@"Password Reset Failed", @"Password reset failed title");
        } else {
            title = NSLocalizedString(@"Password Reset Sent", @"Password send okay title");
            message = NSLocalizedString(@"An email has been sent to the associated account. Check your inbox for the link.", @"Reset password email sent instructions");
        }
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                              otherButtonTitles: nil];
        [alert show];
        
    }];
}

// resends the email verification email
- (void) doSendEmailVerification:(NSString*)username
{
    [KCSUser sendEmailConfirmationForUser:username withCompletionBlock:^(BOOL emailSent, NSError *errorOrNil) {
        // For now, don't even bother retrying if the email was not sent.
    }];
}


- (void)doCreateAccount:(KWCreateAccountViewController *)createAccountController givenname:(NSString *)givenname surname:(NSString *)surname email:(NSString *)email password:(NSString *)password
{
    [KCSUser userWithUsername:email
                     password:password
              fieldsAndValues:@{KCSUserAttributeEmail : email, KCSUserAttributeGivenname: givenname, KCSUserAttributeSurname : surname}
          withCompletionBlock:^(KCSUser *user, NSError *errorOrNil, KCSUserActionResult result) {
        if (!errorOrNil) {
            [createAccountController actionComplete];
            if (errorOrNil ==  nil) {
//                [createAccountController.navigationController popViewControllerAnimated:YES];
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Account Creation Successful", @"account sucess note title")
                                                                message:[NSString stringWithFormat:NSLocalizedString(@"User '%@' created. Welcome %@ %@!", @"account success message body"), email, givenname, surname]
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                                      otherButtonTitles:nil];
                [alert show];
                if (_shouldSendEmailVerificationAfterSignup == YES) {
                    //send the email verificaiton if that is on the docket.
                    [self doSendEmailVerification:user.username];
                }
                //all set handle the loging success
                KWSignInViewController* signInController = createAccountController.signInController;
                [self handleSignInSuccess:signInController user:user];
            } else {
                //there was an error with the update save
                NSString* message = [errorOrNil localizedDescription];
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Create acccount failed", @"Sign acccount failed")
                                                                message:message
                                                               delegate:nil
                                                      cancelButtonTitle:NSLocalizedString(@"OK", @"OK")
                                                      otherButtonTitles: nil];
                [alert show];
            }
        }
    }];
}
@end
