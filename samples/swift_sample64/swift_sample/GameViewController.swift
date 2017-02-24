//
//  GameViewController.swift
//  swift_sample
//
//  Created by 株式会社ニジボックス on 2017/01/23.
//  Copyright (c) 2017年 とますにこらす. All rights reserved.
//

import UIKit
import SpriteKit

var swf_view:(UIView!) = nil

class GameViewController: UIViewController {

    override func loadView() {
        //self.view = SKView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        self.view = SKView(frame: CGRect(x: 0, y: 0, width: 320, height: 568)) //SKViewのサイズをiphoneの画面に合わせる
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //#### init_cocos2d
        swf_view = SuperAnimNode_cocos2d.init_gl() //これは画面全体のpixel sizeとなる
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
            //### ??これがあると座標系が乱れる。何やっているのだろう?
            // ※SKSceneはデフォルトで1024 x 768のため、どれを指定しても拡大縮小してしまう。
            scene.scaleMode = .AspectFill
            //scene.scaleMode = .AspectFit
            //  scene.scaleMode = .ResizeFill
            //  scene.scaleMode = .Fill
            
            // SKSceneサイズをViewサイズに合わせる
            // これによって表示時のスケーリングを無くすことができる。
            scene.size = skView.frame.size; //SKSceneのサイズをskViewに合わせる
                        
            
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
