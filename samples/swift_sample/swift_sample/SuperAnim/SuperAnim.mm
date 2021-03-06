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
+(UIView*)init_cocos2d {
    
    // Create the main window
    //UIWindow *window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIWindow *window_ = [[[UIApplication sharedApplication] delegate] window];
    CGRect rect = [window_ bounds];
    
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
    [director_ setDisplayStats:YES];
    
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
    
    /*
    UINavigationController* navController_ = [[UINavigationController alloc] initWithRootViewController:director_];
    navController_.navigationBarHidden = YES;
    
    // set the Navigation Controller as the root view controller
    //	[window_ addSubview:navController_.view];	// Generates flicker.
    [window_ setRootViewController:navController_];
    
    // make main window visible
    [window_ makeKeyAndVisible];
    */
    
    glView.userInteractionEnabled = NO;
    glView.opaque = NO;
    
    return glView;
}
@end

//static NSMutableArray *nodes=nil;

@implementation SuperAnimNode_bridge

-(id)init {
    self = [super init];
    /*
    if (nodes == nil) {
        nodes = [NSMutableArray array];
    }
     */
    return self;
}

+(SuperAnimNode_bridge*)create:(NSString*)theAbsAnimFile
                  theId:(int)theId
             theListener:(id<SuperAnimNodeListener>)theListener {
    //for test
    SuperAnimNode_bridge *node = [SuperAnimNode_bridge node];
    node->_obj = [SuperAnimNode create:theAbsAnimFile id:theId listener:theListener];
    
    //_objをつなげる　### updateが呼ばれないので呼ばれるようにしたい。
    //SuperAnim_Layerにつなげるとどうか検証→呼ばれるようになった
    
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
}

-(void)playSection:(NSString*)theLabel
        loop:(bool)isLoop {
    SuperAnimNode *obj = (SuperAnimNode*)_obj;
    
    [obj PlaySection:theLabel isLoop:isLoop];
}

@end
