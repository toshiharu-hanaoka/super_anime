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

@interface SuperAnimNode_bridge : SKNode
{
    id _obj;
}

+(SuperAnimNode_bridge*)create:(NSString*)theAbsAnimFile
                       theId:(int)theId
                       theListener:(SuperAnimNodeListener*)theListener;

@end

