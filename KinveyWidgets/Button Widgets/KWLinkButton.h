//
//  KWLinkButton.h
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

#import <UIKit/UIKit.h>

/** A UIButton subclass that instead of drawing as a physical button, is drawn like a label, where part (or all) of it is a hyperlink. This way a web view is not needed for a simple link action */
@interface KWLinkButton : UIButton
/** Set the title. The portion to be a link should be enclosed in <a></a> tags. Don't bother specifying a target or other link options, just add an action to hanlde the tap. Only one portion can have a link. The title should fit on one line in the button bounds. */
- (void) setTitle:(NSString *)title;
/** Obviously, the label font */
@property (nonatomic, retain) UIFont* titleFont;
@end
