//
//  KWSignInViewController.m
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

#import "KWSignInViewController.h"

#import "KWResetPasswordController.h"
#import "KWCreateAccountViewController.h"
#import "KWResendEmailVerificationController.h"

#import "KWGradientView.h"
#import "UIColor+MKHelpers.h"

#import "KWIconTextField.h"
#import "MKGradientButton.h"
#import "KWLinkButton.h"
#import "KWLineView.h"
#import "KWSocialButton.h"

#import "UILabel+MKHelpers.h"

#define kTitleFontSize 48.
#define kTitleFont [UIFont systemFontOfSize:kTitleFontSize]

NSString* const KWSignInFacebook = @"facebook";
NSString* const KWSignInTwitter = @"twitter";
NSString* const KWSignInLinkedIn = @"linkedIn";


@interface KWSignInViewController () <UITextFieldDelegate> {
    KWSocialButton* _twitterButton;
    KWSocialButton* _facebookButton;
    KWSocialButton* _linkedInButton;
    UIView* _titleView;
}
@property (nonatomic, strong) UIImageView* logoView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) KWLineView* lineView;
@end


@implementation KWSignInViewController

- (BOOL) supportsRestore
{
    //simple test to tell if the runtime is iOS6+, since this method doesn't exist in 5. 
    return [self respondsToSelector:@selector(restorationIdentifier)];
}

- (void) setup
{
    if ([self supportsRestore]) {
        [self setRestorationIdentifier:@"KWSignInViewController"];
        [self setRestorationClass:[self class]];
    }
    
    KWGradientView* view = [[KWGradientView alloc] init];
    _backgroundGradientColors = @[[UIColor colorWithHexString:@"#D95024"], [UIColor colorWithHexString:@"#AF401D"]];
    view.colors = _backgroundGradientColors;
    self.view = view;
    
    _signInDelegate = nil;
    
    _logo = [UIImage imageNamed:@"logo.png"];
    _logoView = [[UIImageView alloc] initWithImage:_logo];
    _logoView.contentMode = UIViewContentModeCenter;
    _titleView = _logoView;
    [view addSubview:_logoView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = kTitleFont;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.numberOfLines = 0;
#if _IS_IOS_6
    _titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _titleLabel.minimumScaleFactor = 0.2;
#else 
    _titleLabel.lineBreakMode = UILineBreakModeWordWrap;
    _titleLable.minimumFontSize = 10.;
#endif
    
    _usernameField = [[KWIconTextField alloc] initWithFrame:CGRectMake(20., 20., 360., 30.)];
    _usernameField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _usernameField.placeholder = NSLocalizedString(@"Email", @"Email");
    _usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _usernameField.autocorrectionType = UITextAutocorrectionTypeNo;
    _usernameField.keyboardType = UIKeyboardTypeEmailAddress;
    _usernameField.returnKeyType = UIReturnKeyNext;
    _usernameField.adjustsFontSizeToFitWidth = YES;
    _usernameField.delegate = self;
    ((KWIconTextField*)_usernameField).iconImage = [UIImage imageNamed:@"user"];
    [view addSubview:_usernameField];
    
    _passwordField = [[KWIconTextField alloc] initWithFrame:CGRectMake(20., 20., 360., 30.)];
    _passwordField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    _passwordField.placeholder = NSLocalizedString(@"Password", @"Password");
    _passwordField.secureTextEntry = YES;
    _passwordField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordField.autocorrectionType = UITextAutocorrectionTypeNo;
    _passwordField.returnKeyType = UIReturnKeyDone;
    _passwordField.adjustsFontSizeToFitWidth = YES;
    _passwordField.delegate = self;
    ((KWIconTextField*)_passwordField).iconImage = [UIImage imageNamed:@"lock"];
    [view addSubview:_passwordField];
    
    _signInButton = [[MKGradientButton alloc] init];
    [_signInButton setTitle:NSLocalizedString(@"Sign In", @"Sign In") forState:UIControlStateNormal];
    [_signInButton addTarget:self action:@selector(signIn:) forControlEvents:UIControlEventTouchUpInside];
    _buttonColor = [UIColor colorWithHexString:@"1F1F1F"];
    ((MKGradientButton*)_signInButton).buttonColor = _buttonColor;
    [view addSubview:_signInButton];
    
    _showsResetPasswordButton = YES;
    _resetPasswordButton = [[KWLinkButton alloc] init];
    [(KWLinkButton*)_resetPasswordButton setTitle:NSLocalizedString(@"<a>Forgot Password?</a>", @"Forgot Password?")];
    [_resetPasswordButton addTarget:self action:@selector(resetPassword) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_resetPasswordButton];
    
    _lineColor = [UIColor colorWithHexString:@"193754"];
    
    _socialLogins = @[KWSignInTwitter, KWSignInFacebook];
    [self setupSocialButtons];
    
    _showsCreateAccountButton = YES;
    _createAccountButton = [[KWLinkButton alloc] init];
    [(KWLinkButton*)_createAccountButton setTitle:NSLocalizedString(@"Don't Have an Account? <a>Sign Up</a>", @"Create account button")];
    [_createAccountButton addTarget:self action:@selector(createAccount) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:_createAccountButton];
    
    _showsActivityIndicator = YES;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - View Display
- (void) showModally
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //do this later to make sure view hierarchy is set-up
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:self];
        nav.navigationBar.barStyle = UIBarStyleBlack;
#if _IS_IOS_6
        nav.restorationIdentifier = @"modalsigningnav";
#endif
        //transfer this vc's modal information to the nav controller; lets the caller customize presentation
        nav.modalPresentationStyle = self.modalPresentationStyle;
        nav.modalTransitionStyle = self.modalPresentationStyle;
        
        //find the window to present this into. If you want to present this modally in another view controller, just modify this method
        //to have that controller as an argument
        UIWindow* window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
        [window.rootViewController presentViewController:nav animated:YES completion:^{}];
    });
}

