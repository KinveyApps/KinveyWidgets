//
//  UIWindow+MKHelpers.m
//  iOS UI Utils
//
//  Copyright 2012 Michael Katz
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

#import "UIWindow+MKHelpers.h"

@implementation UIWindow (MKHelpers)

+ (UIView*) keyboardView
{
    UIView* keyboardView = nil;
    //the keyboard view may not be in the main window
    for (UIWindow* window in [[UIApplication sharedApplication] windows]) {
        for (UIView* view in window.subviews) {
            //this works in iOS 4+, if you still need to check for UIKeyboard as well
            if ([[[view class] description] hasPrefix:@"UIPeripheralHostView"]) {
                keyboardView = view;
            }
        }
    }
    return keyboardView;
}

@end
