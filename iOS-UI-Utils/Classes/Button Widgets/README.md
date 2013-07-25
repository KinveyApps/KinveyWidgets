# Button Widgets

## MKGradientButton 
`MKGradientButton` is a `UIButton` subclass that provides a simple linear gradient in a rounded rect. The gradient can either be set as an array of `UIColor`s or by specifying a central color. The button also supports an optional spinner.

![](https://raw.github.com/mikekatz/iOS-UI-Utils/master/doc/mkgradientbuttons.png)

### Usage
Start by importing `MKGradientButton.h` and `MKGradientButton.m` into your project. In addition you'll need to two utility categories from this project: [NSArray+MKHelpers](https://github.com/mikekatz/iOS-UI-Utils/tree/master/Classes/Foundation%20Categories) and  [UIColor+MKHelpers](https://github.com/mikekatz/iOS-UI-Utils/tree/master/Classes/Foundation%20Categories). 

#### With Interface Builder
1. Drag an `UIButton` from Interface builder onto your view. ![](https://raw.github.com/mikekatz/iOS-UI-Utils/master/doc/mkgradientbutton_draguibutton.png)
2. In the **Identity Inspector**, find the **Custom Class** section and type in "`MKGradientButton`". ![](https://raw.github.com/mikekatz/iOS-UI-Utils/master/doc/mkgradientbutton_custom_class.png) 
3. Wire up the button to actions and outlets, as normal. To set up the …

#### Using Code
1. Create a `MKGradientButton` the same way as you would a `UIButton`.
2. Set up any button properties, such as title, frame, and action. 
3. Set the gradient color, either a single center color using `setButtonColor:` or by supplying an array of colors from top to bottom using `setGradientArray:`. 
4. Optionally, set the border color using `setBorderColor:`. 

For example:

    MKGradientButton* button = [[MKGradientButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    button.buttonColor = [UIColor redColor]; //creates a slight gradient centered on red
    //button.gradientArray = @[[UIColor yellowColor], [UIColor blueColor]]; //set the gradient directly
    //(use either buttonColor or gradientArray -- but not both!)
    
    //these can be set through Interface Builder, or with code
    [button setTitle:@"Do It!" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(doSomething:) forControlEvents:UIControlEventTouchUpInside];


#### Showing the spinner
If the button is used to start an asynchronous task that shouldn't be duplicated or interrupted, you can show an activity indicator inside the button (leaving the rest of the UI enabled) using `startSpinner`.

For example:

    //before asynchronous action started:
    button.enabled = NO;
    [button startSpinner];
    
    //when action is finished:
    button.enabled = YES;
    [button stopSpinner];


## System Requirements
`MKGradientButton` should work on iOS 4.0 and later. 

## Contact
If you have issues, suggestions, or other feedback, use the issue tracker or reach me at: michael@kinvey.com. 