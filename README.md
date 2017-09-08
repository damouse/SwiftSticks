# SwiftSticks

Analog joysticks for iOS written in Swift. 

This repository contains a sample app in addition to Cocoapod. To try out SwiftSticks quickly, clone this repository, run `pod install`, and run the app target. 

## Setup

For Cocoapods, add the following to your Podfile:

```
pod 'SwiftSticks'
```

Install with `pod install`.

This repo also contains a quick demo application. Clone the repo, open the project, and run the *SwiftSticks-Example* target. See sample implementation in the main ViewController.

## Usage

There's one main class in this project, the `StickView`. Add it to your views in any of the usual ways-- add a `StickView` subclass in InterfaceBuilder, or create an instance programmatically: 

```
import SwiftSticks

...

// Abbreviated example
let sticks = StickView(frame: someFrame)
self.view.addSubview(sticks)
```

The actual rendering of the stick, which is a SpriteKitNode, will always size itself initially based on the size of the StickView. Note that resizing is not currently supported.

### API

#### Delegate handlers: 

```
@IBOutlet weak var stickView: StickView!

...

// Called as the user drags the stick around
stickView.didMove = { (a: AnalogJoystickData) -> () in
    print(a)
}

// Called when the user first touches the joystick and starts dragging it around
stickView.startedMoving = {
    print("Stick started moving")
}

// Called when the user stops touching the stick
stickView.stoppedMoving = {
    print("Stopped moving")
}
```

Position data is returned as `AnalogJoystickData` structs which have two fields: `position` and `angle.`. Position is recorded from *-1* to *+1* along the x and y axes. `angle` is measured in radians starting at the 12 o'clock position and increasing positive in the counter-clockwise direction and negative clockwise. I didn't set this part of the library up, and lord knows why its done like this, so if it bothers you enough please submit a PR.

#### Data

```
stickView.data // => returns currentAnalogJoystickData  

stickView.isMoving // => true if the user is currently dragging the joystick
```

#### Customization

```
// Turn sticks on or off
stickView.disabled = true 

// Set the color of the stick or the base
stickView.stickColor = UIColor.white()
stickView.baseColor = UIColor.black()

// Use images for the stick
stickView.stickImage = UIImage(named: "YourImage")
stickView.baseImage = UIImage(named: "YourOtherImage")
```


## Other

Started as a fork of [this project](https://github.com/MitrophD/Swift-SpriteKit-Analog-Stick) by MitrophD.

### TODO

- Create an IBAction delegate for the stick views
- Refactor the handlers appropriately
- Add constraints between the stickview and the SKView to resize appropriately