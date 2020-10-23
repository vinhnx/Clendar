# EasyClosure

[![Version](https://img.shields.io/cocoapods/v/EasyClosure.svg?style=flat)](http://cocoadocs.org/docsets/EasyClosure)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/EasyClosure.svg?style=flat)](http://cocoadocs.org/docsets/EasyClosure)
[![Platform](https://img.shields.io/cocoapods/p/EasyClosure.svg?style=flat)](http://cocoadocs.org/docsets/EasyClosure)
![Swift](https://img.shields.io/badge/%20in-swift%205.0-orange.svg)

![](Screenshots/Artboard.png)

## Table of contents

- [Story](#story)
- [Target-Action and Delegate](#target-action-and-delegate)
- [Extensible](#extensible)

## Story

There are many [Communication patterns](https://www.objc.io/issues/7-foundation/communication-patterns/)

<div align = "center">
<img src="https://www.objc.io/images/issue-7/notification-flow-chart-dae4ce12.png" width="500" height="400" />
</div>

Sometimes, you just want a unified and quick way to do it. Just call `on` on any `NSObject` subclasses and handle your events the quickest way

### Features

- [x] Shortcut to handle actions and events
- [x] Easy to extend
- [x] Correct method suggestion based on generic protocol constraint
- [x] Support iOS, macOS

### Example

<div align = "center">
<img src="Screenshots/demo.gif" height="300" />
</div>

We can make a fun demo of `good, cheap, fast` with `UISwitch`

```swift
func allOn() -> Bool {
  return [good, cheap, fast].filter({ $0.isOn }).count == 3
}

good.on.valueChange { _ in
  if allOn() {
    fast.setOn(false, animated: true)
  }
}

cheap.on.valueChange { _ in
  if allOn() {
    good.setOn(false, animated: true)
  }
}

fast.on.valueChange { _ in
  if allOn() {
    cheap.setOn(false, animated: true)
  }
}
```

## Target-Action and Delegate

#### UIButton

```swift
button.on.tap {
  print("button has been tapped")
}
```

#### UISlider

```swift
slider.on.valueChange { value in
  print("slider has changed value")
}
```

#### UITextField

```swift
textField.on.textChange { text in
  print("textField text has changed")
}
```

#### UITextView

```swift
textView.on.textChange { text in
  print("textView text has changed")
}
```

#### UISearchBar

```swift
searchBar.on.textChange { text in
  print("searchBar text has changed")
}
```

#### UIDatePicker

```swift
datePicker.on.pick { date in
  print("datePicker has changed date")
}
```

#### UIBarButtonItem

```swift
barButtonItem.on.tap {
  print("barButtonItem has been tapped")
}
```

#### UIGestureRecognizer

```swift
gestureRecognizer.on.occur {
  print("gesture just occured")
}
```

## Extensible

Extend `Container` and specify `Host` to add more functionalities to your own types. For example

```swift
public extension Container where Host: UITableView {
  func cellTap(_ action: @escaping (UITableViewCell) -> Void)) {
    // Your code here here
  }
}

// usage
let tableView = UITableView()
tableView.on.cellTap { cell in
  
}

```

## Installation

**EasyClosure** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'EasyClosure'
```

**EasyClosure** is also available through [Carthage](https://github.com/Carthage/Carthage).
To install just write into your Cartfile:

```ruby
github "onmyway133/EasyClosure"
```

**EasyClosure** can also be installed manually. Just download and drop `Sources` folders in your project.

## Author

Khoa Pham, onmyway133@gmail.com

## Contributing

We would love you to contribute to **EasyClosure**, check the [CONTRIBUTING](https://github.com/onmyway133/EasyClosure/blob/master/CONTRIBUTING.md) file for more info.

## License

**EasyClosure** is available under the MIT license. See the [LICENSE](https://github.com/onmyway133/EasyClosure/blob/master/LICENSE.md) file for more info.
