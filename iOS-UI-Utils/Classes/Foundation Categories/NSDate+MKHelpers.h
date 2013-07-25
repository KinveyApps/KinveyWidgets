//
//  NSDate+MKHelpers.h
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

#import <Foundation/Foundation.h>

/** Date Utils */
@interface NSDate (MKHelpers)

/** Formats the date with the given date format. See `NSDateFormatter` for input options. 
 
 This uses default NSDateFormatter options, and is subject to all its caveats.
 
 @param format the string, conforming to the OS version of Unicode Technical Standard 
 @return a formatted string, or `nil` if the format could not be computed
 */
- (NSString*) stringWithFormat:(NSString*)format;

@end
