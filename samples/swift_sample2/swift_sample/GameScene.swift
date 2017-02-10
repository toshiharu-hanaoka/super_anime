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


class GameScene: SKScene {
    
    var sprite : SuperAnimNode_bridge! = nil
    
    override func didMoveToView(view: SKView) {
        
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "Hello, World!"
        myLabel.fontSize = 45
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        
        self.addChild(myLabel)

        //fullpath
        let filepath = NSBundle.mainBundle().pathForResource(SAM_FISH, ofType: "sam",inDirectory: "auto_sync_resource")
        
        //idle chara
        let WinSize = UIScreen.mainScreen().bounds.size
        sprite = SuperAnimNode_bridge.create(filepath, theId: 1, theListener: nil)
        sprite.position = CGPoint(x: WinSize.width/2,y: WinSize.height/2)
        sprite.playSection("idle",loop:true)
        self.addChild(sprite);
        
        //cocos_view.opaque = false
        self.view?.addSubview(cocos_view);

    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
       sprite.playSection("active",loop:false);

    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
