Kinvey Widgets : Text Views
=====
## TextFields
### KWIconTextField
A very simple `UITextField` subclass that lets you set a small image on the left side of the text view. 

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWIconTextField_sample.png)

To use, just set the `iconImage` property. For example:

    KWIconTextField* textField = [[KWIconTextField alloc] initWithFrame:CGRectMake(0., 0., 100., 30.)];
    textField.iconImage = [UIImage imageNamed:@"icon"];
    textField.placeholder = @"Enter Text";
    [aView addSubview:textField];

## Contact
Website: [www.kinvey.com](http://www.kinvey.com)

Support: [support@kinvey.com](http://docs.kinvey.com/mailto:support@kinvey.com)