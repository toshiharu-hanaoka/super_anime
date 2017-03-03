//
//  SuperAnim.mm
//  swift_sample
//
//  Created by 株式会社ニジボックス on 2017/01/23.
//  Copyright © 2017年 とますにこらす. All rights reserved.
//

#include "SuperAnimNodeV2.h"
#include <string>
#import "SuperAnim.h"
#import "cocos2d.h"
#import "SuperAnim_Layer.h"

static CCScene *static_scene;

@implementation SuperAnimNode_cocos2d
+(UIView*)init_gl {
    
    // Create the main window
    //UIWindow *window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //UIWindow *window_ = [[[UIApplication sharedApplication] delegate] window];
    //CGRect rect = [window_ bounds];
    CGRect rect = [[UIScreen mainScreen] bounds];
    //CGRect rect = base_view.bounds;
    
    // Create an CCGLView with a RGB565 color buffer, and a depth buffer of 0-bits
    CCGLView *glView = [CCGLView viewWithFrame:rect
                                   //pixelFormat:kEAGLColorFormatRGB565	//kEAGLColorFormatRGBA8
                                   pixelFormat:kEAGLColorFormatRGBA8
                                   depthFormat:0	//GL_DEPTH_COMPONENT24_OES
                            preserveBackbuffer:NO
                                    sharegroup:nil
                                 multiSampling:NO
                               numberOfSamples:0];
    
    CCDirector* director_ = (CCDirectorIOS*) [CCDirector sharedDirector];

    //director_.wantsFullScreenLayout = YES;
    
    // Display FSP and SPF
    //[director_ setDisplayStats:YES];
    
    // set FPS at 60
    [director_ setAnimationInterval:1.0/60];
    
    // attach the openglView to the director
    [director_ setView:glView];
    
    // for rotation and other messages
    [director_ setDelegate:self];
    
    // 2D projection
    [director_ setProjection:kCCDirectorProjection2D];
    //	[director setProjection:kCCDirectorProjection3D];
    
    // Enables High Res mode (Retina Display) on iPhone 4 and maintains low res on all other devices
    if( ! [director_ enableRetinaDisplay:YES] )
        CCLOG(@"Retina Display Not supported");
    
    // Default texture format for PNG/BMP/TIFF/JPEG/GIF images
    // It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
    // You can change anytime.
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    
    // If the 1st suffix is not found and if fallback is enabled then fallback suffixes are going to searched. If none is found, it will try with the name without suffix.
    // On iPad HD  : "-ipadhd", "-ipad",  "-hd"
    // On iPad     : "-ipad", "-hd"
    // On iPhone HD: "-hd"
    CCFileUtils *sharedFileUtils = [CCFileUtils sharedFileUtils];
    [sharedFileUtils setEnableFallbackSuffixes:NO];				// Default: NO. No fallback suffixes are going to be used
    [sharedFileUtils setiPhoneRetinaDisplaySuffix:@"-hd"];		// Default on iPhone RetinaDisplay is "-hd"
    [sharedFileUtils setiPadSuffix:@"-ipad"];					// Default on iPad is "ipad"
    [sharedFileUtils setiPadRetinaDisplaySuffix:@"-ipadhd"];	// Default on iPad RetinaDisplay is "-ipadhd"
    
    // Assume that PVR images have premultiplied alpha
    [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
    
    //Layer
    CCScene *scene = [SuperAnim_Layer node];
    
    static_scene = scene;
    
    [director_ pushScene:scene];
    
    //glViewを透過にするための処理
    glView.userInteractionEnabled = NO;
    glView.opaque = NO;
    
    return glView;
}
@end

//callback bridge
@interface SuperAnimNodeListener_bridge : NSObject <SuperAnimNodeListener>
-(id)init;
@property (nonatomic,assign) id <SuperAnimNodeDelegate> delegate;
@end

@implementation SuperAnimNodeListener_bridge

-(id)init {
    self = [super init];
    return self;
}

-(void) OnAnimSectionEnd: (int)theId label:(NSString*) theLabelName
{
    //NSLog(@"OnAnimSectionEnd");
    if ([_delegate respondsToSelector:@selector(OnAnimSectionEnd:label:)]) {
        [_delegate OnAnimSectionEnd:theId label:theLabelName];
    }
}
-(void) OnTimeEvent:(int) theId label:(NSString*)theLabelName eventId:(int) theEventId
{
    //NSLog(@"OnTimeEvent");
    if ([_delegate respondsToSelector:@selector(OnTimeEvent:label:eventId:)]) {
        [_delegate OnTimeEvent:theId label:theLabelName eventId:theEventId];
    }
}

@end

//static NSMutableArray *nodes=nil;

@implementation SuperAnimNode_swift

-(id)init {
    self = [super init];
    /*
    if (nodes == nil) {
        nodes = [NSMutableArray array];
    }
     */
    return self;
}

+(SuperAnimNode_swift*)create:(NSString*)theAbsAnimFile
                         theId:(int)theId
                     listener:(id <SuperAnimNodeDelegate>) theListener
{
    SuperAnimNode_swift *node = [SuperAnimNode_swift node];
    
    //listenerの設定
    if (theListener!=nil) {
        node->_listener = [[SuperAnimNodeListener_bridge alloc] init];
        ((SuperAnimNodeListener_bridge*)node->_listener).delegate = theListener;
    } else {
        node->_listener = nil;
    }
    
    node->_obj = [SuperAnimNode create:theAbsAnimFile id:theId listener:node->_listener];
        
    SuperAnimNode *obj = (SuperAnimNode*)node->_obj;

    //タッチするようのNode (alpha=0にすれば見えない)
    node->sprite = [SKSpriteNode spriteNodeWithColor:[UIColor colorWithWhite:1.0 alpha:0.0]
                                                        size:obj.contentSize];
    
    node->sprite.name = @"";
    [node addChild:node->sprite];
    node.zPosition = 1000;
    
    //_objをつなげる　updateが呼ばれないので呼ばれるようするため。
    [static_scene addChild:node->_obj];
    
    
    //nodesに追加
    //[nodes addObject:node];
    
    return node;
}

/*
+(void)update:(CFTimeInterval)interval {
    if (nodes!=nil) {
        for(id item in nodes) {
            SuperAnimNode_bridge *node =(SuperAnimNode_bridge*)item;
            SuperAnimNode *_node = (SuperAnimNode*)node->_obj;
            [_node update:(ccTime)interval];
        }
    }
}
 */

-(void)setPosition:(CGPoint)position {
    SuperAnimNode *obj = (SuperAnimNode*)_obj;
    
    obj.position = position;
    
    super.position = position;
}

-(void)playSection:(NSString*)theLabel
        loop:(bool)isLoop
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;
    
    [obj PlaySection:theLabel isLoop:isLoop];
}

