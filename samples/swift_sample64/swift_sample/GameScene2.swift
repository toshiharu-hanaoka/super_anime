//
//  GameScene2.swift
//  swift_sample
//
//  Created by 株式会社ニジボックス on 2017/03/02.
//  Copyright © 2017年 とますにこらす. All rights reserved.
//

import SpriteKit

class GameScene2: SKScene, SuperAnimNodeDelegate {
    
    var sprite : SuperAnimNode_swift! = nil
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = SKColor(red: 0.1, green: 0.1, blue: 0.8, alpha: 1.0)
        
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Prev"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        myLabel.name = "Prev"
        self.addChild(myLabel)

        //fullpath
        let filepath = NSBundle.mainBundle().pathForResource(SAM_FISH, ofType: "sam",inDirectory: "auto_sync_resource")
        
        //idle chara
        // SuperAnimNodeはデバイスの座標系になっているので、swf_viewのサイズから計算
        let WinSize = swf_view.frame.size;
        
        sprite = SuperAnimNode_swift.create(filepath, theId: 1, listener:self)
        sprite.position = CGPoint(x: WinSize.width*0.5 ,y: WinSize.height*0.75)
        sprite.flipX = false;
        sprite.flipY = false;
        sprite.playSection("idle",loop:true)
        sprite.registerTimeEvent("idle", timeFactor: 0.5, timeEventId: 1)
        self.addChild(sprite)
        
        //flashの表示Viewを追加する（これを入れないとflashは表示されない)
        self.view?.addSubview(swf_view);
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let touchEvent = touches.first!
        let location = touchEvent.locationInNode(self);
        let touchNode = self.nodeAtPoint(location);
        
        if (touchNode.name != nil) {
            if (touchNode.name == "Prev") {
                let newScene = GameScene(size: self.scene!.size)
                newScene.scaleMode = SKSceneScaleMode.AspectFill
                
                self.scene!.view?.presentScene(newScene);
            } else {
                sprite.playSection("active",loop:false);
            }
        }
        
    }

    //### Sceneが破棄されるときにはspriteを外すこと（removeChildは不要)
    override func willMoveFromView(view: SKView) {
        sprite.removeSprite()
    }
    
    @objc func OnAnimSectionEnd(theId: Int32, label theLabelName: String!) {
        //NSLog("OnAnimSectionEnd")
        if (theLabelName=="active") {
                sprite.playSection("idle", loop: true);
        }
    }
    
    
}