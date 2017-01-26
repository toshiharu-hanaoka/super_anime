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

@implementation SuperAnimNode_bridge

-(id)init {
    self = [super init];
    return self;
}

+(SuperAnimNode_bridge*)create:(NSString*)theAbsAnimFile
                  theId:(int)theId
             theListener:(id<SuperAnimNodeListener>)theListener {
    //for test
    SuperAnimNode_bridge *node = [SuperAnimNode init];
    node->_obj = [SuperAnimNode create:@"xxx" id:theId listener:theListener];
    return node;
}

@end
