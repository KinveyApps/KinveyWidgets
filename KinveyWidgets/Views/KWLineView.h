//
//  KWLineView.h
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

#import <UIKit/UIKit.h>

/** Enum to control if the line is vertical or horizontal */
typedef enum : NSUInteger {
    /** Draw the line along the top of the view */
    KWLineViewDirectionHorizontal,
    /** Draw the line along the left of the view */
    KWLineViewDirectionVertical
} KWLineViewDirection;

/** A simple view that draws a line along one of it's edges */
@interface KWLineView : UIView

/** The width of the line */
@property (nonatomic) CGFloat strokeWidth;
/** The color of the line */
@property (nonatomic, strong) UIColor* strokeColor;
/** The direction of the line */
@property (nonatomic) KWLineViewDirection lineDirection;
@end
