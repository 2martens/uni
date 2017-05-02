#ifndef SHEET3_LAB_PYRAMID_H
#define SHEET3_LAB_PYRAMID_H

#include <opencv2/opencv.hpp>
#include "gauss_pyramid.h"

class lab_pyramid {
private:
    cv::Mat _inputImage_lab;
    cv::Mat _imageChannels[3];
    gauss_pyramid _pyramids[3];
public:
    const static int COLOR_L = 0;
    const static int COLOR_A = 1;
    const static int COLOR_B = 2;

    /**
     * Initializes a LAB pyramid.
     *
     * @param image_filename the filename of the image that should be used
     */
    lab_pyramid(cv::String image_filename);

    /**
     * Creates the gaussian pyramids for all channels with the given number of layers each.
     *
     * @param number_of_layers number of layers for gaussian pyramid
     */
    void create_pyramids(int number_of_layers);

    /**
     * Before this method can be called, pyramids have to be created via create_pyramids.
     *
     * @param channel the channel you want to get (COLOR_L, COLOR_A or COLOR_B)
     * @return the gaussian_pyramid for the given channel
     */
    gauss_pyramid get_pyramid(int channel);
};


#endif //SHEET3_LAB_PYRAMID_H
