//
//  Shader.vsh
//  Xcode_iOS_openGLES_Texture_Experiment_BasedOnGameTemplate
//
//  Created by Sebastien Binet on 2015-10-20.
//  Copyright © 2015 Sebastien Binet. All rights reserved.
//

attribute vec4 position;

// NORMALS ARE NOT USED IN THIS TEST VERSION -  attribute vec3 normal;

// colorVarying IS USED IN THIS TEST VERSION -  varying lowp vec4 colorVarying;

uniform mat4 modelViewProjectionMatrix;

// NORMALS ARE NOT USED IN THIS TEST VERSION -  uniform mat3 normalMatrix;


// for texture test
attribute vec2 texCoordIn;
varying  highp vec2 texCoordOut;


// if ever we need a value sweeping between 0 and 1, use sebFloatUniform
uniform float sebFloatUniform;

void main()
{
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  vec3 eyeNormal = normalize(normalMatrix * normal);
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  vec4 diffuseColor = vec4(0.4, 0.4, 1.0, 1.0);
    
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
                 
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  colorVarying IS USED IN THIS TEST VERSION -  colorVarying = diffuseColor * nDotVP;
    
    gl_Position = modelViewProjectionMatrix * position;
    
    // for texture test
    texCoordOut = texCoordIn;
}
