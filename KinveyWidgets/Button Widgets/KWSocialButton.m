//
//  KWSocialButton.m
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
//  Created by Michael Katz on 10/9/12.
//

#import "KWSocialButton.h"
#import "UIColor+MKHelpers.h"

@implementation KWSocialButton

#pragma mark - Constructors

+ (KWSocialButton *)twitterButton
{
    KWSocialButton* button = [[KWSocialButton alloc] initWithFrame:CGRectMake(0., 0., 240., 30.)];
    button.gradientArray = @[[UIColor colorWithHexString:@"#4AC6FA"], [UIColor colorWithHexString:@"#2499CE"]];
    button.borderColor = [UIColor clearColor];
    UIImage* image = [UIImage imageNamed:@"twitter"];
    [button setImage:image forState:UIControlStateNormal];
    button.splitLineColorLeft = [UIColor colorWithHexString:@"5ECEFC"];
    button.splitLineColorRight = [UIColor colorWithHexString:@"5ECEFC"];
    button.adjustsImageWhenHighlighted = NO;
    button.imageView.contentMode = UIViewContentModeCenter;
    return button;
}

+ (KWSocialButton *)facebookButton
{
    KWSocialButton* button = [[KWSocialButton alloc] initWithFrame:CGRectMake(0., 0., 240., 30.)];
    button.gradientArray = @[[UIColor colorWithHexString:@"#6D89B9"], [UIColor colorWithHexString:@"#445F8E"]];
    button.borderColor = [UIColor clearColor];
    UIImage* image = [UIImage imageNamed:@"facebook"];
    [button setImage:image forState:UIControlStateNormal];
    button.splitLineColorLeft = [UIColor colorWithHexString:@"1F3C6F"];
    button.splitLineColorRight = [UIColor colorWithHexString:@"92ACD7"];
    button.adjustsImageWhenHighlighted = NO;
    button.imageView.contentMode = UIViewContentModeCenter;
    return button;
}

+ (KWSocialButton *)linkedInButton
{
    KWSocialButton* button = [[KWSocialButton alloc] initWithFrame:CGRectMake(0., 0., 240., 30.)];
    button.gradientArray = @[[UIColor colorWithHexString:@"8BC4DC"], [UIColor colorWithHexString:@"0375A3"]];
    button.borderColor = [UIColor clearColor];
    UIImage* image = [UIImage imageNamed:@"linkedIn"];
    [button setImage:image forState:UIControlStateNormal];
    button.splitLineColorLeft = [UIColor colorWithHexString:@"035E83"];
    button.splitLineColorRight = [UIColor colorWithHexString:@"A5DBF1"];
    button.adjustsImageWhenHighlighted = NO;
    button.imageView.contentMode = UIViewContentModeCenter;
    return button;
}

+ (KWSocialButton *)googlePlusButton
{
    KWSocialButton* button = [[KWSocialButton alloc] initWithFrame:CGRectMake(0., 0., 240., 30.)];
    button.gradientArray = @[[UIColor colorWithHexString:@"DD4B39"], [UIColor colorWithHexString:@"B93C2D"]];
    button.borderColor = [UIColor clearColor];
    UIImage* image = [UIImage imageNamed:@"google_plus"];
    [button setImage:image forState:UIControlStateNormal];
    button.splitLineColorLeft = [UIColor colorWithHexString:@"BB3F30"];
    button.splitLineColorRight = [UIColor colorWithHexString:@"C33F2F"];
    button.adjustsImageWhenHighlighted = NO;
    button.imageView.contentMode = UIViewContentModeCenter;
    return button;
}

#pragma mark - overrides

- (void) layoutSubviews
{
    [super layoutSubviews];
    if (_buttonMode == KWSocialButtonModeDefault) {
        CGRect imageFrame = self.imageView.frame;
        imageFrame.origin.x = self.bounds.size.height / 4.;
        self.imageView.frame = CGRectIntegral(imageFrame);
    } else {
        self.imageView.frame = self.bounds;
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    if (_buttonMode == KWSocialButtonModeDefault) {
        CGFloat alpha = self.enabled ? 1.0 : 0.5;
        if (_splitLineColorLeft) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGRect imageFrame = self.imageView.frame;
            CGFloat x = CGRectGetMaxX(imageFrame) + 2;
            CGPoint points[2] = {CGPointMake(x, 0), CGPointMake(x, rect.size.height)};
            
            CGContextSetStrokeColorWithColor(context, [self.splitLineColorLeft colorWithAlphaComponent:alpha].CGColor);
            CGContextStrokeLineSegments(context, points, 2);
        };
        if (_splitLineColorRight) {
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGRect imageFrame = self.imageView.frame;
            CGFloat x = CGRectGetMaxX(imageFrame) + 3;
            CGPoint points[2] = {CGPointMake(x, 0), CGPointMake(x, rect.size.height)};
            
            CGContextSetStrokeColorWithColor(context, [self.splitLineColorRight colorWithAlphaComponent:alpha].CGColor);
            CGContextStrokeLineSegments(context, points, 2);
        };
    }
}

- (void) setButtonMode:(KWSocialButtonMode)buttonMode
{
    _buttonMode = buttonMode;
    self.titleLabel.hidden = buttonMode == KWSocialButtonModeIconOnly;
    [self setNeedsLayout];
}

@end
