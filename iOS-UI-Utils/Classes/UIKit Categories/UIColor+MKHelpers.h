//
//  UIColor+KinveyHelpers.h
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

#import <UIKit/UIKit.h>

/* Color Utils */
@interface UIColor (MKHelpers)

/** Creates a color with a hex color string. This makes it easy to take values from designers or web pages and creating the color object.

 If you care to set the alpha, just apply -[UIColor colorWithAlphaComponent:] on the return object;

 @param hexVal - a string in the format @"#RRGGBB" or @"RRGGBB"
 @return a color object with supplied value
 */
+ (UIColor*) colorWithHexString:(NSString*)hexVal;
/** Creates a color object using values 0..255 for the red, green, and blue values. This is easier to use if you get your colors from color pickers. 
 
 If you care to set the alpha, just apply -[UIColor colorWithAlphaComponent:] on the return object;
 
 @param red the red value
 @param green the green value
 @param blue the blue value
 @return a color object with the supplied value
 */
+ (UIColor*) colorWithIntRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue;

/** Creates a darker version of the color object */
- (UIColor*) darkerColor;
/** Creates a lighter version of the color object */
- (UIColor*) lighterColor;
@end
