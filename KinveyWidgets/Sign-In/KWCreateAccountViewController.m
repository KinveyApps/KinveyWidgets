//
//  KWCreateAccountViewController.m
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

#import "KWCreateAccountViewController.h"
#import "KWGradientView.h"
#import "MKGradientButton.h"

#if _IS_IOS_6
@interface KWCreateAccountViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIDataSourceModelAssociation>
#else
@interface KWCreateAccountViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>
#endif
{
    MKGradientButton* _createAccountButton;
    NSIndexPath* _selectedIndexPath;
    UITextField* _lastTextField;
    
    NSString* _surname;
    NSString* _givenname;
    NSString* _password;
    NSString* _passwordretry;
    NSString* _email;
}

@end

@implementation KWCreateAccountViewController

- (void) setup
{
    [super setup];
    
    if ([self supportsRestore]) {
        self.restorationClass = [self class];
        self.restorationIdentifier = @"KWCreateAccountViewController";
    }
    
    //create table view
    UITableView* v = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] bounds] style:UITableViewStyleGrouped];
    v.backgroundView = self.view;
    v.dataSource = self;
    v.delegate = self;
    v.restorationIdentifier = @"tableView";
    
    _createAccountButton = [[MKGradientButton alloc] initWithFrame:CGRectMake(10., 7., 300., 30.)];
    [_createAccountButton setTitle:NSLocalizedString(@"Create Account", @"Create Account button label") forState:UIControlStateNormal];
    _createAccountButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
    [_createAccountButton addTarget:self action:@selector(createAccount) forControlEvents:UIControlEventTouchUpInside];
    _createAccountButton.enabled = NO;
    
    
    UIView* footer = [[UIView alloc] initWithFrame:CGRectMake(0., 0., 320., 44)];
    footer.backgroundColor = [UIColor clearColor];
    footer.autoresizesSubviews = YES;
    [footer addSubview:_createAccountButton];
    v.tableFooterView = footer;
    self.view = v;
    
    _surname = _givenname = _password = _passwordretry = _email = @"";
}

- (void) setBackgroundGradientColors:(NSArray *)backgroundGradientColors
{
    ((KWGradientView*)((UITableView*)self.view).backgroundView).colors = backgroundGradientColors;
}

- (void) setButtonColor:(UIColor*)buttonColor
{
    ((MKGradientButton*)_createAccountButton).buttonColor = buttonColor;
}

#pragma mark - view controller
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - table view
// Table View is Defined as such
//+-----------------------------+
//|          Section 0          |
//| row 0: first name     (100) |
//| row 1: last name      (101) |
//|                             |
//|          Section 1          |
//| row 0: email          (110) |
//|                             |
//|          Section 2          |
//| row 0: password       (120) |
//| row 1: password retry (121) |
//+-----------------------------+

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString*) placeholderForTag:(int)tag
{
    switch (tag) {
        case 100:
            return NSLocalizedString(@"First Name", @"Given name field");
            break;
        case 101:
            return NSLocalizedString(@"Last Name", @"Surname field");
            break;
        case 110:
            return NSLocalizedString(@"Email", @"Email field");
            break;
        case 120:
            return NSLocalizedString(@"Password", @"Password field");
            break;
        case 121:
            return  NSLocalizedString(@"Re-enter password", @"Reenter password field");
            break;
    }
    return nil;
}

- (NSString*) textForTag:(int)tag
{
    switch (tag) {
        case 100:
            return _givenname;
            break;
        case 101:
            return _surname;
            break;
        case 110:
            return _email;
            break;
        case 120:
            return _password;
            break;
        case 121:
            return _passwordretry;
            break;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* reuseIdentifier = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.contentView.autoresizesSubviews = YES;
        
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(8., 8., cell.contentView.bounds.size.width - 16., 39.)];
        textField.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        textField.delegate = self;
        [cell.contentView addSubview:textField];
    }
    
    UITextField* textField = [cell.contentView.subviews objectAtIndex:0];
    textField.tag = indexPath.section * 10 + indexPath.row + 100;
    textField.placeholder = [self placeholderForTag:textField.tag];
    textField.text = [self textForTag:textField.tag];
    textField.returnKeyType = (indexPath.section == 2 && indexPath.row == 1) ? UIReturnKeyDone : UIReturnKeyNext;
    textField.secureTextEntry = indexPath.section == 2;
    textField.autocorrectionType = UITextAutocorrectionTypeNo;
    textField.autocapitalizationType = indexPath.section == 0 ? UITextAutocapitalizationTypeWords : UITextAutocapitalizationTypeNone;
    textField.keyboardType = indexPath.section == 1 ? UIKeyboardTypeEmailAddress : UIKeyboardTypeDefault;
    textField.rightViewMode = UITextFieldViewModeUnlessEditing;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Text & Keyboard

