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

    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: self.view.bounds.size)
        scene.backgroundColor = .white
        
        if let skView = self.view as? SKView {
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.ignoresSiblingOrder = true
            skView.presentScene(scene)
        }
    }
    
    override var shouldAutorotate : Bool {
        return true
    }
    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask  {
        return UIDevice.current.userInterfaceIdiom == .phone ? .allButUpsideDown : .all
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}

class GameScene: SKScene {
    var appleNode: SKSpriteNode?
    let jSizePlusSpriteNode = SKSpriteNode(imageNamed: "plus")
    let jSizeMinusSpriteNode = SKSpriteNode(imageNamed: "minus")
    let setJoystickStickImageBtn = SKLabelNode()
    let setJoystickSubstrateImageBtn = SKLabelNode()
    let joystickStickColorBtn = SKLabelNode(text: "Sticks random color")
    let joystickSubstrateColorBtn = SKLabelNode(text: "Substrates random color")
    
    let moveAnalogStick = AnalogJoystick(diameter: 110)
    let rotateAnalogStick = AnalogJoystick(diameter: 100)
    
    var joystickStickImageEnabled = true {
        didSet {
            let image = joystickStickImageEnabled ? UIImage(named: "jStick") : nil
            moveAnalogStick.stick.image = image
            rotateAnalogStick.stick.image = image
            setJoystickStickImageBtn.text = "\(joystickStickImageEnabled ? "Remove" : "Set") stick image"
        }
    }
    
    var joystickSubstrateImageEnabled = true {
        didSet {
            let image = joystickSubstrateImageEnabled ? UIImage(named: "jSubstrate") : nil
            moveAnalogStick.substrate.image = image
            rotateAnalogStick.substrate.image = image
            setJoystickSubstrateImageBtn.text = "\(joystickSubstrateImageEnabled ? "Remove" : "Set") substrate image"
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
        
        
        let selfHeight = frame.height
        let btnsOffset: CGFloat = 10
        let btnsOffsetHalf = btnsOffset / 2
        let joystickSizeLabel = SKLabelNode(text: "Joysticks Size:")
        
//        joystickSizeLabel.fontSize = 20
//        joystickSizeLabel.fontColor = UIColor.black
//        joystickSizeLabel.horizontalAlignmentMode = .left
//        joystickSizeLabel.verticalAlignmentMode = .top
//        joystickSizeLabel.position = CGPoint(x: btnsOffset, y: selfHeight - btnsOffset)
//        addChild(joystickSizeLabel)
//        
//        joystickStickColorBtn.fontColor = UIColor.black
//        joystickStickColorBtn.fontSize = 20
//        joystickStickColorBtn.verticalAlignmentMode = .top
//        joystickStickColorBtn.horizontalAlignmentMode = .left
//        joystickStickColorBtn.position = CGPoint(x: btnsOffset, y: selfHeight - 40)
//        addChild(joystickStickColorBtn)
//        
//        joystickSubstrateColorBtn.fontColor = UIColor.black
//        joystickSubstrateColorBtn.fontSize = 20
//        joystickSubstrateColorBtn.verticalAlignmentMode = .top
//        joystickSubstrateColorBtn.horizontalAlignmentMode = .left
//        joystickSubstrateColorBtn.position = CGPoint(x: btnsOffset, y: selfHeight - 65)
//        addChild(joystickSubstrateColorBtn)
//        
//        jSizeMinusSpriteNode.anchorPoint = CGPoint(x: 0, y: 0.5)
//        jSizeMinusSpriteNode.position = CGPoint(x: joystickSizeLabel.frame.maxX + btnsOffset, y: joystickSizeLabel.frame.midY)
//        addChild(jSizeMinusSpriteNode)
//        
//        jSizePlusSpriteNode.anchorPoint = CGPoint(x: 0, y: 0.5)
//        jSizePlusSpriteNode.position = CGPoint(x: jSizeMinusSpriteNode.frame.maxX + btnsOffset, y: joystickSizeLabel.frame.midY)
//        addChild(jSizePlusSpriteNode)
//        
//        setJoystickStickImageBtn.fontColor = UIColor.black
//        setJoystickStickImageBtn.fontSize = 20
//        setJoystickStickImageBtn.verticalAlignmentMode = .bottom
//        setJoystickStickImageBtn.position = CGPoint(x: frame.midX, y: moveAnalogStick.position.y - btnsOffsetHalf)
//        addChild(setJoystickStickImageBtn)
//        
//        setJoystickSubstrateImageBtn.fontColor  = UIColor.black
//        setJoystickSubstrateImageBtn.fontSize = 20
//        setJoystickStickImageBtn.verticalAlignmentMode = .top
//        setJoystickSubstrateImageBtn.position = CGPoint(x: frame.midX, y: moveAnalogStick.position.y + btnsOffsetHalf)
//        addChild(setJoystickSubstrateImageBtn)
        
        joystickStickImageEnabled = true
        joystickSubstrateImageEnabled = true
        
        setRandomStickColor()
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let node = atPoint(touch.location(in: self))
            
            switch node {
            case jSizePlusSpriteNode:
                moveAnalogStick.diameter += 1
                rotateAnalogStick.diameter += 1
            case jSizeMinusSpriteNode:
                moveAnalogStick.diameter -= 1
                rotateAnalogStick.diameter -= 1
            case setJoystickStickImageBtn:
                joystickStickImageEnabled = !joystickStickImageEnabled
            case setJoystickSubstrateImageBtn:
                joystickSubstrateImageEnabled = !joystickSubstrateImageEnabled
            case joystickStickColorBtn:
                setRandomStickColor()
            case joystickSubstrateColorBtn:
                setRandomSubstrateColor()
            default:
                addApple(touch.location(in: self))
            }
        }
    }
    
    func setRandomStickColor() {
        let randomColor = UIColor.random()
        moveAnalogStick.stick.color = randomColor
        rotateAnalogStick.stick.color = randomColor
    }
    
    func setRandomSubstrateColor() {
        let randomColor = UIColor.random()
        moveAnalogStick.substrate.color = randomColor
        rotateAnalogStick.substrate.color = randomColor
    }
}

extension UIColor {
    static func random() -> UIColor {
        return UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1)
    }
}
