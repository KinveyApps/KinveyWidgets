//
//  NSString+MKHelpers.h
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

#import <Foundation/Foundation.h>

/** String utils */
@interface NSString (MKHelpers)

/* Find the substring between two ranges, exclusive. That is the return will be the substring starting the character after range1 ends and stops before range2 begins. 
 
 @param range1 the range defining the start location
 @param range2 the range defining the end location
 @return the substring between range1 and range2.
 */
- (NSString*) substringBetweenRange1:(NSRange)range1 andRange2:(NSRange)range2;
@end
