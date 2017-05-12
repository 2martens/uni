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

    /**
     * Returns the number of layers.
     * @return
     */
    unsigned long get_number_of_layers() const;

    /**
     * Returns the pyramid element at given layer.
     * @param layer the requested pyramid layer
     * @return pyramid layer
     */
    cv::Mat get(int layer) const;
};


#endif //SHEET5_LAPLACIAN_PYRAMID_H
