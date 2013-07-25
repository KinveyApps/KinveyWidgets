//
//  NSString+MKHelpers.m
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

#import "NSString+MKHelpers.h"

@implementation NSString (MKHelpers)

- (NSString*) substringBetweenRange1:(NSRange)range1 andRange2:(NSRange)range2
{
    NSUInteger start = range1.location + range1.length;
    NSUInteger end = range2.location;
    return [self substringWithRange:NSMakeRange(start, end - start)];
}

@end