-(void)setFlipX:(BOOL)flipX
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    obj.flipX = flipX;
}

-(BOOL)getFlipX
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    return obj.flipX;
}

-(void)setFlipY:(BOOL)flipY
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;
    
    obj.flipY = flipY;
}

-(BOOL)getFlipY
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;
    
    return obj.flipY;
}

-(void)setSpeedFactor:(float)speedFactor
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    obj.speedFactor = speedFactor;
}

-(float)getSpeedFactor
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    return obj.speedFactor;
}

-(void)Pause
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    return [obj Pause];
}

-(void)Resume
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;
    
    return [obj Resume];
}

-(BOOL) IsPause
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;
    
    return [obj IsPause];
}

-(BOOL) IsPlaying
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    return [obj IsPlaying];
}

-(int) GetCurFrame
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    return [obj GetCurFrame];
}

-(NSString*) GetCurSectionName
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    return [obj GetCurSectionName];
}

-(BOOL) HasSection:(NSString*) theLabelName
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    return [obj HasSection:theLabelName];
}

-(void) replaceSprite:(NSString*) theOriginSpriteName newSpriteName:(NSString*) theNewSpriteName
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    [obj replaceSprite:theOriginSpriteName newSpriteName:theNewSpriteName];
}

-(void) resumeSprite:(NSString*) theOriginSpriteName
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;
    
    [obj resumeSprite:theOriginSpriteName];
}

-(void) registerTimeEvent:(NSString*)theLabel timeFactor:(float)theTimeFactor timeEventId:(int)theEventId
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    [obj registerTimeEvent:theLabel timeFactor:theTimeFactor timeEventId:theEventId];
}

-(void) removeTimeEvent:(NSString*) theLabel timeEventId:(int) theEventId
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    [obj removeTimeEvent:theLabel timeEventId:theEventId];
}

-(void) tryLoadSpriteSheet
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    [obj tryLoadSpriteSheet];
}

-(void) tryUnloadSpirteSheet
{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    [obj tryUnloadSpirteSheet];
}

+(BOOL) LoadAnimFileExt:(const char*) theAbsAnimFile
{
    return [SuperAnimNode LoadAnimFileExt:theAbsAnimFile];
}

+(void) UnloadAnimFileExt:(const char*) theAbsAnimFile
{
    [SuperAnimNode UnloadAnimFileExt:theAbsAnimFile];
}

// SuperAnimNodeを削除するための関数
-(void)removeSprite

{
    SuperAnimNode *obj = (SuperAnimNode*)_obj;

    [static_scene removeChild:obj];
    
    NSLog(@"removeSprite");
}

-(void)dealloc
{
    //NSLog(@"dealloc");
}


// Spriteのサイズを知るための関数
-(CGSize)getSize
{
    return sprite.frame.size;
}

-(void)setName:(NSString*)name
{
    sprite.name = name;
}

-(NSString*)getName
{
    return sprite.name;
}

@end
