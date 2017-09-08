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
    @IBOutlet weak var stickView: StickView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set tracking handlers
        stickView.didMove = { (a: AnalogJoystickData) -> () in
            print(a)
        }
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

