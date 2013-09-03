Kinvey Widgets : Sign-In Screens
=====
This is example sign-in view that supports sign-in with a username and password, sign-in with Facebook, and Twitter credentials, as well as account creation, password reset, and email verification.  

This has been built to be generic for any sign-in service, but comes with an implementation for [Kinvey's Backend-as-a-Service](http://www.kinvey.com).

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWSignInViewController_screenshot.png)

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWSignInViewController_landscape_screenshot.png)

![=640px](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWSignInViewController_ipad_screenshot.png)


## How to Use
Create an instance of `KWSignInViewController` (a UIViewController subclass) and add it to a UINavigationController stack. 

        KWSignInViewController* signInViewController = [[KWSignInViewController alloc] init];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:signInViewController];
        nav.navigationBar.barStyle = UIBarStyleBlack;
        self.window.rootViewController = nav;

`KWSignInViewController` requires a navigation stack to push and display the subordinate view controllers (create account, password reset, etc). However, this class provides a `- showModally` method to create an internal UINavigationController and present the whole stack modally in the window. 

The second step is to create an implementation of the `KWSignInViewControllerDelegate` protocol, and set it as the delegate. This delegate protocol tells the application what to do when the various buttons (such as sign-in and reset password) are tapped. 

This project comes with a pre-built `KCSSignInDelegate` (under the KinveyKit folder). This class makes all the appropriate callbacks into KinveyKit's user API. This just requires one additional delegate to handle the successfully logged in event. 
### Subordinate View Controllers
This class will automatically display several (optional) view controllers depending on the user's actions:

* Create a New Account

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWCreateAccountViewController_screenshot.png)

* Reset Password

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWResetPasswordViewController_screenshot.png)


* Email Verification

![](https://raw.github.com/KinveyApps/KinveyWidgets/master/doc/assets/KWResendEmailVerificationController_snapshot.png)

## Customize the UI
### Colors / Title
You can configure the branding of the views by changing the background gradient, button and line colors, as well as the title logo.

The following `KWSignInViewController` properties are available to customize the view. By default this will show Kinvey's branding (see screenshots).
* `backgroundGradientColors` - an array of `UIColor` objects for the linear gradient
* `buttonColor` the color of the various buttons
* `lineColor` the color of the dividing line

* `titleType` Choose either a text or image title
    * `logo` the title image
    * `title` alternative title text

### Optional Buttons
You can hide the create account and forgot password buttons if your application does not support them, using the following properties:
* `showsResetPasswordButton`
* `showsCreateAccountButton`

If your application only supports either Twitter or Facebook, or neither, you can remove these buttons with the `socialLogins` array property.

For example,

* To use only Twitter for sign-in: 

    signInViewController.socialLogins = @[KWSignInTwitter];

* To use only Facebook for sign-in: 

    signInViewController.socialLogins = @[KWSignInFacebook];
    
* To use only neither: 

    signInViewController.socialLogins = @[];

### Email Verification
Since email verification is not triggered by a direct user action, there is no button to show the resend email verification screen. Instead this is done programmatically through the `- showEmailVerificationScreen:` method. 

If you use this project with Kinvey, the `KCSSignInDelegate` provides two switches to configure email verification:
* `shouldSendEmailVerificationAfterSignup` sends the email verification automatically when a new account is created
* `emailVerificationRequired` will not let the user proceed past the sign-in screen until they have clicked the link in the verification email. Upon login they are automatically shown the resend email verification screen.

### Additional Account Information
The create account screen (`KWCreateAccountViewController`) right now collections the user's first and last names, an email address, and password. If your application requires additional information for the user, you can follow the pattern in code for adding new groups and rows to the UI, and passing them on to the delegate. If you require additional help, feel free to contact our support. 

## Sample Project
All good code comes with an example project, and so this one does as well. See KWSignin/KWSignIn.xcodeproj for an example project using a `KCSSignInDelegate`.

## System Requirements
* iPhone, iPod Touch, iPad
* iOS 5+
* KinveyKit 1.20.1 (for use with Kinvey's services)
* Facebook SDK 3.7.1 (only for sign-in with Facebook)

## Contact
Website: [www.kinvey.com](http://www.kinvey.com)

Support: [support@kinvey.com](http://docs.kinvey.com/mailto:support@kinvey.com)

## License

Copyright (c) 2013 Kinvey, Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.