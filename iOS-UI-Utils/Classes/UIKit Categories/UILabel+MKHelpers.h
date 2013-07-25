//
//  UILabel+MKHelpers.h
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

/** UILabel utilities */
@interface UILabel (MKHelpers)

/** If you have a multi-line label and want to shrink the font so that everything fits inline, call this method after the frame is set. 
 
 This uses and sets the label's font property, and so if the label bounds are increased, the font must be reset so that the font size increases... this will only shrink the font.
 */
- (void) adjustFontToFitMultiline;
@end
