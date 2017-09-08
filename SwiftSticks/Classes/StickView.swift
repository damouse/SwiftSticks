//
//  StickView.swift
//  Pods
//
//  Created by Mickey Barboi on 9/1/17.
//
//

import Foundation
import UIKit
import SpriteKit

// The percentage of diameter that is used as a buffer space between the stick and the edge of the view
// This is where the analog stick offsets to
let ANALOG_BUFFER = 0.3

// Current usage: view.stick.
public class StickView: SKView {
    var _scene: SKScene!
    
    // Instead of exposing accessors, just interact with the stick directly
    private var stick: AnalogJoystick!
    
    // Handlers
    public var didMove: ((AnalogJoystickData) -> ())? {
        didSet {
            stick.trackingHandler = didMove
        }
    }
    
    public var startedMoving: (() -> ())? {
        didSet {
            stick.beginHandler = startedMoving
        }
    }
    
    public var stoppedMoving: (() -> ())?{
        didSet {
            stick.stopHandler = stoppedMoving
        }
    }
    
    public var isMoving: Bool {
        return stick.tracking
    }
    
    public var data: AnalogJoystickData {
        return stick.data
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setupView()
    }
    
    func setupView() {
        self.clipsToBounds = false
        
        _scene = SKScene(size: self.bounds.size)
        _scene.backgroundColor = .white
        _scene.view?.isMultipleTouchEnabled = true
        _scene.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        // Sizing-- make sure the bounds match on all sides, with overflow
        let dist = min(self.bounds.width, self.bounds.height)
        let diameter = dist / CGFloat(1 + 2 * ANALOG_BUFFER)
        
        stick = AnalogJoystick(diameter: diameter)
        stick.substrate.color = UIColor.random()
        stick.position = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        
        stick.stick.image = UIImage(named: "jStick")
        stick.substrate.image = UIImage(named: "jSubstrate")
        
        _scene.addChild(stick)
        ignoresSiblingOrder = true
        presentScene(_scene)
    }
    
    // MARK: Analog Customization
    open func setBaseColor(color: UIColor) {
        stick.substrate.color = color
    }
    
    open func setStickColor(color: UIColor) {
        stick.stick.color = color
    }
}


extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}
