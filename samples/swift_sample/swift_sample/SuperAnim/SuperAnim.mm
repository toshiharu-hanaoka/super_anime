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

@implementation SuperAnimNode

-(id)init {
    self = [super init];
    return self;
}

+(SuperAnimNode*)create:(NSString*)theAbsAnimFile
                  theId:(int)theId
             theListener:(SuperAnimNodeListener*)theListener {
    //for test
    SuperAnimNode *node = [SuperAnimNode init];
    node->_obj = (void*)SuperAnim::SuperAnimNode::create("File",1,nil);
    return node;
}

@end
