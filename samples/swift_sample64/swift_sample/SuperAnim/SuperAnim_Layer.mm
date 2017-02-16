//
//  SuperAnim_Layer.mm
//  swift_sample
//
//  Created by 株式会社ニジボックス on 2017/01/27.
//  Copyright © 2017年 とますにこらす. All rights reserved.
//

#import "SuperAnim_Layer.h"

@implementation SuperAnim_Layer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    SuperAnim_Layer *layer = [SuperAnim_Layer node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super's" return value
    if( (self=[super initWithColor:ccc4(255,0,0,0)]) ) {
    }

    return self;
}

-(void)addChild_node:(SuperAnimNode*)obj
{
    [self addChild:obj];
}


@end