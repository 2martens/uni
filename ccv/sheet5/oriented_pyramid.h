#ifndef SHEET5_ORIENTED_PYRAMID_H
#define SHEET5_ORIENTED_PYRAMID_H

#include <opencv2/opencv.hpp>
#include "laplacian_pyramid.h"

class oriented_pyramid {
private:
    std::vector<std::vector<cv::Mat>> _orientation_maps;
    std::vector<cv::Mat> _gabor_filters;
    std::vector<cv::Mat> _feature_maps;

    /**
     * Initializes the Gabor filters.
     * @param num_orientations the number of orientations to use
     */
    void initialize_gabor_filters(float num_orientations);
public:
    /**
     * Initializes the oriented pyramid.
     * @param pyramid the laplacian pyramid
     * @param num_orientations the number of Gabor filters to apply
     */
    oriented_pyramid(const laplacian_pyramid& pyramid, int num_orientations);

    /**
     * Computes the feature maps.
     */
    void compute_feature_maps();

    /**
     * Returns the feature map for the nth orientation.
     *
     * compute_feature_maps must be called first.
     *
     * @param orientation the nth orientation
     * @return the feature map
     */
    cv::Mat get_feature_map(int orientation);
};


#endif //SHEET5_ORIENTED_PYRAMID_H
