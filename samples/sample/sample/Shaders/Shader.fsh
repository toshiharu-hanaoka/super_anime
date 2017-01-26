//
//  Shader.fsh
//  sample
//
//  Created by 株式会社ニジボックス on 2017/01/24.
//  Copyright © 2017年 とますにこらす. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
