//
//  Shader.fsh
//  Xcode_iOS_openGLES_Texture_Experiment_BasedOnGameTemplate
//
//  Created by Sebastien Binet on 2015-10-20.
//  Copyright © 2015 Sebastien Binet. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
