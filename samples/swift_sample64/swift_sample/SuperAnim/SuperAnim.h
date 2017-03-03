//
//  SuperAnim.h
//  swift_sample
//
//  Created by 株式会社ニジボックス on 2017/01/23.
//  Copyright © 2017年 とますにこらす. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

//@protocol SuperAnimNodeDelegate
//@optional
//@required
//- (void) callback:(int)theId;
//@end

@interface SuperAnimNode_cocos2d : NSObject
+(UIView*)init_gl;
@end

@protocol SuperAnimNodeDelegate <NSObject>
@optional
-(void) OnAnimSectionEnd: (int)theId label:(NSString*) theLabelName;
-(void) OnTimeEvent:(int) theId label:(NSString*)theLabelName eventId:(int) theEventId;

@end


@interface SuperAnimNode_swift : SKNode
{
    id _obj;
    id _listener;
    SKSpriteNode* sprite;
}
@property (nonatomic,readwrite) BOOL flipX;
@property (nonatomic,readwrite) BOOL flipY;
@property (nonatomic,readwrite) float speedFactor;

+(SuperAnimNode_swift*)create:(NSString*)theAbsAnimFile
                        theId:(int)theId
                     listener:(id <SuperAnimNodeDelegate>) theListner;
//+(void)update:(CFTimeInterval)interval;
-(void)setPosition:(CGPoint)position;
-(void)playSection:(NSString*)theLabel
              loop:(bool)isLoop;
-(void) Pause;
-(void) Resume;
-(BOOL) IsPause;
-(BOOL) IsPlaying;
-(int) GetCurFrame;
-(NSString*) GetCurSectionName;
-(BOOL) HasSection:(NSString*) theLabelName;
// for replaceable sprite
-(void) replaceSprite:(NSString*) theOriginSpriteName newSpriteName:(NSString*) theNewSpriteName;
-(void) resumeSprite:(NSString*) theOriginSpriteName;

// for time event
// theTimeFactor is in [0.0f, 1.0f],
// theTimeFactor = 0.0f means the event will be triggered at the first frame,
// theTimeFactor = 1.0f means the event will be triggered at the last frame
-(void) registerTimeEvent:(NSString*)theLabel timeFactor:(float)theTimeFactor timeEventId:(int)theEventId;
-(void) removeTimeEvent:(NSString*) theLabel timeEventId:(int) theEventId;

// support sprite sheet
-(void) tryLoadSpriteSheet;
-(void) tryUnloadSpirteSheet;

// If you want to load super animation file before create super anim node,
// call this function.
+(BOOL) LoadAnimFileExt:(const char*) theAbsAnimFile;
// super animation file is loaded automatically when creating super anim node, then stored in a cache.
// if you want to unload it, call this function.
// P.S.: the textures used in animation are still in memory after call the function.
// cocos2d keep a reference to these textures, call removeUnusedTextures by yourself
// to remove those texture.
+(void) UnloadAnimFileExt:(const char*) theAbsAnimFile;

// 表示を削除するためには以下を呼び出すこと
-(void)removeSprite;
// スプライトのサイズを知るための関数
-(CGSize)getSize;


@end

