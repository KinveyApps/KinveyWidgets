//
//  KWIconTextField.m
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

#import "KWIconTextField.h"
#import "MKCGTypeHelpers.h"


@implementation KWIconTextField

- (void) setup
{
    self.borderStyle = UITextBorderStyleRoundedRect;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setIconImage:(UIImage *)iconImage
{
    if (iconImage != nil) {
        self.leftView = [[UIImageView alloc] initWithImage:iconImage];
        self.leftViewMode = UITextFieldViewModeAlways;
    } else {
        self.leftView = nil;
        self.leftViewMode = UITextFieldViewModeNever;
    }
}


#pragma mark - adjust bounds

//This is to make the widgets inside KWSignInViewController look better because their bounds are set below the UITextView minimum
#define kInset 2.;

- (CGRect)textRectForBounds:(CGRect)bounds;
{
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.y += kInset;
    return rect;
}

- (CGRect)editingRectForBounds:(CGRect)bounds
{
    CGRect rect = [super textRectForBounds:bounds];
    rect.origin.y += kInset;
    return rect;    
}

@end
