//
//  UILabel+MKHelpers.m
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

#import "UILabel+MKHelpers.h"

@implementation UILabel (MKHelpers)

- (void) adjustFontToFitMultiline
{
    CGSize selfSize = self.bounds.size;
    CGSize s = [self sizeThatFits:selfSize];
    UIFont* font = self.font; //this uses and sets the current font
    CGFloat fSize = [font pointSize];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
    CGFloat minSize = self.minimumScaleFactor * fSize;
#else
    CGFloat minSize = self.minimumFontSize;
#endif
    
    while (s.height > selfSize.height && fSize >= minSize) {
        fSize = fSize * .95; // decrease by 5 % each time
        UIFont* labelFont = [font fontWithSize:fSize];
        self.font = labelFont;
        s = [self sizeThatFits:CGSizeMake(selfSize.width, CGFLOAT_MAX)];
    }
}


@end
