//
//  GameScene.swift
//  swift_sample
//
//  Created by 株式会社ニジボックス on 2017/01/23.
//  Copyright (c) 2017年 とますにこらす. All rights reserved.
//

import SpriteKit

let SAM_BASIC = "basic_transform/basic_transform.sam";
//const char* SAM_ATTACK_FRONT = "attack_front/attack_front.sam";
//const char* SAM_FADEIN_TAP = "fadein_tap/fadein-tap.sam";
let SAM_FISH = "fish/fish";
//const char* SAM_FISH_SPRITESHEET = "fish_spritesheet/fish.sam";
//const char* SAM_FISH_50 = "fish_50/fish.sam";
//const char* SAM_FISH_150 = "fish_150/fish.sam";
//const char* SAM_RENAME_SPRITESHEET = "rename_sprite/rename-spritesheet/attack_front.sam";
//const char* SPRITE_RENAME_SPRITESHEET_HAT_HEAD_ORIGIN = "rename_sprite/rename-spritesheet/hat_head.png";
//const char* SPRITE_RENAME_SPRITESHEET_HAT_HEAD_NEW = "rename_sprite/rename-spritesheet/hat_head_new.png";
//const char* SAM_NO_FLICKER = "no-flicker/no-flicker.sam";


class GameScene: SKScene, SuperAnimNodeDelegate {
    
    var sprite1 : SuperAnimNode_swift! = nil
    var sprite2 : SuperAnimNode_swift! = nil
    var sprite3 : SuperAnimNode_swift! = nil
    var sprite4 : SuperAnimNode_swift! = nil
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)

        //fullpath
        let filepath = NSBundle.mainBundle().pathForResource(SAM_FISH, ofType: "sam",inDirectory: "auto_sync_resource")
        
        //blue
        /*
        let rect = CGRect(
            origin: CGPoint(x: 187, y:333.5),
            size: CGSize(width: 100, height: 100)
        )
        NSLog("FrameWidth=%f",self.frame.width)
        let node = SKShapeNode(rect: rect)
        node.fillColor = UIColor.blueColor()
        self.addChild(node)
        */
        
        //座標のチェックをしてみる
        //###以下の４つが揃っていないと座標関係がおかしくなる
        let UISize = UIScreen.mainScreen().bounds.size
        NSLog("UIView_Size:w%f,h%f",UISize.width,UISize.height)
        let SNSize = self.frame.size;
        NSLog("SKScene_Size:w%f,h%f",SNSize.width,SNSize.height)
        let SVSize = view.frame.size;
        NSLog("SKView_Size:w%f,h%f",SVSize.width,SVSize.height)
        let COSize = swf_view.frame.size;
        NSLog("opengl_Size:w%f,h%f",COSize.width,COSize.height)
        
        let scene_y:CGFloat = 0.0; //SNSize.height;
        let test = self.convertPointToView(CGPointMake(0,scene_y))
        NSLog("scene_y:%f --> ui_y:%f",scene_y,test.y);
        
        //idle chara
        // SuperAnimNodeはデバイスの座標系になっているので、swf_viewのサイズから計算
        let WinSize = swf_view.frame.size;

        sprite1 = SuperAnimNode_swift.create(filepath, theId: 1, listener:self, scene: self)
        sprite1.position = CGPoint(x: WinSize.width*0.25 ,y: WinSize.height*0.75)
        sprite1.flipX = false;
        sprite1.flipY = false;
        sprite1.playSection("idle",loop:true)
        sprite1.registerTimeEvent("idle", timeFactor: 0.5, timeEventId: 1)
        self.addChild(sprite1)
        
        sprite2 = SuperAnimNode_swift.create(filepath, theId: 1, listener:self, scene: self)
        sprite2.position = CGPoint(x: WinSize.width*0.75 ,y: WinSize.height*0.75)
        sprite2.flipX = true;
        sprite2.flipY = false;
        sprite2.playSection("idle",loop:true)
        sprite2.registerTimeEvent("idle", timeFactor: 0.5, timeEventId: 2)
        self.addChild(sprite2)

        sprite3 = SuperAnimNode_swift.create(filepath, theId: 1, listener:self, scene: self)
        sprite3.position = CGPoint(x: WinSize.width*0.25 ,y: WinSize.height*0.25)
        sprite3.flipX = false;
        sprite3.flipY = true;
        sprite3.playSection("idle",loop:true)
        sprite3.registerTimeEvent("idle", timeFactor: 0.5, timeEventId: 3)
        self.addChild(sprite3)
        
        sprite4 = SuperAnimNode_swift.create(filepath, theId: 1, listener:self, scene: self)
        sprite4.position = CGPoint(x: WinSize.width*0.75 ,y: WinSize.height*0.25)
        sprite4.flipX = true;
        sprite4.flipY = true;
        sprite4.playSection("idle",loop:true)
        sprite4.registerTimeEvent("idle", timeFactor: 0.5, timeEventId: 4)
        self.addChild(sprite4)
        
        //flashの表示Viewを追加する（これを入れないとflashは表示されない)
        self.view?.addSubview(swf_view);

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
       sprite1.playSection("active",loop:false);

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    //Sceneが破棄されるときにはspreiteを外すこと（removeChildは不要)
    override func willMoveFromView(view: SKView) {
        sprite1.removeSprite()
    }
    
    @objc func OnAnimSectionEnd(theId: Int32, label theLabelName: String!) {
        //NSLog("OnAnimSectionEnd")
        if (theId==1) {
            if (theLabelName=="active") {
                sprite1.playSection("idle", loop: true);
            }
        }
    }
    
    @objc func OnTimeEvent(theId: Int32, label theLabelName: String!, eventId theEventId: Int32) {
        //NSLog("OnTimeEvent")
    }
}

