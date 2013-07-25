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