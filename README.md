[![SwiftIcons](https://github.com/ranesr/SwiftIcons/raw/master/resources/logo.png)]()

[![CocoaPods](https://img.shields.io/cocoapods/v/SwiftIcons.svg)](http://cocoadocs.org/docsets/SwiftIcons) [![CocoaPods](https://img.shields.io/cocoapods/dm/SwiftIcons.svg)](http://cocoapods.org/pods/SwiftIcons) [![CocoaPods](https://img.shields.io/cocoapods/dw/SwiftIcons.svg)](http://cocoapods.org/pods/SwiftIcons) [![Platform](https://img.shields.io/cocoapods/p/SwiftIcons.svg)](http://cocoadocs.org/docsets/SwiftIcons) ![Swift](https://img.shields.io/badge/%20in-swift%204.0-orange.svg)

[![Travis](https://img.shields.io/travis/ranesr/SwiftIcons.svg)](https://travis-ci.org/ranesr/SwiftIcons/)

## Swift Library for Font Icons

Please &#9733; this library.

Now, you don't have to download different libraries to include different font icons. This SwiftIcons library helps you use icons from any of the following font icons.

* Dripicons
* Emoji
* FontAwesome
* Icofont
* Ionicons
* Linearicons
* Map-icons
* Material icons
* Open iconic
* State face icons
* Weather icons

SwiftIcons supports different objects from the object library.

* UIImage
* UIImageView
* UILabel
* UIButton
* UISegmentedControl
* UITabBarItem
* UISlider
* UIBarButtonItem
* UIViewController
* UITextfield
* UIStepper


## Requirements

- iOS 8.0+
- Xcode 8


## Installation

### Cocoapods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects.

Make sure you have the latest version of CocoaPods by running:

```bash
$ gem install cocoapods
# (or if the above fails)
$ sudo gem install cocoapods
```

Update your local specs repo by running:

```bash
$ pod repo update
```

Add the following lines to your `Podfile`:

```ruby
target 'YourProject' do
    use_frameworks!
    pod 'SwiftIcons', '~> 2.1.0'
end
```

Then run the following command

```bash
$ pod install
```

You can start using the library by importing it wherever you want

```swift
import SwiftIcons
```

### Manually

Copy all the files from `Source` folder.
[Link to files](https://github.com/ranesr/SwiftIcons/tree/master/Source).

- SwiftIcons.swift
- Dripicons.ttf
- Emoji.ttf
- FontAwesome.ttf
- Icofont.ttf
- Ionicons.ttf
- Linearicons.ttf
- MapIcons.ttf
- MaterialIcons.ttf
- OpenIconic.ttf
- Stateface.ttf
- WeatherIcons.ttf

Check to import all ttf files in project, "Project" > "Target" > "Copy Bundle Resources"


## Library Reference

You can check library reference documentation [here](http://cocoadocs.org/docsets/SwiftIcons/).

## Usage

- No more image icons any more

There are different font types for each of the font icons

| Font Icons       | Version    | Font Types           | Icons                                               |
|:----------------:|:----------:|:--------------------:|:---------------------------------------------------:|
| Dripicons        | 2.0        | dripicons            | [dripicons](https://github.com/amitjakhu/dripicons) |
| Emoji            |            | emoji                | [emoji](http://jslegers.github.io/emoji-icon-font/) | 
| FontAwesome      | 5.1.0      | fontAwesome          | [fontAwesome](https://fontawesome.com/icons?d=gallery&m=free)         |
| Icofont          | 1.0.0 Beta | icofont              | [icofont](http://icofont.com)                       |
| Ionicons         | 2.0.1      | ionicons             | [ionicons](http://ionicons.com/)                    |
| Linearicons      | 1.0.0      | linearIcons          | [linearIcons](https://linearicons.com/free)         |
| Map-icons        | 3.0.2      | mapicons             | [mapicons](http://map-icons.com/)                   |
| Material icons   | 2.2.0      | googleMaterialDesign | [googleMaterialDesign](https://material.io/icons/)  |
| Open iconic      | 1.1.1      | openIconic           | [openIconic](https://useiconic.com/open)            |
| State face icons |            | state                | [state](http://propublica.github.io/stateface/)     |
| Weather icons    | 2.0.10     | weather              | [weather](http://weathericons.io/)                  |


When setting an icon to any object, you have to mention which font type it is and then select which icon you want to set from that particular font icon.


### UIImage

```Swift

UIImage.init(icon: .emoji(.airplane), size: CGSize(width: 35, height: 35))

// Icon with colors
UIImage.init(icon: .emoji(.airplane), size: CGSize(width: 35, height: 35), textColor: .red)
UIImage.init(icon: .emoji(.airplane), size: CGSize(width: 35, height: 35), textColor: .white, backgroundColor: .red)

// Stacked icons with bigger background
UIImage.init(bgIcon: .fontAwesome(.circleO), topIcon: .fontAwesome(.squareO))

// Stacked icons with smaller background
UIImage.init(bgIcon: .fontAwesome(.camera), topIcon: .fontAwesome(.ban), topTextColor: .red, bgLarge: false)

// Stacked icons with custom size
UIImage.init(bgIcon: .fontAwesome(.camera), topIcon: .fontAwesome(.ban), topTextColor: .red, bgLarge: false, size: CGSize(width: 50, height: 50))

```


### UIImageView

```Swift

// Setting icon to image view
imageView.setIcon(icon: .weather(.rainMix))

// Icon with colors
imageView.setIcon(icon: .mapicons(.amusementPark), textColor: .white, backgroundColor: .blue, size: nil)

```


### UILabel

```Swift

// Setting icon to label
label.setIcon(icon: .ionicons(.paintbrush), iconSize: 70)

// Icon with colors
label.setIcon(icon: .googleMaterialDesign(.rowing), iconSize: 70, color: .white, bgColor: textColor)

// Icon with text around it
label.setIcon(prefixText: "Bus ", icon: .linearIcons(.bus), postfixText: " icon", size: 20)

// Icon with color & colored text around it
label.setIcon(prefixText: "Medal ", prefixTextColor: .red, icon: .ionicons(.ribbonA), iconColor: .red, postfixText: "", postfixTextColor: .red, size: nil, iconSize: 40)

// Icon with text with different fonts around it
label.setIcon(prefixText: "Font ", prefixTextFont: font1!, icon: .fontAwesome(.font), postfixText: " icon", postfixTextFont: font2!)

// Icon with text with different fonts & colors around it
label.setIcon(prefixText: "Bike ", prefixTextFont: font1!, prefixTextColor: .red, icon: .mapicons(.bicycling), iconColor: textColor, postfixText: " icon", postfixTextFont: font2!, postfixTextColor: .blue, iconSize: 30)

```


### UIButton

```Swift

// Setting icon to button
button.setIcon(icon: .linearIcons(.phone), forState: .normal)

// Icon with size and color
button.setIcon(icon: .openIconic(.clipboard), iconSize: 70, color: .blue, forState: .normal)

// Icon with text around it
button.setIcon(prefixText: "Please ", icon: .googleMaterialDesign(.print), postfixText: " print", forState: .normal)

// Icon with color & colored text around it
button.setIcon(prefixText: "Lock ", prefixTextColor: .red, icon: .googleMaterialDesign(.lock), iconColor: .yellow, postfixText: " icon", postfixTextColor: .blue, forState: .normal, textSize: 15, iconSize: 20)

// Icon with text with different fonts around it
button.setIcon(prefixText: "Happy ", prefixTextFont: font1!, icon: .ionicons(.happy), postfixText: " face", postfixTextFont: font2!, forState: .normal)

// Icon with text with different fonts & colors around it
button.setIcon(prefixText: "Pulse ", prefixTextFont: font1!, prefixTextColor: .darkGray, icon: .openIconic(.pulse), iconColor: .red, postfixText: " icon", postfixTextFont: font2!, postfixTextColor: .purple, forState: .normal, iconSize: 40)

// Icon with title below icon
button.setIcon(icon: .emoji(.ferrisWheel), title: "Ferris Wheel", color: .red, forState: .normal)

// Icon with title below icon with different color & custom font
button.setIcon(icon: .weather(.rainMix), iconColor: .yellow, title: "RAIN MIX", titleColor: .red, font: font!, backgroundColor: .clear, borderSize: 1, borderColor: .green, forState: .normal)

```


### UISegmentedControl

```Swift

// Setting icon at particular index
segmentedControl.setIcon(icon: .linearIcons(.thumbsUp), forSegmentAtIndex: 0)
segmentedControl.setIcon(icon: .linearIcons(.thumbsDown), forSegmentAtIndex: 1)

// Icons with sizes & colors
segmentedControl.setIcon(icon: .fontAwesome(.male), color: .red, iconSize: 50, forSegmentAtIndex: 0)
segmentedControl.setIcon(icon: .fontAwesome(.female), color: .purple, iconSize: 50, forSegmentAtIndex: 1)

```


### UITabBarItem

```Swift

// Setting icon to tab bar item
tabBar.items?[0].setIcon(icon: .fontAwesome(.font), size: nil, textColor: .lightGray)

// Stacked icons for tab bar item
tabBar.items?[1].setIcon(bgIcon: .fontAwesome(.circleThin), bgTextColor: .lightGray, topIcon: .fontAwesome(.squareO), topTextColor: .lightGray, bgLarge: true, size: nil)

```


### UISlider

```Swift

// Change minimum & maximum value icons
slider.setMaximumValueIcon(icon: .emoji(.digitNine))
slider.setMinimumValueIcon(icon: .emoji(.digitZero))

// Change minimum & maximum value icons with colors
slider.setMaximumValueIcon(icon: .linearIcons(.pointerUp), customSize: nil, textColor: .red, backgroundColor: .clear)
slider.setMinimumValueIcon(icon: .linearIcons(.pointerDown), customSize: nil, textColor: .blue, backgroundColor: .clear)

```


### UIBarButtonItem

```Swift

// Setting icon to bar button item
barButtonItem.setIcon(icon: .ionicons(.iosFootball), iconSize: 30)

// Icon with colors
barButtonItem.setIcon(icon: .ionicons(.iosFootball), iconSize: 30, color: textColor)

// Icon with custom cgRect
barButtonItem.setIcon(icon: .ionicons(.iosFootball), iconSize: 30, color: textColor, cgRect: CGRect(x: 0, y: 0, width: 30, height: 30), target: self, action: #selector(barButtonItem(sender:)))

// Icon with text around it
barButtonItem.setIcon(prefixText: "Please ", icon: .ionicons(.iosDownload), postfixText: " download", cgRect: CGRect(x: 0, y: 0, width: 30, height: 30), size: 23, target: self, action: #selector(barButtonItem(sender:)))

// Icon with color & colored text around it
barButtonItem.setIcon(prefixText: "Blue ", prefixTextColor: .red, icon: .ionicons(.iosFootball), iconColor: .blue, postfixText: " football", postfixTextColor: .green, cgRect: CGRect(x: 0, y: 0, width: 30, height: 30), size: 20, iconSize: 30, target: self, action: #selector(barButtonItem(sender:)))

// Icon with text with different fonts around it
barButtonItem.setIcon(prefixText: "Digit ", prefixTextFont: font1!, icon: .emoji(.digitOne), postfixText: " One", postfixTextFont: font2!, cgRect: CGRect(x: 0, y: 0, width: 30, height: 30), target: self, action: #selector(barButtonItem(sender:)))

// Icon with text with different fonts & colors around it
barButtonItem.setIcon(prefixText: "", prefixTextFont: font1!, prefixTextColor: .red, icon: .ionicons(.iosFootball), iconColor: .blue, postfixText: " football", postfixTextFont: font2!, postfixTextColor: .green, cgRect: CGRect(x: 0, y: 0, width: 30, height: 30), iconSize: 24, target: self, action: #selector(barButtonItem(sender:)))

```


### UIViewController

```Swift

// Setting icon to the title
self.setTitleIcon(icon: .emoji(.animalHorse), iconSize: 30, color: .red)

```


### UITextfield

```Swift

// Setting left view icon
textfield.setLeftViewIcon(icon: .fontAwesome(.search))

// Left view icon with colors & leftViewMode
textfield.setLeftViewIcon(icon: .state(.TX), leftViewMode: .always, textColor: .blue, backgroundColor: .clear, size: nil)
textfield.setLeftViewIcon(icon: .googleMaterialDesign(.plusOne), leftViewMode: .unlessEditing, textColor: .green, backgroundColor: .clear, size: nil)

// Setting right view icon
textfield.setRightViewIcon(icon: .openIconic(.questionMark))

// Right view icon with colors & rightViewMode
textfield.setRightViewIcon(icon: .weather(.rainMix), rightViewMode: .always, textColor: .red, backgroundColor: .clear, size: nil)

```


### UIStepper

```Swift

// Setting icons
stepper.setDecrementIcon(icon: .ionicons(.iosPause), forState: .normal)
stepper.setIncrementIcon(icon: .ionicons(.iosPlay), forState: .normal)

```


## Examples

Please check out the [SwiftIcons App](https://github.com/ranesr/SwiftIcons/tree/master/SwiftIcons). In the demo project, if you click on any object, you will see the method description in the logs for the icon of that object.


## Apps using SwiftIcons

If you are using SwiftIcons in your app and want to be listed here, simply create a new issue [here](https://github.com/ranesr/SwiftIcons/issues/new).
 
I am always curious who is using my projects &#x1f60a;


## Author

Saurabh Rane

- [Email](mailto:saurabhrrane@gmail.com)
- [LinkedIn](https://linkedin.com/in/ranesaurabh)

Special thanks to [Patrik Vaberer](https://github.com/Vaberer) and his initial work on [Font-Awesome-Swift](https://github.com/Vaberer/Font-Awesome-Swift) library


## Licence

SwiftIcons is available under the MIT License. See the `LICENSE` file for more info.
