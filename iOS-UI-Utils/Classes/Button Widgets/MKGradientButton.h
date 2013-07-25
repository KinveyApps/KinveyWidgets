//
//  MKGradientButton.h
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

#import <UIKit/UIKit.h>

/* A SHINY rounded-rect, gradient button */
@interface MKGradientButton : UIButton

/* If you just want to the gradient as a range around a single color, just set the `buttonColor`. This will create a slight gradient using a lighter and darker version.
 */
@property (nonatomic, retain) UIColor* buttonColor;
/* Instead of specifying a single color, an array of UI colors (from top to bottom) can be supplied to form the gradient.
 */
@property (nonatomic, copy) NSArray* gradientArray;

/* Just the color for the button's border.
 */
@property (nonatomic, retain) UIColor* borderColor;

/* Show a animated spinner in the right inside of the button */
- (void) startSpinner;
/* Stop and hide the spinner */
- (void) stopSpinner;
@end
