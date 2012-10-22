//
//  KWForgotPasswordViewController.h
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

#import <UIKit/UIKit.h>

#import "KWSignInBaseViewController.h"

/** View controller to manage the password reset screen. 
 */
#if _IS_IOS_6
@interface KWResetPasswordController : KWSignInBaseViewController <UIViewControllerRestoration>
#else
@interface KWResetPasswordController : KWSignInBaseViewController
#endif

@end
