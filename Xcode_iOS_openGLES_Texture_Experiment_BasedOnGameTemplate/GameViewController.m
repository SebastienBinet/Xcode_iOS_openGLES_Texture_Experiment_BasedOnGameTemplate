//
//  GameViewController.m
//  Xcode_iOS_openGLES_Texture_Experiment_BasedOnGameTemplate
//
//  Created by Sebastien Binet on 2015-10-20.
//  Copyright © 2015 Sebastien Binet. All rights reserved.
//

#import "GameViewController.h"
#import <OpenGLES/ES2/glext.h>
#include "Grid_image_256x256_3_BytesPerPixel.h"


#define BUFFER_OFFSET(i) ((char *)NULL + (i))

#define ADD_CHECKERBOARD_TEXTURE 1

// Uniform index.
enum
{
    UNIFORM_MODELVIEWPROJECTION_MATRIX,
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  UNIFORM_NORMAL_MATRIX,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum
{
    ATTRIB_VERTEX,
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  ATTRIB_NORMAL,
    ATTRIB_TEXTURE,
    NUM_ATTRIBUTES
};

const int tileMultiplier = 1;
const float maxUV = 1.0f * tileMultiplier;


#if ADD_CHECKERBOARD_TEXTURE
GLfloat gCubeVertexData[ 8 * 6 * 6 ] =
{
    // Data layout for each line below is:
   //posX,  posY,  posZ      normalX, normY, normZ,        U,    V
     0.5f, -0.5f, -0.5f,        1.0f,  0.0f,  0.0f,      0.00,  0.00,
     0.5f,  0.5f, -0.5f,        1.0f,  0.0f,  0.0f,     maxUV,  0.00,
     0.5f, -0.5f,  0.5f,        1.0f,  0.0f,  0.0f,      0.00, maxUV,
     0.5f, -0.5f,  0.5f,        1.0f,  0.0f,  0.0f,      0.00, maxUV,
     0.5f,  0.5f, -0.5f,        1.0f,  0.0f,  0.0f,     maxUV,  0.00,
     0.5f,  0.5f,  0.5f,        1.0f,  0.0f,  0.0f,     maxUV, maxUV,
    
     0.5f,  0.5f, -0.5f,        0.0f,  1.0f,  0.0f,     maxUV,  0.00,
    -0.5f,  0.5f, -0.5f,        0.0f,  1.0f,  0.0f,      0.00,  0.00,
     0.5f,  0.5f,  0.5f,        0.0f,  1.0f,  0.0f,     maxUV, maxUV,
     0.5f,  0.5f,  0.5f,        0.0f,  1.0f,  0.0f,     maxUV, maxUV,
    -0.5f,  0.5f, -0.5f,        0.0f,  1.0f,  0.0f,      0.00,  0.00,
    -0.5f,  0.5f,  0.5f,        0.0f,  1.0f,  0.0f,      0.00, maxUV,
    
    -0.5f,  0.5f, -0.5f,       -1.0f,  0.0f,  0.0f,     maxUV,  0.00,
    -0.5f, -0.5f, -0.5f,       -1.0f,  0.0f,  0.0f,      0.00,  0.00,
    -0.5f,  0.5f,  0.5f,       -1.0f,  0.0f,  0.0f,     maxUV, maxUV,
    -0.5f,  0.5f,  0.5f,       -1.0f,  0.0f,  0.0f,     maxUV, maxUV,
    -0.5f, -0.5f, -0.5f,       -1.0f,  0.0f,  0.0f,      0.00,  0.00,
    -0.5f, -0.5f,  0.5f,       -1.0f,  0.0f,  0.0f,      0.00, maxUV,
    
    -0.5f, -0.5f, -0.5f,        0.0f, -1.0f,  0.0f,      0.00,  0.00,
     0.5f, -0.5f, -0.5f,        0.0f, -1.0f,  0.0f,     maxUV,  0.00,
    -0.5f, -0.5f,  0.5f,        0.0f, -1.0f,  0.0f,      0.00, maxUV,
    -0.5f, -0.5f,  0.5f,        0.0f, -1.0f,  0.0f,      0.00, maxUV,
     0.5f, -0.5f, -0.5f,        0.0f, -1.0f,  0.0f,     maxUV,  0.00,
     0.5f, -0.5f,  0.5f,        0.0f, -1.0f,  0.0f,     maxUV, maxUV,
    
     0.5f,  0.5f,  0.5f,        0.0f,  0.0f,  1.0f,     maxUV, maxUV,
    -0.5f,  0.5f,  0.5f,        0.0f,  0.0f,  1.0f,      0.00, maxUV,
     0.5f, -0.5f,  0.5f,        0.0f,  0.0f,  1.0f,     maxUV,  0.00,
     0.5f, -0.5f,  0.5f,        0.0f,  0.0f,  1.0f,     maxUV,  0.00,
    -0.5f,  0.5f,  0.5f,        0.0f,  0.0f,  1.0f,      0.00, maxUV,
    -0.5f, -0.5f,  0.5f,        0.0f,  0.0f,  1.0f,      0.00,  0.00,
    
     0.5f, -0.5f, -0.5f,        0.0f,  0.0f, -1.0f,     maxUV,  0.00,
    -0.5f, -0.5f, -0.5f,        0.0f,  0.0f, -1.0f,      0.00,  0.00,
     0.5f,  0.5f, -0.5f,        0.0f,  0.0f, -1.0f,     maxUV, maxUV,
     0.5f,  0.5f, -0.5f,        0.0f,  0.0f, -1.0f,     maxUV, maxUV,
    -0.5f, -0.5f, -0.5f,        0.0f,  0.0f, -1.0f,      0.00,  0.00,
    -0.5f,  0.5f, -0.5f,        0.0f,  0.0f, -1.0f,      0.00, maxUV,
};
#else
GLfloat gCubeVertexData[216] = 
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,
    0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
    0.5f, 0.5f, -0.5f,          1.0f, 0.0f, 0.0f,
    0.5f, 0.5f, 0.5f,         1.0f, 0.0f, 0.0f,
    
