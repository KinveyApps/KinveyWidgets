//
//  KWGradientView.m
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


#import "KWGradientView.h"

@implementation KWGradientView

- (void) setup
{
    self.colors = @[];
}

- (id) init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    NSUInteger nColors = self.colors.count;
    NSMutableArray* cfColors = [NSMutableArray arrayWithCapacity:nColors];
    for (UIColor * c in _colors) {
        [cfColors addObject:(id)c.CGColor];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)(cfColors), NULL);
    CGContextDrawLinearGradient(context, gradient, rect.origin, CGPointMake(rect.origin.x+rect.size.width, rect.origin.y+rect.size.height), 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
}

@end
