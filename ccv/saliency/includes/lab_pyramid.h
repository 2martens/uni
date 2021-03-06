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
    // contrast maps
    static std::vector<cv::Mat> _cs_contrast_l;
    static std::vector<cv::Mat> _sc_contrast_l;
    static std::vector<cv::Mat> _cs_contrast_a;
    static std::vector<cv::Mat> _sc_contrast_a;
    static std::vector<cv::Mat> _cs_contrast_b;
    static std::vector<cv::Mat> _sc_contrast_b;
    // feature maps
    static std::vector<cv::Mat> _F_l;
    static std::vector<cv::Mat> _F_a;
    static std::vector<cv::Mat> _F_b;
    static cv::Mat _cs_F_l;
    static cv::Mat _sc_F_l;
    static cv::Mat _cs_F_a;
    static cv::Mat _cs_F_b;
    static cv::Mat _sc_F_a;
    static cv::Mat _sc_F_b;
    // conspicuity maps
    static cv::Mat _C_l;
    static cv::Mat _C_a;
    static cv::Mat _C_b;
    // number of layers
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
     * Before this method can be called, pyramids have to be created via create_pyramids.
     *
     * @param channel the channel you want to get (COLOR_L, COLOR_A or COLOR_B)
     * @return the gaussian_pyramid for the given channel
     */
    gauss_pyramid get_pyramid(int channel) const;

    /**
     * Visualizes the gaussian pyramids.
     *
     * @param center center pyramid
     * @param surround surround pyramid
     */
    void static visualize_gaussian_pyrs(const lab_pyramid center, const lab_pyramid surround);

    /**
     * Computes the center-surround and surround-center contrasts and stores them for later use.
     *
     * @param center the center pyramid
     * @param surround the surround pyramid
     * @param number_of_layers the number of layers used to create the two pyramids
     */
    void static compute_dog(const lab_pyramid center, const lab_pyramid surround, int number_of_layers);

    /**
     * Visualizes the center-surround and surround-center contrasts. They have to be computed first.
     */
    void static visualize_dog();

    /**
     * Takes the scale images, adds them up and returns the result.
     *
     * @param scale_images the scale images
     * @return the sum of the scale images
     */
    cv::Mat static across_scale_addition(const std::vector<cv::Mat> &scale_images);

    /**
     * Computes the feature maps.
     * Has to be called after compute_dog.
     */
    void static compute_feature_maps();

    /**
     * Computes the conspicuity maps.
     * Has to be called after compute_feature_maps.
     */
    void static compute_conspicuity_maps();

    /**
     * Before this method can be called, the conspicuity maps must be computed via compute_conspicuity_maps.
     *
     * @param channel the channel you want to get (COLOR_L, COLOR_A, COLOR_B)
     * @return the conspicuity map for the given channel
     */
    cv::Mat static get_conspicuity_map(int channel);

    /**
     * Visualizes the feature maps.
     * Has to be called after compute_feature_maps.
     */
    void static visualize_feature_maps();
};


#endif //SHEET3_LAB_PYRAMID_H