    0.5f, 0.5f, -0.5f,         0.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 1.0f, 0.0f,
    
    -0.5f, 0.5f, -0.5f,        -1.0f, 0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        -1.0f, 0.0f, 0.0f,
    
    -0.5f, -0.5f, -0.5f,       0.0f, -1.0f, 0.0f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,
    0.5f, -0.5f, 0.5f,         0.0f, -1.0f, 0.0f,
    
    0.5f, 0.5f, 0.5f,          0.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, 0.0f, 1.0f,
    
    0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 0.0f, -1.0f
};
#endif



@interface GameViewController () {
    GLuint _program;
    
    GLKMatrix4 _modelViewProjectionMatrix;
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  GLKMatrix3 _normalMatrix;
    float _rotation;
    
    GLuint _vertexArray;
    GLuint _vertexBuffer;
}
@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

- (void)setupGL;
- (void)tearDownGL;

- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
}

- (void)dealloc
{    
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    [self loadShaders];
    
    self.effect = [[GLKBaseEffect alloc] init];
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(1.0f, 0.4f, 0.4f, 1.0f);
    
    glEnable(GL_DEPTH_TEST);
    
    
    
    
    
    glGenVertexArraysOES(1, &_vertexArray);
    glBindVertexArrayOES(_vertexArray);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData), gCubeVertexData, GL_STATIC_DRAW);
    
