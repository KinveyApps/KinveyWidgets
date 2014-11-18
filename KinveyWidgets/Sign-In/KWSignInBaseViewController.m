//
//  KWSignInBaseViewController.m
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

#import "KWSignInBaseViewController.h"
#import "KWGradientView.h"

@interface KWSignInBaseViewController ()

@end

@implementation KWSignInBaseViewController

- (BOOL) supportsRestore
{
    return [self respondsToSelector:@selector(restorationIdentifier)];
}

- (void) setup
{
    KWGradientView* view = [[KWGradientView alloc] init];
    self.view = view;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    _signInDelegate = nil;
    
}

- (id) init
{
    self = [super init];
    if (self) {
        [self setup];
        if ([self supportsRestore]) {
            self.restorationClass = [self class];
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - setups

- (void) setBackgroundGradientColors:(NSArray *)backgroundGradientColors
{
    ((KWGradientView*)self.view).colors = backgroundGradientColors;
}

- (void) setButtonColor:(UIColor*)buttonColor
{
    //noop implementation here, need to implemented by subclass
}

- (void)actionComplete
{
    //noop implementation here, need to implemented by subclass
}

#pragma mark - state restoration
#define kBGColorsKey @"backgroundcolors"
#define kTitleKey @"title"
- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    UIView* view = self.view;
    if ([self.view isKindOfClass:[UITableView class]]) {
        view = [(UITableView*)view backgroundView];
    }
    if ([view isKindOfClass:[KWGradientView class]]) {
        [coder encodeObject:((KWGradientView*)view).colors forKey:kBGColorsKey];
    }
    [coder encodeObject:self.title forKey:kTitleKey];
    [super encodeRestorableStateWithCoder:coder];
}

- (void) decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSArray* colors = [coder decodeObjectForKey:kBGColorsKey];
    if (colors) {
        [self setBackgroundGradientColors:colors];
    }
    self.title = [coder decodeObjectForKey:kTitleKey];
    [super decodeRestorableStateWithCoder:coder];
}

@end
