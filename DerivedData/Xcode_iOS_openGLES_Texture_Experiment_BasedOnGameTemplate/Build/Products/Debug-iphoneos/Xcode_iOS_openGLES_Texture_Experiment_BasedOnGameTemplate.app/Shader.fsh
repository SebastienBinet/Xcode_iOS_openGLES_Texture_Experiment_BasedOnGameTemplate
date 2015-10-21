//
//  Shader.fsh
//  Xcode_iOS_openGLES_Texture_Experiment_BasedOnGameTemplate
//
//  Created by Sebastien Binet on 2015-10-20.
//  Copyright © 2015 Sebastien Binet. All rights reserved.
//

// for no texture
varying lowp vec4 colorVarying;

// for texture
varying highp vec2 texCoordOut;
uniform sampler2D mytexture;

void main()
{
    // for no texture
    // gl_FragColor = colorVarying;
    
    // for texture
//    gl_FragColor = vec4(texCoordOut.x , texCoordOut.y, 0.0, 1.0);
    gl_FragColor = texture2D(mytexture, texCoordOut);
//    gl_FragColor = texture2D(mytexture, texCoordOut.st, 0.0);
//    gl_FragColor = vec4(0.0, 0.0, 1.0, 1.0);

}
