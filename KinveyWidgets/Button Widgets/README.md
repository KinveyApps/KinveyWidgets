Kinvey Widgets : Button Views
=====
## Buttons
### KWLinkButton
A UIButton subclass that instead of drawing as a physical button, is drawn like a label, where part (or all) of it is a hyperlink. 

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWLinkButton_sample.png)

To use, just set the `title` property to a `NSString` with the link part between "&lt;a&gt;" and "&lt;/a&gt;" tags. For example:

    KWLinkButton* button = [[KWLinkButton alloc] initWithFrame:CGRectMake(0., 0., 100., 30.)];
    buton.title = @"Don't Have an Account? <a>Sign Up</a>";
    [aView addSubview:button];

The button text should fit on one line in the UI. 

### KWSocialButton
A simple gradient button that shows a social provider icon the left, a two-toned split line and the label text on the right. An optional mode just shows the icon in order shrink the button down and still be indicative of what it is. 

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWSocialButton_sample.png)

To use, just use one of the factory methods, and set the `title` and `action` as you would on a regular `UIButton`.

    [KWSocialButton facebookButton];
    [KWSocialButton twitterButton];

To switch the button between the full text and icon mode to the just icon mode, set the `buttonMode` property. This might be good in a `didRotateFromInterfaceOrientation:` method to make the button fit better in a narrower UI.

E.g.,


	aSocialButton.buttonMode = KWSocialButtonModeIconOnly;

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWSocialButton_icon_sample.png)

## Contact
Website: [www.kinvey.com](http://www.kinvey.com)

Support: [support@kinvey.com](http://docs.kinvey.com/mailto:support@kinvey.com)