#pragma mark - View setup
- (void)viewWillAppear:(BOOL)animated
{
    UINavigationController* parent = self.navigationController;
    if (parent == nil) {
        //This view needs a navigation stack
        [NSException raise:@"No Navigation Controller" format:@"KWSignInViewController needs to be presented in a UINavigationController"];
    }
    [parent setNavigationBarHidden:YES animated:animated];
}

#pragma mark - Default Overrides
- (void) setBackgroundGradientColors:(NSArray *)backgroundGradientColors
{
    _backgroundGradientColors = backgroundGradientColors;
    ((KWGradientView*)self.view).colors = _backgroundGradientColors;
}

- (void) setButtonColor:(UIColor *)buttonColor
{
    _buttonColor = buttonColor;
    ((MKGradientButton*)_signInButton).buttonColor = _buttonColor;
}
- (void) setLogo:(UIImage *)logo
{
    _logo = logo;
    _logoView.image = logo;
}

- (void) setShowsResetPasswordButton:(BOOL)showsResetPasswordButton
{
    _showsResetPasswordButton = showsResetPasswordButton;
    _resetPasswordButton.enabled = showsResetPasswordButton;
    _resetPasswordButton.hidden = !showsResetPasswordButton;
    [self.view setNeedsLayout];
}

- (void) setShowsCreateAccountButton:(BOOL)showsCreateAccountButton
{
    _showsCreateAccountButton = showsCreateAccountButton;
    _createAccountButton.enabled = showsCreateAccountButton;
    _createAccountButton.hidden = !showsCreateAccountButton;
    [self.view setNeedsLayout];
}

- (void) setSocialLogins:(NSArray *)socialLogins
{
    if (socialLogins == nil) {
        socialLogins = @[];
    }
    _socialLogins = socialLogins;
    [self setupSocialButtons];
}

- (void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
    [self setupSocialButtons];
}

- (void)setTitleType:(KWSignInViewControllerTitleType)titleType
{
    _titleType = titleType;
    [_titleView removeFromSuperview];
    switch (titleType) {
        case KWSIgnInViewControllerTitleImage:
            _titleView = _logoView;
            break;
        case KWSIgnInViewControllerTitleText:
            _titleView = _titleLabel;
            break;
    }
    [self.view addSubview:_titleView];
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}

- (NSString *)title
{
    return _titleLabel.text;
}

#pragma mark -  Layout
- (BOOL) hasSocialLogin
{
    return _socialLogins.count > 0;
}

