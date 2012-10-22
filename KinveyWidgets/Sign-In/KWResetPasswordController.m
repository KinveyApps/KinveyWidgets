//
//  KWForgotPasswordViewController.m
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

#import "KWResetPasswordController.h"
#import "MKGradientButton.h"

@interface KWResetPasswordController ()
@property (nonatomic, strong) UITextField* usernameField;
@property (nonatomic, strong) UILabel* instructionLabel;
@property (nonatomic, strong) UIButton* resetPasswordButton;
@end

@implementation KWResetPasswordController

- (void) setup
{
    [super setup];
    
    if ([self supportsRestore]) {
        self.restorationClass = [KWResetPasswordController class];
        self.restorationIdentifier = @"KWResetPasswordController";
    }
    
    _instructionLabel = [[UILabel alloc] init];
    _instructionLabel.text = NSLocalizedString(@"Enter your username below to email a password reset link to you.", @"Password reset instructions");
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations" //ignore for iOS 5 & 6 compatibility
    _instructionLabel.lineBreakMode = UILineBreakModeWordWrap;
#pragma clang diagnostic pop
    _instructionLabel.backgroundColor = [UIColor clearColor];
    _instructionLabel.numberOfLines = 0;
    [self.view addSubview:_instructionLabel];
    
    
    _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(20., 20., 360., 30.)];
    _usernameField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _usernameField.placeholder = NSLocalizedString(@"Email", @"Email");
    _usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    _usernameField.keyboardType = UIKeyboardTypeEmailAddress;
    _usernameField.returnKeyType = UIReturnKeyDone;
    _usernameField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_usernameField];
    
    _resetPasswordButton = [[MKGradientButton alloc] init];
    [_resetPasswordButton setTitle:NSLocalizedString(@"Reset Password", @"Reset Password") forState:UIControlStateNormal];
    [_resetPasswordButton addTarget:self action:@selector(resetPassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_resetPasswordButton];
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
    
    CGRect pwFrame = CGRectMake(tenP, CGRectGetMaxY(labelFrame) + kWidgetMargin, eightyP, 30.);
    _usernameField.frame = pwFrame;
    
    pwFrame.origin.y = CGRectGetMaxY(pwFrame) + kWidgetMargin;
    _resetPasswordButton.frame = pwFrame;

}

- (void) setButtonColor:(UIColor*)buttonColor
{
    ((MKGradientButton*)_resetPasswordButton).buttonColor = buttonColor;
}

- (void) resetPassword:(UIControl*)sender
{
    [_usernameField resignFirstResponder];
    if (self.signInDelegate != nil && [self.signInDelegate respondsToSelector:@selector(doResetPassword:username:)]) {
        if (self.showsActivityIndicator) {
            sender.enabled = NO;
            [(MKGradientButton*)sender startSpinner];
        }
        
        NSString* username = _usernameField.text;
        [self.signInDelegate doResetPassword:self username:username];
    }
}

- (void) actionComplete
{
    [(MKGradientButton*)_resetPasswordButton stopSpinner];
    _resetPasswordButton.enabled = YES;
}


#pragma mark - State Restoration
#define kEmailTextKey @"emailText"
#define kActivityKey @"showsActivity"
#define kButtonColorKey @"buttonColor"
#define kFirstResponderKey @"firstResponder"
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_usernameField.text forKey:kEmailTextKey];
    [coder encodeBool:self.showsActivityIndicator forKey:kActivityKey];
    [coder encodeObject:((MKGradientButton*)_resetPasswordButton).buttonColor forKey:kButtonColorKey];
    [coder encodeBool:_usernameField.isFirstResponder forKey:kFirstResponderKey];
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    _usernameField.text = [coder decodeObjectForKey:kEmailTextKey];
    self.showsActivityIndicator = [coder decodeBoolForKey:kActivityKey];
    [self setButtonColor:[coder decodeObjectForKey:kButtonColorKey]];
    if ([coder decodeBoolForKey:kFirstResponderKey]) {
        [_usernameField becomeFirstResponder];
    }
    [super decodeRestorableStateWithCoder:coder];
}

+(UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    KWResetPasswordController* controller = [[self alloc] init];
    //TODO: reassign delegate to the new controller
    //myViewController.signInDelegate = [(KWSigInAppDelegate*)UIApplication sharedApplication].signInDelegate;
    
    return controller;
}
@end
