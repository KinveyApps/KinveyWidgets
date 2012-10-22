//
//  KCSSignInDelegate.h
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

#import <Foundation/Foundation.h>
#import <KinveyKit/KinveyKit.h>

#import "KWSignInViewControllerDelegate.h"

/**
 This is protocol must be implemented by any projects that want to make use of this Sign In Sample for use with Kinvey. See `AppDelegate.m` in KWSignIn project for an exmaple.
 */
@protocol KCSSignInResponder <NSObject>
/**
 This called once a user is sucessfully signed in. The `KCSSignInDelegate` handles all the other delegate paths through the `KWSignInViewController`.
 */
- (void) userSucessfullySignedIn:(KCSUser*)user;

@end

/** This is a Kinvey-specific implementation of `KWSignInViewControllerDelegate`. This handles sending call the login/create/resend calls to Kinvey's server. To use:
 
    1. Configure a `KCSClient` for the backend.
    2. If using Twitter for sign-in, configure the twitter credentials in the client
    3. If using Facebook for sign-in, configure the facebook credentials using the Facebook SDK
    4. Create an instance of this class & supply a signInResponder 
    5. Create a KWSignInViewController and assign this class instance as the `signInDelegate`.
    6. Push the controller onto a navigation stack or show modally.
 */
@interface KCSSignInDelegate : NSObject <KWSignInViewControllerDelegate>
/** Set to `YES` to send a verification email to the user after a new account is created. `NO` by default - email verification not required for this app. */
@property (nonatomic) BOOL shouldSendEmailVerificationAfterSignup;
/** Set to `YES` to require email verification in order for the user to continue using the app. `NO` by default - email verification not required or optional (at least temporarily) for this app. */
@property (nonatomic) BOOL emailVerificationRequired;
/** The class to respond to actions when the sign-in is complete. This should dismiss the sign-in view and display the app's main content. */
@property (nonatomic, weak) id<KCSSignInResponder> signInResponder;
@end
