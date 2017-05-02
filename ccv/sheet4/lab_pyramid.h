#ifndef SHEET3_LAB_PYRAMID_H
#define SHEET3_LAB_PYRAMID_H

#include <opencv2/opencv.hpp>
#include "gauss_pyramid.h"

class lab_pyramid {
private:
    cv::Mat _inputImage_lab;
    cv::Mat _inputImage_float;
    cv::Mat _imageChannels[3];
    gauss_pyramid _pyramids[3];
    static std::vector<cv::Mat> _cs_contrast_l;
    static std::vector<cv::Mat> _sc_contrast_l;
    static std::vector<cv::Mat> _cs_contrast_a;
    static std::vector<cv::Mat> _sc_contrast_a;
    static std::vector<cv::Mat> _cs_contrast_b;
    static std::vector<cv::Mat> _sc_contrast_b;
    static int _number_of_layers;
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
     * Initializes a LAB pyramid.
     *
     * @param image the image that should be used
     */
    lab_pyramid(cv::Mat image);

    /**
     * Creates the gaussian pyramids for all channels with the given number of layers each.
     *
     * @param sigma the sigma for the gaussian pyramids
     * @param number_of_layers number of layers for gaussian pyramid
     */
    void create_pyramids(float sigma, int number_of_layers);

    /**
     * Before this method can be called, pyramids have to be created via create_pyramids.
     *
     * @param channel the channel you want to get (COLOR_L, COLOR_A or COLOR_B)
     * @return the gaussian_pyramid for the given channel
     */
    gauss_pyramid get_pyramid(int channel);

    /**
     * Computes the center-surround and surround-center contrasts and stores them for later use.
     *
     * @param center the center pyramid
     * @param surround the surround pyramid
     * @param number_of_layers the number of layers used to create the two pyramids
     */
    void static compute_dog(lab_pyramid center, lab_pyramid surround, int number_of_layers);

    /**
     * Visualizes the center-surround and surround-center contrasts. They have to be computed first.
     */
    void static visualize_dog();
};


#endif //SHEET3_LAB_PYRAMID_H
