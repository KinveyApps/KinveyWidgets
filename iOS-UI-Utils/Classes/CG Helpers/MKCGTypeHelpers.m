//
//  MKCGTypeHelpers.m
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


#import "MKCGTypeHelpers.h"

@implementation MKCGTypeHelpers

/**
 If dx is positive, shift the origin to the right, and shrink the width to match. If dx is negative, keep the origin in the same spot and just shrink left.
 */
CGRect CGRectInsetWidth(CGRect rect, CGFloat dx)
{
    //don't inset below bounds
    if (dx > rect.size.width) return rect;
    
    if (dx > 0) {
        rect.origin.x += dx;
        rect.size.width -= dx;
    } else {
        rect.size.width += dx;
    }
    return rect;
}

@end
