Kinvey Widgets
=====
This repository contains handy reusable widgets for Kinvey's sample iOS projects. 

## Organization
This project is broken out into subfolders containing similiar views. These will be generic widgets that can be used by any kind of iOS project. Any code that specifically uses KinveyKit for talking to [Kinvey's Backend-as-a-Service](http://www.kinvey.com), will be in a `KinveyKit` subfolder. 

Each subfolder has an additional `README` file with instructions on how to use each widget.

## Included Widgets
### Views 
`/KinveyWidgets/Views`

* __KWGradientView__ A simple view with a gradient background along its diagonal axis.

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWGradientView_screenshot.png)

* __KWLineView__ A view that draws a line along one of its sides. 

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWLineView_screenshot.png)

### Text Views
`/KinveyWidgets/Text Widgets`

* __KWIconTextField__ A very simple `UITextField` subclass that lets you set a small image on the left side of the text view. 

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWIconTextField_sample.png)

### Button Views
`/KinveyWidgets/Button Widgets`

* __KWLinkButton__ A UIButton subclass that instead of drawing as a physical button, is drawn like a label, where part (or all) of it is a hyperlink. 

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWLinkButton_sample.png)

* __KWSocialButton__ A simple gradient button that shows a social provider icon the left, a two-toned split line and the label text on the right. An optional mode just shows the icon in order shrink the button down and still be indicative of what it is. 

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWSocialButton_sample.png)

### Complex Controllers
#### Sign-In Controller Stack
`/KinveyWidgets/Sign-in`

These example sign-ins view that supports sign-in with a username and password, sign-in with Facebook, and Twitter credentials, as well as account creation, password reset, and email verification.  

This has been built to be generic for any sign-in service, but comes with an implementation for Kinvey, as well.

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWSignInViewController_screenshot.png)

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWSignInViewController_landscape_screenshot.png)

![=640px](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWSignInViewController_ipad_screenshot.png)

## Contact
Website: [www.kinvey.com](http://www.kinvey.com)

Support: [support@kinvey.com](http://docs.kinvey.com/mailto:support@kinvey.com)