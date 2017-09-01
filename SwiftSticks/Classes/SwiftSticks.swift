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

public class StickView: SKView {
    var _scene: SKScene!
    
    // Instead of exposing accessors, just interact with the stick directly
    public var stick: AnalogJoystick!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setupView()
    }
    
    func setupView() {
        _scene = SKScene(size: self.bounds.size)
        _scene.backgroundColor = .white
        _scene.view?.isMultipleTouchEnabled = true
        _scene.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        stick = AnalogJoystick(diameter: 110)
        stick.position = CGPoint(x: stick.radius + 15, y: stick.radius + 15)
        stick.substrate.color = UIColor.random()
        
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
