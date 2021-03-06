//
//  GameViewController.swift
//  swift_sample
//
//  Created by 株式会社ニジボックス on 2017/01/23.
//  Copyright (c) 2017年 とますにこらす. All rights reserved.
//

import UIKit
import SpriteKit

var cocos_view:(UIView!) = nil

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //#### init_cocos2d
        cocos_view = SuperAnimNode_cocos2d.init_cocos2d()
        //self.view.addSubview(cocos_view)
        //NSLog("%f,%f",cocos_view.frame.height,cocos_view.frame.width);

        if let scene = GameScene(fileNamed:"GameScene") {

            // Configure the view.
            let skView = self.view as! SKView
            //let skView = cocos_view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
            
        }

    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
