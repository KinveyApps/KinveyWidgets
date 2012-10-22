//
//  KWSignInBaseViewController.h
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
//  Created by Michael Katz on 10/9/12.
//

#import <UIKit/UIKit.h>
#import "KWSignInViewControllerDelegate.h"

/** Base calass for login subordinate controllers. This allows them to have a similiar look and feel */
@interface KWSignInBaseViewController : UIViewController

/** The sign in delegate. Passed in from `KWSignInViewController`'s when created */
@property (nonatomic, assign) id<KWSignInViewControllerDelegate> signInDelegate;

///@name KWSignInViewController pass-through properties & methods

// These are passed in from the parent controller and are the same as defined in KWSignInViewController

@property (nonatomic) BOOL showsActivityIndicator;

- (void) setBackgroundGradientColors:(NSArray *)backgroundGradientColors;
- (void) setButtonColor:(UIColor*)buttonColor;
- (void) actionComplete;

//private methods
- (void) setup;
- (BOOL) supportsRestore;
@end