- (void) keyboardChanged:(NSNotification*)note
{
    UITableView* tableView = (UITableView*)self.view;
    CGRect endFrame = [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    endFrame = [tableView.window convertRect:endFrame toView:tableView];
    CGFloat dy = tableView.bounds.size.height - CGRectGetMinY(endFrame);
    tableView.contentInset = UIEdgeInsetsMake(0., 0., dy, 0.);
    
    CGRect rect = [tableView convertRect:_lastTextField.frame fromView:_lastTextField.superview];
    [tableView scrollRectToVisible:rect animated:YES];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    _lastTextField = textField;
    UITableView* tableView = (UITableView*)self.view;
    CGRect rect = [tableView convertRect:_lastTextField.frame fromView:_lastTextField.superview];
    [tableView scrollRectToVisible:rect animated:YES];
    return YES;
}

- (void)setText:(NSString*)text forTag:(int)tag
{
    switch (tag) {
        case 100:
            _givenname = text;
            break;
        case 101:
            _surname = text;
            break;
        case 110:
            _email = [text lowercaseString]; //convert to lower case for normalized matching
            break;
        case 120:
            _password = text;
            break;
        case 121:
            _passwordretry = text;
            break;
    }
    
    BOOL valid = _givenname.length > 0 && _surname.length > 0 && _email.length > 0 && _password.length > 0 && [_password isEqualToString:_passwordretry];

    UITableView* tableView = (UITableView*)self.view;
    UITableViewCell* resetCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:2]];
    UITextField* retryField = [resetCell.contentView.subviews objectAtIndex:0];
    if ([_password isEqualToString:_passwordretry] == NO) {
        UILabel* label = [[UILabel alloc] init];
        label.text = NSLocalizedString(@"Passwords Must Match", @"password repeat must match warning");
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor redColor];
        label.font = [UIFont boldSystemFontOfSize:10.];
        [label sizeToFit];
        retryField.rightView = label;
    } else {
        retryField.rightView = nil;
    }
    _createAccountButton.enabled = valid;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self setText:textField.text forTag:textField.tag];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    UITableView* tableView = (UITableView*)self.view;
    NSIndexPath* indexPath = [tableView indexPathForRowAtPoint:[tableView convertPoint:textField.center fromView:textField.superview]];
    if (textField.tag == 121) {
        [textField resignFirstResponder];
        return YES;
    } else {
        NSIndexPath* next = [NSIndexPath indexPathForRow:1 inSection:2];
        switch (indexPath.section) {
            case 0:
                next = indexPath.row == 0 ? [NSIndexPath indexPathForRow:1 inSection:0] :  [NSIndexPath indexPathForRow:0 inSection:1];
                break;
            case 1:
                next = [NSIndexPath indexPathForRow:0 inSection:2];
                break;
            case 2:
                next = [NSIndexPath indexPathForRow:1 inSection:2];
            default:
                break;
        }
        UITableViewCell* nextCell = [tableView cellForRowAtIndexPath:next];
        [[[nextCell.contentView subviews] objectAtIndex:0] becomeFirstResponder];
        return NO;
    }
}


#pragma mark - actions
- (void) createAccount
{
    [_lastTextField resignFirstResponder];
    if (self.showsActivityIndicator) {
        [_createAccountButton startSpinner];
        _createAccountButton.enabled = NO;
    }
    [self.signInDelegate doCreateAccount:self givenname:_givenname surname:_surname email:_email password:_password];
}

- (void)actionComplete
{
    [(MKGradientButton*)_createAccountButton stopSpinner];
    _createAccountButton.enabled = YES;
}

#pragma mark - State Restoration
#define kEmailTextKey @"emailText"
#define kActivityKey @"showsActivity"
#define kButtonColorKey @"buttonColor"
#define kTextKey @"text"
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeBool:self.showsActivityIndicator forKey:kActivityKey];
    [coder encodeObject:((MKGradientButton*)_createAccountButton).buttonColor forKey:kButtonColorKey];
    
    NSMutableArray* textVals = [NSMutableArray arrayWithCapacity:5];
    for (int i=100; i <= 121; i++) { //enumarate through text fields. This will have a lot of empty values, but is fast so not doing something more optimized for now
        UITextField* text = (UITextField*)[(UITableView*)self.view viewWithTag:i];
        if (text && text.text != nil) {
            //for each row, record for the textfield it's tag, text, and whether it has the keybaord focus
            [textVals addObject:@[@(i), text.text, @(text.isFirstResponder)]];
        }
    }
    [coder encodeObject:textVals forKey:kTextKey];
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    self.showsActivityIndicator = [coder decodeBoolForKey:kActivityKey];
    [self setButtonColor:[coder decodeObjectForKey:kButtonColorKey]];
    NSArray* textVals = [coder decodeObjectForKey:kTextKey];
    if (textVals) {
        for (NSArray* textState in textVals) {
            int tag = [[textState objectAtIndex:0] intValue];
            NSString* text = [textState objectAtIndex:1];
            [self setText:text forTag:tag];
            if ([[textState objectAtIndex:2] boolValue] == YES) {
                UITextField* textField = (UITextField*)[(UITableView*)self.view viewWithTag:tag];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [textField becomeFirstResponder];
                });
            }
        }
    }
    [super decodeRestorableStateWithCoder:coder];
}

+(UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    KWCreateAccountViewController* controller = [[self alloc] init];
    //TODO: reassign delegate to the new controller
    //myViewController.signInDelegate = [(KWSigInAppDelegate*)UIApplication sharedApplication].signInDelegate;
    
    return controller;
}

- (NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)indexPath inView:(UIView *)view
{
    return [NSString stringWithFormat:@"%i-%i", indexPath.section, indexPath.row];
}

- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier inView:(UIView *)view
{
    NSArray* elements = [identifier componentsSeparatedByString:@"-"];
    return [NSIndexPath indexPathForRow:[[elements objectAtIndex:1] intValue] inSection:[[elements objectAtIndex:0] intValue]];
}
@end