- (void) setupSocialButtons
{
    [_lineView removeFromSuperview], _lineView = nil;
    [_twitterButton removeFromSuperview], _twitterButton = nil;
    [_facebookButton removeFromSuperview], _facebookButton = nil;
    [_linkedInButton removeFromSuperview], _linkedInButton = nil;

    if ([self hasSocialLogin]) {
        _lineView = [[KWLineView alloc] init];
        _lineView.strokeColor = _lineColor;
        [self.view addSubview:_lineView];
        
        if ([_socialLogins containsObject:KWSignInTwitter]) {
            _twitterButton = [KWSocialButton twitterButton];
            [_twitterButton setTitle:NSLocalizedString(@"Sign in with Twitter", @"Twitter button") forState:UIControlStateNormal];
            [_twitterButton addTarget:self action:@selector(socialSignIn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_twitterButton];
        } else {
            [_twitterButton removeFromSuperview], _twitterButton = nil;
        }
        
        if ([_socialLogins containsObject:KWSignInFacebook]) {
            _facebookButton = [KWSocialButton facebookButton];
            [_facebookButton setTitle:NSLocalizedString(@"Sign in with Facebook", @"Facebook button") forState:UIControlStateNormal];
            [_facebookButton addTarget:self action:@selector(socialSignIn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_facebookButton];
        } else {
            [_facebookButton removeFromSuperview], _facebookButton = nil;
        }
        
        if ([_socialLogins containsObject:KWSignInLinkedIn]) {
            _linkedInButton = [KWSocialButton linkedInButton];
            [_linkedInButton setTitle:NSLocalizedString(@"Sign in with LinkedIn", @"LinkedIn button") forState:UIControlStateNormal];
            [_linkedInButton addTarget:self action:@selector(socialSignIn:) forControlEvents:UIControlEventTouchUpInside];
            [self.view addSubview:_linkedInButton];
        } else {
            [_linkedInButton removeFromSuperview], _linkedInButton = nil;
        }
        
    }
    [self.view setNeedsLayout];
}

- (void)setTitlesForSocialButtonsForMode:(KWSocialButtonMode)mode {
    if (mode == KWSocialButtonModeIconOnly) {
        [_facebookButton setTitle:nil forState:UIControlStateNormal];
        [_linkedInButton setTitle:nil forState:UIControlStateNormal];
        [_twitterButton setTitle:nil forState:UIControlStateNormal];
    } else if (mode == KWSocialButtonModeDefault) {
        [_facebookButton setTitle:NSLocalizedString(@"Sign in with Facebook", @"Facebook button") forState:UIControlStateNormal];
        [_linkedInButton setTitle:NSLocalizedString(@"Sign in with LinkedIn", @"LinkedIn button") forState:UIControlStateNormal];
        [_twitterButton setTitle:NSLocalizedString(@"Sign in with Twitter", @"Twitter button") forState:UIControlStateNormal];
    }
}

// This view controller has three layouts: iPhone portrait, iPhone landscape, and iPad

#define kTopMargin 14.
#define kWidgetMargin 16.
#define kLandscapeLoginInterspacing 30.
#define kLandscapeLoginSocialInterspacing 14.
#define kTopMarginIPad 80.
#define kInputWidthIPad 300.
#define kSocialWithIPad 200.
#define kIPadLineOverhang 30.
#define kIPadWidgetHeight 32.
#define kLogoHeight 55.

- (void) layoutLandscape
{
    CGRect bounds = self.view.bounds;
    CGFloat tenP = roundf(bounds.size.width * 0.1);
    CGFloat eightyP = tenP * 8.;
    
    CGRect logoFrame = CGRectMake(0., kTopMargin, bounds.size.width, kLogoHeight);
    _titleView.frame = logoFrame;
    if (_titleType == KWSIgnInViewControllerTitleText) {
        _titleLabel.font = kTitleFont;
        [_titleLabel adjustFontToFitMultiline];
    }
    
    CGRect userFrame = CGRectMake(tenP, CGRectGetMaxY(logoFrame) + kWidgetMargin, eightyP, 30.);
    _usernameField.frame = userFrame;
    
    userFrame.origin.y = CGRectGetMaxY(userFrame) +  kWidgetMargin;
    _passwordField.frame = userFrame;
    
    userFrame.origin.y = CGRectGetMaxY(userFrame) +  kWidgetMargin;
    CGRect signInFrame = userFrame;
    signInFrame.size.width -= kLandscapeLoginInterspacing * 3. + _socialLogins.count * signInFrame.size.height + (_socialLogins.count - 1) * kLandscapeLoginSocialInterspacing;
    signInFrame.origin.x += kLandscapeLoginInterspacing;
    _signInButton.frame = signInFrame;
    
    if ([self hasSocialLogin]) {
        _lineView.hidden = YES;
        CGRect loginFrame = signInFrame;
        loginFrame.origin.x = CGRectGetMaxX(loginFrame) + kLandscapeLoginInterspacing - kLandscapeLoginSocialInterspacing - signInFrame.size.height;
        loginFrame.size.width = signInFrame.size.height;
        
        if ([_socialLogins containsObject:KWSignInTwitter]) {
            loginFrame.origin.x = CGRectGetMaxX(loginFrame) + kLandscapeLoginSocialInterspacing;
            _twitterButton.frame = loginFrame;
            _twitterButton.buttonMode = KWSocialButtonModeIconOnly;
        } else {
            userFrame = loginFrame;
        }
        
        if ([_socialLogins containsObject:KWSignInFacebook]) {
            loginFrame.origin.x = CGRectGetMaxX(loginFrame) + kLandscapeLoginSocialInterspacing;
            _facebookButton.frame = loginFrame;
            _facebookButton.buttonMode = KWSocialButtonModeIconOnly;
        }
        
        if ([_socialLogins containsObject:KWSignInLinkedIn]) {
            loginFrame.origin.x = CGRectGetMaxX(loginFrame) + kLandscapeLoginSocialInterspacing;
            _linkedInButton.frame = loginFrame;
            _linkedInButton.buttonMode = KWSocialButtonModeIconOnly;
        }
        [self setTitlesForSocialButtonsForMode:KWSocialButtonModeIconOnly];
    }
    
    if (_showsResetPasswordButton) {
        signInFrame.origin.y = CGRectGetMaxY(signInFrame) +  kWidgetMargin - 8.;
        _resetPasswordButton.frame = signInFrame;
    }
    
    if (_showsCreateAccountButton) {
        userFrame.origin.y = CGRectGetMaxY(self.view.bounds) - 36.;
        _createAccountButton.frame = userFrame;
    }
}

- (void) layoutPortrait
{
    CGRect bounds = self.view.bounds;
    CGFloat tenP = roundf(bounds.size.width * 0.1);
    CGFloat eightyP = tenP * 8.;
    
    CGRect logoFrame = CGRectMake(0., kTopMargin, bounds.size.width, kLogoHeight);
    _titleView.frame = logoFrame;
    if (_titleType == KWSIgnInViewControllerTitleText) {
        _titleLabel.font = kTitleFont;
        [_titleLabel adjustFontToFitMultiline];
    }
    
    CGRect userFrame = CGRectMake(tenP, CGRectGetMaxY(logoFrame) + kWidgetMargin, eightyP, kIPadWidgetHeight);
    _usernameField.frame = userFrame;
    
    userFrame.origin.y = CGRectGetMaxY(userFrame) +  kWidgetMargin;
    _passwordField.frame = userFrame;
    
    userFrame.origin.y = CGRectGetMaxY(userFrame) +  kWidgetMargin;
    _signInButton.frame = userFrame;
    
    if (_showsResetPasswordButton) {
        userFrame.origin.y = CGRectGetMaxY(userFrame) +  kWidgetMargin - 8.;
        _resetPasswordButton.frame = userFrame;
    }
    
    if ([self hasSocialLogin]) {
        CGRect lineFrame = CGRectIntegral(CGRectMake(tenP / 2., CGRectGetMaxY(userFrame) + kWidgetMargin, tenP * 9., 12.));
        _lineView.hidden = NO;
        _lineView.frame = lineFrame;
     
        //center social buttons in the space between the line and the bottom
        CGFloat bottom = CGRectGetMaxY(self.view.bounds);
        if (_showsCreateAccountButton) {
            bottom -= 36.;
        }
        CGFloat midRemaining = CGRectGetMaxY(lineFrame) + (bottom - CGRectGetMaxY(lineFrame)) / 2.;
        NSUInteger buttonCount = _socialLogins.count;
        CGFloat socialAreaHeight = buttonCount * userFrame.size.height + (buttonCount - 1) * kWidgetMargin;
        CGFloat socialY = midRemaining - socialAreaHeight / 2.;
        userFrame.origin.y = socialY - kWidgetMargin - userFrame.size.height;
        
        if ([_socialLogins containsObject:KWSignInTwitter]) {
            userFrame.origin.y = CGRectGetMaxY(userFrame) +  kWidgetMargin;
            _twitterButton.frame = userFrame;
            _twitterButton.buttonMode = KWSocialButtonModeDefault;
        }
        
        if ([_socialLogins containsObject:KWSignInFacebook]) {
            userFrame.origin.y = CGRectGetMaxY(userFrame) +  kWidgetMargin;
            _facebookButton.frame = userFrame;
            _facebookButton.buttonMode = KWSocialButtonModeDefault;
        }
        
        if ([_socialLogins containsObject:KWSignInLinkedIn]) {
            userFrame.origin.y = CGRectGetMaxY(userFrame) +  kWidgetMargin;
            _linkedInButton.frame = userFrame;
            _linkedInButton.buttonMode = KWSocialButtonModeDefault;
        }
        [self setTitlesForSocialButtonsForMode:KWSocialButtonModeDefault];
    }
    
    if (_showsCreateAccountButton) {
        userFrame.origin.y = CGRectGetMaxY(self.view.bounds) - 36.;
        _createAccountButton.frame = userFrame;
    }
}

- (void) layoutIPad
{
    CGRect bounds = self.view.bounds;
    
    CGRect logoFrame = CGRectMake(0., kTopMarginIPad, bounds.size.width, kLogoHeight);
    _titleView.frame = logoFrame;
    if (_titleType == KWSIgnInViewControllerTitleText) {
        _titleLabel.font = kTitleFont;
        [_titleLabel adjustFontToFitMultiline];
    }
    
    BOOL hasSocial = _socialLogins.count > 0;
    CGFloat centerConstant = hasSocial ? 4. : 2.;
    
    CGRect userFrame = CGRectMake(bounds.size.width / centerConstant - kInputWidthIPad / 2., CGRectGetMaxY(logoFrame) + 100., kInputWidthIPad, kIPadWidgetHeight);
    _usernameField.frame = userFrame;
    _usernameField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    userFrame.origin.y = CGRectGetMaxY(userFrame) + kWidgetMargin;
    _passwordField.frame = userFrame;
    _passwordField.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    userFrame.origin.y = CGRectGetMaxY(userFrame) + kWidgetMargin * 1.5;
    _signInButton.frame = userFrame;
    _signInButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    if (_showsResetPasswordButton) {
        userFrame.origin.y = CGRectGetMaxY(userFrame) + kWidgetMargin;
        _resetPasswordButton.frame = userFrame;
        _signInButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    }
    
    _lineView.hidden = !hasSocial;
    CGFloat y = CGRectGetMaxY(logoFrame) + 100. - kIPadLineOverhang;
    CGRect lineFrame = CGRectMake(bounds.size.width / 2., y, 2., CGRectGetMaxY(userFrame) - y + kIPadLineOverhang);
    _lineView.frame = lineFrame;
    _lineView.lineDirection = KWLineViewDirectionVertical;
    if (hasSocial) {    
        CGFloat socialY = y + lineFrame.size.height / 2. - (kIPadWidgetHeight*_socialLogins.count + kWidgetMargin*(_socialLogins.count - 1)) / 2.;
        CGRect socialFrame = CGRectMake(bounds.size.width * .75 - kSocialWithIPad / 2., socialY, kSocialWithIPad, kIPadWidgetHeight);
        
        if ([_socialLogins containsObject:KWSignInTwitter]) {
            _twitterButton.frame = socialFrame;
            _twitterButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
            socialFrame.origin.y = CGRectGetMaxY(socialFrame) + kWidgetMargin;
        }
        
        if ([_socialLogins containsObject:KWSignInFacebook]) {
            _facebookButton.frame = socialFrame;
            socialFrame.origin.y = CGRectGetMaxY(socialFrame) + kWidgetMargin;
        }

        if ([_socialLogins containsObject:KWSignInLinkedIn]) {
            _linkedInButton.frame = socialFrame;
            socialFrame.origin.y = CGRectGetMaxY(socialFrame) + kWidgetMargin;
        }
        
    }
    
    if (_showsCreateAccountButton) {
        userFrame.origin.y = CGRectGetMaxY(lineFrame) + 30.;
        userFrame.origin.x = bounds.size.width / 2. - userFrame.size.width / 2.;
        _createAccountButton.frame = userFrame;
    }
}

- (void) viewWillLayoutSubviews
{
    BOOL isIPad = [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad;
    if (isIPad) {
        [self layoutIPad];
    } else {
        BOOL isLandscape = UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation);
        if (isLandscape) {
            [self layoutLandscape];
        } else {
            [self layoutPortrait];
        }
    }
}

#pragma mark - Text Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _usernameField) {
        [_passwordField becomeFirstResponder];
        return NO;
    } else {
        [textField resignFirstResponder];
    }
    return YES;
}