#if ADD_CHECKERBOARD_TEXTURE
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 4 /*bytes/float*/ * (3+3+2) /*xyzxyzUV*/, BUFFER_OFFSET(0));
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  glEnableVertexAttribArray(GLKVertexAttribNormal);
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 4 /*bytes/float*/ * (3+3+2) /*xyzxyzUV*/, BUFFER_OFFSET(4 /*bytes/float*/ * (3) /*after xyz*/));
    
    // MOVED LOWER IN CODE    glBindVertexArrayOES(0);
    
    // based on https://open.gl/textures
    GLuint mytex;
    // This line was defective. Replaced by next one -  glGenTextures(GLKVertexAttribTexCoord0, &mytex);
    glGenTextures(ATTRIB_TEXTURE, &mytex);
    glBindTexture(GL_TEXTURE_2D, mytex);

    
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    // COULD ALSO WORK -        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
    // COULD ALSO WORK -        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
    
    
    
    // COULD ALSO WORK -        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
    // COULD ALSO WORK -        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    // COULD ALSO WORK -        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    
    
    // COULD ALSO WORK -        glPixelStorei(GL_UNPACK_ALIGNMENT, 1);

    typedef enum {
        TEXTURE_COLOR_CHECKERBOARD_2x2pix__FLOAT__K,
        TEXTURE_BLACK_WHITE_CHECKERBOARD_2x2pix__FLOAT__K,
        TEXTURE_BLACK_WHITE_CHECKERBOARD_2x2pix__BYTES__K,
        TEXTURE_001_4x4pix__K,
        TEXTURE_002_4x4pix__K,
        TEXTURE_FRACTAL_64x64pix__BYTES__K,
        TEXTURE_BW_STRIPES_64x64pix__BYTES__K,
        TEXTURE_TEST_16x16pix__BYTES__K,
        TEXTURE_ENUM_SIZE__K
    } TEXTURE_ENUM;
    
    TEXTURE_ENUM textureToUse = TEXTURE_FRACTAL_64x64pix__BYTES__K;
    
    switch (textureToUse) {
        case TEXTURE_COLOR_CHECKERBOARD_2x2pix__FLOAT__K:
        {
            //    Color checkerboard
            float TEXTURE_COLOR_CHECKERBOARD_2x2pix_Array[] = {
                1.0f, 0.0f, 0.0f,   0.0f, 0.5f, 0.0f,
                0.0f, 0.0f, 0.5f,   0.0f, 0.0f, 0.0f
            };
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 2, 2, 0, GL_RGB, GL_FLOAT, TEXTURE_COLOR_CHECKERBOARD_2x2pix_Array);
            break;
        }
        case TEXTURE_BLACK_WHITE_CHECKERBOARD_2x2pix__FLOAT__K:
        {
            //    Black/white checkerboard
            float TEXTURE_BLACK_WHITE_CHECKERBOARD_2x2pix_Array[] = {
                1.0f, 1.0f, 1.0f,   0.0f, 0.0f, 0.0f,
                0.0f, 0.0f, 0.0f,   1.0f, 1.0f, 1.0f
            };
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 2, 2, 0, GL_RGB, GL_FLOAT, TEXTURE_BLACK_WHITE_CHECKERBOARD_2x2pix_Array);
            break;
        }
        case TEXTURE_BLACK_WHITE_CHECKERBOARD_2x2pix__BYTES__K:
        {
            //    Black/white checkerboard
            GLbyte pixelsBytes[] = {
                255, 255, 255,     0,   0,   0,
                0,   0,   0,   255, 255, 255
            };
            
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 2, 2, 0, GL_RGB, GL_UNSIGNED_BYTE, pixelsBytes);
            break;
        }
        case TEXTURE_001_4x4pix__K:
        {
            float pixels4x4[] = {
                0.2f, 0.2f, 0.0f,   0.2f, 0.4f, 0.0f,   0.2f, 0.6f, 0.0f,   0.2f, 0.6f, 0.0f,
                0.4f, 0.2f, 1.0f,   0.4f, 0.4f, 0.0f,   0.4f, 0.6f, 0.0f,   0.4f, 0.6f, 0.0f,
                0.6f, 0.2f, 0.0f,   0.6f, 0.4f, 0.0f,   0.6f, 0.6f, 0.0f,   0.6f, 0.6f, 0.0f,
                0.8f, 0.2f, 0.0f,   0.8f, 0.4f, 0.0f,   0.8f, 0.6f, 0.0f,   0.8f, 0.6f, 0.0f
            };
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 4, 4, 0, GL_RGB, GL_FLOAT, pixels4x4);
            break;
        }
        case TEXTURE_002_4x4pix__K:
        {
            float pixels4x4[] = {
                1.0f, 0.0f, 0.0f,   0.0f, 0.0f, 0.0f,   0.0f, 1.0f, 0.0f,   0.0f, 0.0f, 0.0f,
                0.0f, 0.0f, 0.0f,   0.0f, 0.0f, 1.0f,   0.0f, 0.0f, 0.0f,   0.5f, 0.5f, 0.5f,
                0.0f, 1.0f, 1.0f,   1.0f, 1.0f, 1.0f,   1.0f, 0.0f, 1.0f,   1.0f, 1.0f, 1.0f,
                1.0f, 1.0f, 1.0f,   1.0f, 1.0f, 0.0f,   1.0f, 1.0f, 1.0f,   0.5f, 0.5f, 0.5f
            };
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 4, 4, 0, GL_RGB, GL_FLOAT, pixels4x4);
            break;
        }
        case TEXTURE_FRACTAL_64x64pix__BYTES__K:
        {
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, gimp_image_fractal_64x64pix.width, gimp_image_fractal_64x64pix.height, 0, GL_RGB, GL_UNSIGNED_BYTE, gimp_image_fractal_64x64pix.pixel_data);
            break;
        }
        case TEXTURE_BW_STRIPES_64x64pix__BYTES__K:

        {
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, gimp_image_BW_LINES.width, gimp_image_BW_LINES.height, 0, GL_RGB, GL_UNSIGNED_BYTE, gimp_image_BW_LINES.pixel_data);
            break;
        }
        case TEXTURE_TEST_16x16pix__BYTES__K:

        {
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, 16, 16, 0, GL_RGB, GL_UNSIGNED_BYTE, pixel_data_test2);
            break;
        }
            

        default:
            break;
    }
    
    

    glGenerateMipmap(GL_TEXTURE_2D);
    
    NSLog(@"GLKVertexAttribPosition  = %i\n", GLKVertexAttribPosition);
    NSLog(@"GLKVertexAttribNormal    = %i\n", GLKVertexAttribNormal);
    NSLog(@"GLKVertexAttribColor     = %i\n", GLKVertexAttribColor);
    NSLog(@"GLKVertexAttribTexCoord0 = %i\n", GLKVertexAttribTexCoord0);
    NSLog(@"GLKVertexAttribTexCoord1 = %i\n", GLKVertexAttribTexCoord1);
    
    
    // This line was defective. Replaced by next one -  glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    glEnableVertexAttribArray(ATTRIB_TEXTURE);

    // This line was defective. Replaced by next one -  glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, 4 /*bytes/float*/ * (3+3+2) /*xyzxyzUV*/, BUFFER_OFFSET(4 /*bytes/float*/ * (3+3) /*after xyzxyz*/));
    glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, GL_FALSE, 4 /*bytes/float*/ * (3+3+2) /*xyzxyzUV*/, BUFFER_OFFSET(4 /*bytes/float*/ * (3+3) /*after xyzxyz*/));

    // This line was defective. Replaced by next one -  glBindAttribLocation(_program, GLKVertexAttribTexCoord0, "texCoordIn");
    glBindAttribLocation(_program, ATTRIB_TEXTURE, "texCoordIn");
    
    glBindVertexArrayOES(0);

    
