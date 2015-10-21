//
//  Shader.vsh
//  Xcode_iOS_openGLES_Texture_Experiment_BasedOnGameTemplate
//
//  Created by Sebastien Binet on 2015-10-20.
//  Copyright © 2015 Sebastien Binet. All rights reserved.
//

attribute vec4 position;

// for no texture
// attribute vec3 normal;

// for no texture
// varying lowp vec4 colorVarying;

uniform mat4 modelViewProjectionMatrix;

// for no texture
//uniform mat3 normalMatrix;


// for texture test
attribute vec2 texCoordIn;
varying  highp vec2 texCoordOut;


uniform float sebFloatUniform;

void main()
{
    // for no texture
    // vec3 eyeNormal = normalize(normalMatrix * normal);
    // vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    // vec4 diffuseColor = vec4(0.4, 0.4, 1.0, 1.0);
    
    // float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
                 
    // colorVarying = diffuseColor * nDotVP;
    
    gl_Position = modelViewProjectionMatrix * position;
    
    // for texture test
//    if (texCoordIn.x <= 0.50) {
//        texCoordOut = vec2(0.25, 0.25);
//    } else {
//        texCoordOut = vec2(0.75, 0.25);
//    }
//    texCoordOut = vec2(0.0175, 0.0175);
//    texCoordOut = vec2(sebFloatUniform, 1.0 - sebFloatUniform);
//    texCoordOut = vec2(sebFloatUniform, texCoordIn.y);
    texCoordOut = texCoordIn;
}
