//
//  SuperAnim_Layer.h
//  swift_sample
//
//  Created by 株式会社ニジボックス on 2017/01/27.
//  Copyright © 2017年 とますにこらす. All rights reserved.
//

#ifndef SuperAnim_Layer_h
#define SuperAnim_Layer_h

#import "cocos2d.h"
#import "SuperAnimNodeV2.h"

//@interface SuperAnim_Layer : CCLayer <SuperAnimNodeListener>
@interface SuperAnim_Layer : CCScene
{
    //SuperAnimNode* mAnimNode[100];
}

-(void)addChild_node:(SuperAnimNode*)obj;

@end


#endif /* Header_h */
