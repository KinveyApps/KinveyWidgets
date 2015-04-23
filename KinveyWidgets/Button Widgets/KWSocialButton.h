//
//  KWSocialButton.h
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

#import "MKGradientButton.h"

/** Choice between button with icon & text or just icon */
typedef enum KWSocialButtonMode : NSUInteger {
    /** Show both text and icon */
    KWSocialButtonModeDefault,
    /** Show just the icon and no split-line */
    KWSocialButtonModeIconOnly
} KWSocialButtonMode;

/* A simple gradient button that shows a social provider icon the left, a two-toned split line and the label text on the right. An optional mode just shows the icon in order shrink the button down and still be indicative of what it is. */
@interface KWSocialButton : MKGradientButton


#pragma mark - properties
/** the color for the left tone of the split line */
@property (nonatomic, retain) UIColor* splitLineColorLeft;
/** the color for the right tone of the split line */
@property (nonatomic, retain) UIColor* splitLineColorRight;
/** if the button is in icon only or icon + text mode */
@property (nonatomic) KWSocialButtonMode buttonMode;


#pragma mark - constructors
///@name Built-in constructors

/** A button with the Twitter bird and in Twitter colors */
+ (KWSocialButton*) twitterButton;
/** A button with the Facebook "f" and the Facebook colors */
+ (KWSocialButton *)facebookButton;
/** A button with the Facebook "f" and the Facebook colors */
+ (KWSocialButton *)linkedInButton;
/** A button with the Google+ "g+" and the Google+ colors */
+ (KWSocialButton *)googlePlusButton;


@end
