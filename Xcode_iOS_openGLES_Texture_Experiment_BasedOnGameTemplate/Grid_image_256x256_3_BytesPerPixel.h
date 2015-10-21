//
//  Grid_image_256x256_3_BytesPerPixel.h
//  Xcode_iOS_openGLES_Texture_Experiment_BasedOnGameTemplate
//
//  Created by Sebastien Binet on 2015-10-21.
//  Copyright © 2015 Sebastien Binet. All rights reserved.
//

#ifndef Grid_image_256x256_3_BytesPerPixel_h
#define Grid_image_256x256_3_BytesPerPixel_h

#include <stdio.h>
/* GIMP RGB C-Source image dump (Svans titre.c) */
typedef struct {
    GLint  	 width;
    GLint  	 height;
    GLint  	 bytes_per_pixel; /* 2:RGB16, 3:RGB, 4:RGBA */
    GLbyte 	 pixel_data[64 * 64 * 3 + 1];
} gimp_image_BW_LINES_TYPE;

extern gimp_image_BW_LINES_TYPE gimp_image_BW_LINES;


typedef struct {
    GLint  	 width;
    GLint  	 height;
    GLint  	 bytes_per_pixel; /* 2:RGB16, 3:RGB, 4:RGBA */
    GLbyte 	 pixel_data[64 * 64 * 3 + 1];
} gimp_image_fractal_64x64pix_TYPE;

extern gimp_image_fractal_64x64pix_TYPE gimp_image_fractal_64x64pix;


// generated from ajax-loader.gif on http://www.digole.com/tools/PicturetoC_Hex_converter.php

extern GLbyte 	 pixel_data_test2[];


#endif /* Grid_image_256x256_3_BytesPerPixel_h */
