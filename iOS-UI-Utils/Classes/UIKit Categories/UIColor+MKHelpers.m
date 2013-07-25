//
//  UIColor+KinveyHelpers.m
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

#import "UIColor+MKHelpers.h"

#define doubleIt(str) [str stringByAppendingString:str]

@implementation UIColor (MKHelpers)

NSUInteger hexToUInt(NSString* hexVal)
{
    NSUInteger val = 0;
    while (hexVal.length) {
        val *= 16;
        NSUInteger thisLetter = 0;
        unichar thisChar = [hexVal characterAtIndex:0];
        switch (thisChar) {
            case '0'...'9':
                thisLetter = thisChar - '0';
                break;
            case 'a'...'f':
                thisLetter = thisChar - 'a' + 10;
                break;
            case 'A' ... 'F':
                thisLetter = thisChar - 'A' + 10;
                break;
            default:
                thisLetter = -1;
                break;
        }
        if (thisLetter == -1) {
            @throw [NSException exceptionWithName:@"Invalid hex" reason:@"hex strings should be between '0' and 'A'" userInfo:nil];
        }
        val += thisLetter;
        hexVal = [hexVal substringFromIndex:1];
    }
    return val;
}

+ (UIColor*) colorWithHexString:(NSString*)hexVal
{
    NSString* trimmed = [hexVal stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    NSString* redString = @"00";
    NSString* blueString = @"00";
    NSString* greenString = @"00";
    if (trimmed.length == 3) {
        //#FFF value
        redString = doubleIt([trimmed substringWithRange:NSMakeRange(0, 1)]);
        greenString = doubleIt([trimmed substringWithRange:NSMakeRange(1, 1)]);
        blueString = doubleIt([trimmed substringWithRange:NSMakeRange(2, 1)]);
    } else {
        redString = [trimmed substringWithRange:NSMakeRange(0, 2)];
        greenString = [trimmed substringWithRange:NSMakeRange(2, 2)];
        blueString = [trimmed substringWithRange:NSMakeRange(4, 2)];
    }
    return [UIColor colorWithIntRed:hexToUInt(redString) green:hexToUInt(greenString) blue:hexToUInt(blueString)];
}

+ (UIColor*) colorWithIntRed:(NSUInteger)red green:(NSUInteger)green blue:(NSUInteger)blue
{
    return [self colorWithRed:red/255. green:green/255. blue:blue/255. alpha:1.];
}

- (UIColor*) brightenBy:(CGFloat)brightnessMod
{
    CGFloat hue;
    CGFloat satuation;
    CGFloat brightness;
    CGFloat alpha;
    if ([self getHue:&hue saturation:&satuation brightness:&brightness alpha:&alpha]) {
        brightness = MIN(1., MAX(0., brightness + brightnessMod));
        return [UIColor colorWithHue:hue saturation:satuation brightness:brightness alpha:alpha];
    } else {
        return self;
    }
}

- (UIColor*) darkerColor
{
    return [self brightenBy:-.33];
}

- (UIColor*) lighterColor
{
    return [self brightenBy:.33];
}

@end
