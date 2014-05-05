//
//  MKGradientButton.m
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

#import "MKGradientButton.h"
#import "UIColor+MKHelpers.h"
#import "NSArray+MKHelpers.h"

@implementation MKGradientButton

- (void) setup
{
    _borderColor = [UIColor blackColor];
    
    self.buttonColor = [UIColor orangeColor];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self setTitleShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
    [self setReversesTitleShadowWhenHighlighted:YES];
    self.titleLabel.shadowOffset = CGSizeMake(0., 1.);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
    
    [self setTitleColor:[UIColor lightTextColor] forState:UIControlStateDisabled];
    [self setTitleShadowColor:[[UIColor blackColor] colorWithAlphaComponent:0.2] forState:UIControlStateDisabled];
}

- (id) init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
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
    // The rounded rect
    UIBezierPath* roundRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height/4];

    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    [[UIColor whiteColor] setFill];
    [roundRect fill];
    
    
	CGContextAddPath(ctx, roundRect.CGPath);
	CGContextClip(ctx);
	
    
    UIColor* strokeColor = _borderColor;
    NSArray* colors = nil;
    CGFloat alpha = 1.0;
    if (self.enabled == NO) { //disabled
        alpha = 0.5;
        colors = _gradientArray;
        strokeColor = [[UIColor blackColor] colorWithAlphaComponent:alpha];
    } else if (self.highlighted == YES) { //highlighted
        colors = [_gradientArray reverseArray];
    } else { // normal, enabled
        colors = _gradientArray;
    }

    //draw the gradient
    NSUInteger nColors = _gradientArray.count;
    if (nColors) {
        NSMutableArray* cfColors = [NSMutableArray arrayWithCapacity:nColors];
        for (UIColor * c in colors) {
            [cfColors addObject:(id)[c colorWithAlphaComponent:alpha].CGColor];
        }
        
        CGFloat locations[nColors];
        for (int i = 0; i < nColors; i++) {
            locations[i] = 1.0 / (CGFloat) nColors * (CGFloat) i;
        }
        
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef fillGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) cfColors, locations);
        CGContextDrawLinearGradient(ctx, fillGradient, CGPointMake(0, CGRectGetMinY(rect)), CGPointMake(0, CGRectGetMaxY(rect)), 0);
        CGColorSpaceRelease(colorSpace);
        CGGradientRelease(fillGradient);
    }

    [strokeColor setStroke];
    roundRect.lineWidth = 2.;
    [roundRect stroke];
    
    CGContextRestoreGState(ctx);
}

// some methods should cause the button to redraw
- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    [self setNeedsDisplay];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    [self setNeedsDisplay];
}

#pragma mark - Colors
- (void) setButtonColor:(UIColor *)buttonColor
{
    _buttonColor = buttonColor;
    if  (buttonColor != nil) {
        //create a linear gradient, centered on the buttonColor
        self.gradientArray = @[[buttonColor lighterColor], buttonColor, [buttonColor darkerColor]];
    }
}

#pragma mark - Activity
- (void) startSpinner
{
    UIActivityIndicatorView* spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    spinner.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    CGRect spinnerFrame = spinner.frame;
    if (self.frame.size.width < spinnerFrame.size.width + self.bounds.size.height / 2. ) {
        spinnerFrame = self.bounds;
    } else {
        spinnerFrame.origin = CGPointMake(self.bounds.size.width - spinnerFrame.size.width - self.bounds.size.height / 4, (self.bounds.size.height - spinnerFrame.size.height) / 2.);
    }
    spinner.frame = spinnerFrame;
    [self addSubview:spinner];
    [spinner startAnimating];
}

- (void) stopSpinner
{
    for (UIView* v in self.subviews) {
        if ([v isKindOfClass:[UIActivityIndicatorView class]]) {
            [(UIActivityIndicatorView*)v stopAnimating];
            [v removeFromSuperview];
        }
    }
}

@end
