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
//    private var skView: SKView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        skView = SKView(frame: frame)
//        self.addSubview(skView)
//         skView.bounds = self.bounds
        
        let scene = GameScene(size: self.bounds.size)
        scene.backgroundColor = .white

        showsFPS = true
        showsNodeCount = true
        ignoresSiblingOrder = true
        presentScene(scene)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
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
