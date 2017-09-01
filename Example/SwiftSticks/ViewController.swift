//
//  ViewController.swift
//  SwiftSticks
//
//  Created by Mickey Barboi on 09/01/2017.
//  Copyright (c) 2017 Mickey Barboi. All rights reserved.
//

import UIKit
import SwiftSticks
import SpriteKit

/*
 Ok, what do we want here?
 
 - UIView subclass that can be dropped onto the storyboard or instantiated programmatically-- no spritekit
 - Simple external programmable interface
 */
class ViewController: UIViewController {
    @IBOutlet weak var stickView: SKView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: stickView.bounds.size)
        scene.backgroundColor = .white
        
        stickView.showsFPS = true
        stickView.showsNodeCount = true
        stickView.ignoresSiblingOrder = true
        stickView.presentScene(scene)
        
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask  {
        return UIDevice.current.userInterfaceIdiom == .phone ? .allButUpsideDown : .all
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

class GameScene: SKScene {
    var appleNode: SKSpriteNode?
    
    let moveAnalogStick = AnalogJoystick(diameter: 110)
    let rotateAnalogStick = AnalogJoystick(diameter: 100)
    
    
    var joystickStickImageEnabled = true {
        didSet {
            let image = joystickStickImageEnabled ? UIImage(named: "jStick") : nil
            moveAnalogStick.stick.image = image
            rotateAnalogStick.stick.image = image
        }
    }
    
    var joystickSubstrateImageEnabled = true {
        didSet {
            let image = joystickSubstrateImageEnabled ? UIImage(named: "jSubstrate") : nil
            moveAnalogStick.substrate.image = image
            rotateAnalogStick.substrate.image = image
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor.white
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        moveAnalogStick.position = CGPoint(x: moveAnalogStick.radius + 15, y: moveAnalogStick.radius + 15)
        addChild(moveAnalogStick)
        
        rotateAnalogStick.position = CGPoint(x: self.frame.maxX - rotateAnalogStick.radius - 15, y:rotateAnalogStick.radius + 15)
        addChild(rotateAnalogStick)
        
        
        // These can move to the view controller as demos
        //MARK: Handlers begin
        moveAnalogStick.beginHandler = { [unowned self] in
            guard let aN = self.appleNode else { return }
            aN.run(SKAction.sequence([SKAction.scale(to: 0.5, duration: 0.5), SKAction.scale(to: 1, duration: 0.5)]))
        }
        
        moveAnalogStick.trackingHandler = { [unowned self] data in
            guard let aN = self.appleNode else { return }
            aN.position = CGPoint(x: aN.position.x + (data.velocity.x * 0.12), y: aN.position.y + (data.velocity.y * 0.12))
        }
        
        moveAnalogStick.stopHandler = { [unowned self] in
            guard let aN = self.appleNode else { return }
            aN.run(SKAction.sequence([SKAction.scale(to: 1.5, duration: 0.5), SKAction.scale(to: 1, duration: 0.5)]))
        }
        
        rotateAnalogStick.trackingHandler = { [unowned self] jData in
            self.appleNode?.zRotation = jData.angular
        }
        
        rotateAnalogStick.stopHandler =  { [unowned self] in
            guard let aN = self.appleNode else { return }
            aN.run(SKAction.rotate(byAngle: 3.6, duration: 0.5))
        }
        // MARK: Handlers end

        joystickStickImageEnabled = true
        joystickSubstrateImageEnabled = true
        
        addApple(CGPoint(x: frame.midX, y: frame.midY))
        view.isMultipleTouchEnabled = true
    }
    
    func addApple(_ position: CGPoint) {
        guard let appleImage = UIImage(named: "apple") else { return }
        
        let texture = SKTexture(image: appleImage)
        let apple = SKSpriteNode(texture: texture)
        apple.physicsBody = SKPhysicsBody(texture: texture, size: apple.size)
        apple.physicsBody!.affectedByGravity = false
        apple.position = position
        
        addChild(apple)
        appleNode = apple
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}
