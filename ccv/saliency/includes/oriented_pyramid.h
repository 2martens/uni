#ifndef SHEET5_ORIENTED_PYRAMID_H
#define SHEET5_ORIENTED_PYRAMID_H

#include <opencv2/opencv.hpp>
#include "laplacian_pyramid.h"

class oriented_pyramid {
private:
    std::vector<std::vector<cv::Mat>> _orientation_maps;
    std::vector<cv::Mat> _gabor_filters;
    std::vector<cv::Mat> _feature_maps;
    cv::Mat _C;

    /**
     * Initializes the Gabor filters.
     * @param num_orientations the number of orientations to use
     * @param size the size of the Gabor filter
     * @param wavelength the wavelength
     * @param standard_deviation the standard deviation
     */
    void initialize_gabor_filters(float num_orientations, int size, double wavelength, double standard_deviation);
public:
    /**
     * Initializes the oriented pyramid.
     * @param pyramid the laplacian pyramid
     * @param num_orientations the number of Gabor filters to apply
     * @param size the size of the Gabor filter
     * @param wavelength the wavelength
     * @param standard_deviation the standard deviation
     */
    oriented_pyramid(const laplacian_pyramid& pyramid, int num_orientations, int size,
                     double wavelength, double standard_deviation);

    /**
     * Computes the feature maps.
     */
    void compute_feature_maps();

    /**
     * Computes the conspicuity map.
     */
    void compute_conspicuity_map();

    /**
     * Returns the conspicuity map.
     * Has to be called after compute_conspicuity_map.
     *
     * @return conspicuity map
     */
    cv::Mat get_conspicuity_map();

    /**
     * Returns the feature map for the nth orientation.
     *
     * compute_feature_maps must be called first.
     *
     * @param orientation the nth orientation
     * @return the feature map
     */
    cv::Mat get_feature_map(unsigned long orientation);
};


#endif //SHEET5_ORIENTED_PYRAMID_H
