//
//  KWLinkButton.m
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

#import "KWLinkButton.h"
#import "NSString+MKHelpers.h"

@interface KWLinkButton () {
    UILabel* _linkLabel;
    UILabel* _preTextLabel;
    UILabel* _postTextLabel;
}

@end

@implementation KWLinkButton

- (void) setup
{
    _linkLabel = nil, _preTextLabel = nil, _postTextLabel = nil;
    _titleFont = [UIFont systemFontOfSize:14.];
    self.showsTouchWhenHighlighted = YES;
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

#pragma mark - Title
#define kOpenTag @"<a>"
#define kCloseTag @"</a>"
- (void) setTitle:(NSString*)title
{
    //This splits the string and draws the before, after and link text in its own label.
    //Not using a NSAttributedString to keep compatability with earlier versions. This makes sense to be one line only.
    NSRange aRange = [title rangeOfString:kOpenTag];
    if (aRange.location != NSNotFound) {
        self.titleLabel.hidden = YES;
        NSRange closeRange = [title rangeOfString:kCloseTag];
        NSString* linkString = [title substringBetweenRange1:aRange andRange2:closeRange];
        _linkLabel = [[UILabel alloc] init];
        _linkLabel.backgroundColor = [UIColor clearColor];
        _linkLabel.textColor = [UIColor blueColor];
        _linkLabel.text = linkString;
        [_linkLabel sizeToFit];
        [self addSubview:_linkLabel];
        
        if (aRange.location > 0) {
            NSString* preString = [title substringToIndex:aRange.location];
            _preTextLabel = [[UILabel alloc] init];
            _preTextLabel.backgroundColor = [UIColor clearColor];
            _preTextLabel.text = preString;
            [_preTextLabel sizeToFit];
            [self addSubview:_preTextLabel];
        }
        
        if (closeRange.location + closeRange.length < title.length - 1) {
            NSString* postString = [title substringFromIndex:closeRange.location + closeRange.length];
            _postTextLabel = [[UILabel alloc] init];
            _postTextLabel.backgroundColor = [UIColor clearColor];
            _postTextLabel.text = postString;
            [_postTextLabel sizeToFit];
            [self addSubview:_postTextLabel];
        }
    } else {
        // no links
        [self setTitle:title forState:UIControlStateNormal];
    }
    
    [self setTitleFont:_titleFont];
}

- (void) setTitleFont:(UIFont *)titleFont
{
    _preTextLabel.font = titleFont;
    _postTextLabel.font = titleFont;
    _linkLabel.font = titleFont;
    _titleFont = titleFont;
    [self setNeedsLayout];
}

#pragma mark - Layout
- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = self.bounds;
    CGSize boundSize = bounds.size;
    CGSize linkSize = [_linkLabel sizeThatFits:boundSize];
    CGSize preSize = [_preTextLabel sizeThatFits:boundSize];
    CGSize postSize = [_postTextLabel sizeThatFits:boundSize];
    CGFloat totalWidth = linkSize.width + preSize.width + postSize.width;
    CGFloat x = boundSize.width / 2. - totalWidth / 2.;
    CGFloat y = boundSize.height / 2. - linkSize.height / 2.;
    
    CGRect frame = CGRectMake(x, y, preSize.width, preSize.height);
    [_preTextLabel setFrame:frame];
    
    frame = CGRectMake(frame.origin.x + frame.size.width, y, linkSize.width, linkSize.height);
    [_linkLabel setFrame:frame];

    frame = CGRectMake(frame.origin.x + frame.size.width, y, postSize.width, postSize.height);
    [_postTextLabel setFrame:frame];    
}
@end
