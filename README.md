# SwiftSticks

Analog joysticks for iOS written in Swift. 

This repository contains a sample app in addition to Cocoapod. To try out SwiftSticks quickly, clone this repository, run `pod install`, and run the app target. 

Note: this project will undergo a lot of change in the near future.

## Setup

For Cocoapods, add the following to your Podfile:

```
pod 'SwiftSticks'
```

Install with `pod install`.

## Usage

There's one main class in this project, the `StickView`. Add it to your views in any of the usual ways-- add a `StickView` subclass in InterfaceBuilder, or create an instance programmatically: 

```
import SwiftSticks

...

// Abbreviated example
let sticks = StickView(frame: someFrame)
self.view.addSubview(sticks)
```

StickView documentation to follow.

## Other

Started as a fork of [this project](https://github.com/MitrophD/Swift-SpriteKit-Analog-Stick) by MitrophD.