#pragma mark - Actions
- (void) enableControls:(BOOL) enabled
{
    _signInButton.enabled = enabled;
    _resetPasswordButton.enabled = enabled;
    [_twitterButton setEnabled:enabled];
    [_facebookButton setEnabled:enabled];
    [_linkedInButton setEnabled:enabled];
    _createAccountButton.enabled = enabled;
}

- (void) signIn:(UIControl*)sender
{
    if (_signInDelegate != nil) {
        if (_showsActivityIndicator) {
            [self enableControls:NO];
            [(MKGradientButton*)sender startSpinner];
        }
        
        NSString* username = _usernameField.text;
        NSString* password = _passwordField.text;
        [self signInWithUsername:username password:password];
    }
}

- (void) signInWithUsername:(NSString*)username password:(NSString*)password
{
    //case username to lowercase - Kinvey is case sensitive on emails, but your service may or may not be
    [_signInDelegate doSignIn:self username:[username lowercaseString] password:password];
}

- (void) socialSignIn:(UIControl*)sender
{
    if (_signInDelegate != nil && [_signInDelegate respondsToSelector:@selector(doSoicalSignIn:provider:)]) {
        
        if (_showsActivityIndicator) {
            [self enableControls:NO];
            [(MKGradientButton*)sender startSpinner];
        }
        
        NSString* socialType;
        if (sender == _facebookButton) {
            socialType = KWSignInFacebook;
        } else if (sender == _twitterButton) {
            socialType = KWSignInTwitter;
        } else if (sender == _linkedInButton) {
            socialType = KWSignInLinkedIn;
        }
        [_signInDelegate doSoicalSignIn:self provider:socialType];
    }
}

