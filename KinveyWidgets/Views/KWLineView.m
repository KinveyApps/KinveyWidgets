//
//  KWLineView.m
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

#import "KWLineView.h"

@implementation KWLineView

- (void) setup
{
    self.backgroundColor = [UIColor clearColor];
    self.strokeWidth = 1.;
    self.strokeColor = [UIColor blackColor];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;
    CGRect pathRect;
    switch (_lineDirection) {
        case KWLineViewDirectionHorizontal:
            pathRect = CGRectMake(CGRectGetMinX(bounds), 0., CGRectGetMaxX(bounds), self.strokeWidth);
            break;
        case KWLineViewDirectionVertical:
            pathRect = CGRectMake(CGRectGetMinX(bounds), 0., self.strokeWidth, CGRectGetMaxY(bounds));
            break;
    }
    pathRect = CGRectIntersection(pathRect, rect);
    //Use a rectangle to capture using a non-1 width.
    //Sure this can be done with the CG code, but this is much easier
    UIBezierPath* path = [UIBezierPath bezierPathWithRect:pathRect];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinBevel;
    [self.strokeColor setFill];
    [path fill];
}


@end