#else
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(0));
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, 24, BUFFER_OFFSET(12));
    
    glBindVertexArrayOES(0);

    
#endif

}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteVertexArraysOES(1, &_vertexArray);
    
    self.effect = nil;
    
    if (_program) {
        glDeleteProgram(_program);
        _program = 0;
    }
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    float aspect = fabs(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -4.0f);
    baseModelViewMatrix = GLKMatrix4Rotate(baseModelViewMatrix, _rotation, 0.0f, 1.0f, 0.0f);
    
    // Compute the model view matrix for the object rendered with GLKit
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -1.5f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    self.effect.transform.modelviewMatrix = modelViewMatrix;
    
    // Compute the model view matrix for the object rendered with ES2
    modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 1.5f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  _normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    
    _modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    
    _rotation += self.timeSinceLastUpdate * 0.5f;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glBindVertexArrayOES(_vertexArray);
    
    // Render the object with GLKit
    [self.effect prepareToDraw];
    
    glDrawArrays(GL_TRIANGLES, 0, 36);
    
    // Render the object again with ES2
    glUseProgram(_program);
    
    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, _modelViewProjectionMatrix.m);
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, _normalMatrix.m);
    
    // if ever we need a value sweeping between 0 and 1, use sebFloatUniform
    GLfloat varValue = ((int)(_rotation * 100) % 100 ) / 100.0f;
    GLint sebasUniformLoc = glGetUniformLocation(_program, "sebFloatUniform");
    glUniform1f(sebasUniformLoc, varValue);
    
    glDrawArrays(GL_TRIANGLES, 0, 36);
}

#pragma mark -  OpenGL ES 2 shader compilation

- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    _program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(_program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(_program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(_program, GLKVertexAttribPosition, "position");
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  glBindAttribLocation(_program, GLKVertexAttribNormal, "normal");
    
    // Link program.
    if (![self linkProgram:_program]) {
        NSLog(@"Failed to link program: %d", _program);
        
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (_program) {
            glDeleteProgram(_program);
            _program = 0;
        }
        
        return NO;
    }
    
    // Get uniform locations.
    uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX] = glGetUniformLocation(_program, "modelViewProjectionMatrix");
    // NORMALS ARE NOT USED IN THIS TEST VERSION -  uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation(_program, "normalMatrix");

    
    // Release vertex and fragment shaders.
    if (vertShader) {
        glDetachShader(_program, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(_program, fragShader);
        glDeleteShader(fragShader);
    }
    
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

@end
