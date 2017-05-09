#ifndef SHEET5_LAPLACIAN_PYRAMID_H
#define SHEET5_LAPLACIAN_PYRAMID_H

#include <opencv2/opencv.hpp>
#include "gauss_pyramid.h

class laplacian_pyramid {
private:
    std::vector<cv::Mat> _layers;
public:
    /**
     * Initializes the laplacian pyramid.
     * @param pyramid the gaussian pyramid
     * @param sigma the blur factor
     */
    laplacian_pyramid(const gauss_pyramid& pyramid, float sigma);
};


#endif //SHEET5_LAPLACIAN_PYRAMID_H
