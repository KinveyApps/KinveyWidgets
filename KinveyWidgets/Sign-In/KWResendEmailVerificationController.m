//
//  KWResendEmailVerificationController.m
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

#import "KWResendEmailVerificationController.h"
#import "MKGradientButton.h"

@interface KWResendEmailVerificationController () {
    MKGradientButton* _sendEmailVerificaitonButton;
    UILabel* _instructionLabel;
}
@end

@implementation KWResendEmailVerificationController

- (void)setup
{
    [super setup];
    
    _instructionLabel = [[UILabel alloc] init];
    _instructionLabel.text = NSLocalizedString(@"Before you can sign in, please check your email to active your user account. If you don't receive an email in a few seconds, please check your spam filters.", @"Email not verified message.");
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations" //ignore for iOS 5 & 6 compatibility
    _instructionLabel.lineBreakMode = UILineBreakModeWordWrap;
#pragma clang diagnostic pop
    _instructionLabel.backgroundColor = [UIColor clearColor];
    _instructionLabel.numberOfLines = 0;
    [self.view addSubview:_instructionLabel];
    
    _sendEmailVerificaitonButton = [[MKGradientButton alloc] init];
    [_sendEmailVerificaitonButton setTitle:NSLocalizedString(@"Resend Verification Email", @"Resend email verification button") forState:UIControlStateNormal];
    [_sendEmailVerificaitonButton addTarget:self action:@selector(resendEmail:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_sendEmailVerificaitonButton];
}


#define kWidgetMargin 16.

- (void) viewWillLayoutSubviews
{
    CGRect bounds = self.view.bounds;
    CGFloat tenP = roundf(bounds.size.width * 0.1);
    CGFloat eightyP = tenP * 8.;
    
    CGSize labelSize = [_instructionLabel.text sizeWithFont:_instructionLabel.font constrainedToSize:CGSizeMake(eightyP, CGFLOAT_MAX) lineBreakMode:_instructionLabel.lineBreakMode];
    CGRect labelFrame = CGRectMake(tenP, kWidgetMargin, eightyP, labelSize.height);
    _instructionLabel.frame = labelFrame;
    
    CGRect buttonFrame = CGRectMake(tenP, CGRectGetMaxY(labelFrame) + kWidgetMargin, eightyP, 30.);
    _sendEmailVerificaitonButton.frame = buttonFrame;
    
}

- (void) setButtonColor:(UIColor*)buttonColor
{
    ((MKGradientButton*)_sendEmailVerificaitonButton).buttonColor = buttonColor;
}

//callback from the resend email button 
- (void) resendEmail:(MKGradientButton*)sender
{
    if (self.signInDelegate != nil && [self.signInDelegate respondsToSelector:@selector(doSendEmailVerification:username:)]) {
        if (self.showsActivityIndicator) {
            sender.enabled = NO;
            [(MKGradientButton*)sender startSpinner];
        }
        
        [self.signInDelegate doSendEmailVerification:self.username];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
