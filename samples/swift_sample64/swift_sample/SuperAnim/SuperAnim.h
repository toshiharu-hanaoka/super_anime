//
//  SuperAnim.h
//  swift_sample
//
//  Created by 株式会社ニジボックス on 2017/01/23.
//  Copyright © 2017年 とますにこらす. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface SuperAnimNodeListener
{
    void *_obj;
}
@end

@interface SuperAnimNode_cocos2d : NSObject
+(UIView*)init_cocos2d;
@end

@interface SuperAnimNode_bridge : SKNode
{
    id _obj;
}
@property (nonatomic,readwrite) BOOL flipX;
@property (nonatomic,readwrite) BOOL flipY;
@property (nonatomic,readwrite) float speedFactor;

+(SuperAnimNode_bridge*)create:(NSString*)theAbsAnimFile
                       theId:(int)theId
                       theListener:(SuperAnimNodeListener*)theListener;
//+(void)update:(CFTimeInterval)interval;
-(void)setPosition:(CGPoint)position;
-(void)playSection:(NSString*)theLabel
              loop:(bool)isLoop;


@end