- (void) actionComplete
{
    [(MKGradientButton*)_signInButton stopSpinner];
    [(MKGradientButton*)_facebookButton stopSpinner];
    [(MKGradientButton*)_twitterButton stopSpinner];
    [(MKGradientButton*)_linkedInButton stopSpinner];
    
    [self enableControls:YES];
}

- (void) resetPassword
{
    KWResetPasswordController* pwReset = [[KWResetPasswordController alloc] init];
    [pwReset setBackgroundGradientColors:_backgroundGradientColors];
    [pwReset setButtonColor:_buttonColor];
    pwReset.showsActivityIndicator = self.showsActivityIndicator;
    pwReset.signInDelegate = self.signInDelegate;
    pwReset.title = NSLocalizedString(@"Send Password Reset", @"Send Password Reset");
    [self.navigationController pushViewController:pwReset animated:YES];
}

- (void) createAccount
{
    KWCreateAccountViewController* create = [[KWCreateAccountViewController alloc] init];
    [create setBackgroundGradientColors:_backgroundGradientColors];
    [create setButtonColor:_buttonColor];
    create.showsActivityIndicator = self.showsActivityIndicator;
    create.signInDelegate = self.signInDelegate;
    create.title = NSLocalizedString(@"Sign Up", @"Create Account View Title");
    create.signInController = self;
    [self.navigationController pushViewController:create animated:YES];
}

- (void)showEmailVerificationScreen:(NSString*)username
{
    KWResendEmailVerificationController* resend = [[KWResendEmailVerificationController alloc] init];
    [resend setBackgroundGradientColors:_backgroundGradientColors];
    [resend setButtonColor:_buttonColor];
    resend.showsActivityIndicator = self.showsActivityIndicator;
    resend.signInDelegate = self.signInDelegate;
    resend.title = NSLocalizedString(@"Email Verification", @"Email Verification title");
    resend.username = username;
    [self.navigationController pushViewController:resend animated:YES];

}

#pragma mark - State Restoration

#define usernameTextKey @"usernametext"
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:_usernameField.text forKey:usernameTextKey];
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    _usernameField.text = [coder decodeObjectForKey:usernameTextKey];
    [super decodeRestorableStateWithCoder:coder];
}

+(UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    KWSignInViewController * myViewController = [[self alloc] init];
    //TODO: reassign delegate to the new controller
    //myViewController.signInDelegate = [(KWSigInAppDelegate*)UIApplication sharedApplication].signInDelegate;
    return myViewController;
}
@end
