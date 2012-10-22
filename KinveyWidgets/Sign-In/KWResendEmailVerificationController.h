//
//  KWResendEmailVerificationController.h
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
//  Created by Michael Katz on 10/12/12.
//

#import "KWSignInBaseViewController.h"

/** View controller to display a button to resend the email confirmation to a user. This can be used in a situation where the email confirmation is requried or just optional, but this sample code only displays it if an email confirmation is required */
@interface KWResendEmailVerificationController : KWSignInBaseViewController
/** The username to send the email confirmation to */
@property (nonatomic, copy) NSString* username;
@end
