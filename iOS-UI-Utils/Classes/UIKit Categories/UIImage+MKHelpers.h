//
//  UIImage+MKHelpers.h
//  iOS UI Utils
//
//  Copyright 2013 Michael Katz
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

/** Handy image utilities */
@interface UIImage (MKHelpers)

/** Creates a flat image of a solid color
 
 @param color the image color
 @param size the size to make the image
 @return an image of specified color and size
 */
+ (UIImage*) imageWithColor:(UIColor*)color size:(CGSize)size;

/** Creates a 2x2 flat image of a solid color.
 
 If the image is to be scaled or stretched by UIImageView or the like, a large image isn't needed since it's one flat color.
 
 @param color the image color
 @return an image of specified color
 */
+ (UIImage*) imageWithColor:(UIColor*)color;



@end
