#ifndef SHEET3_GAUSS_PYRAMID_H
#define SHEET3_GAUSS_PYRAMID_H

#include <opencv2/opencv.hpp>

class gauss_pyramid
{
private:
    std::vector<cv::Mat> _layers;
public:
    gauss_pyramid();
    gauss_pyramid(const cv::Mat img, float sigma, int number_of_layers);
    cv::Mat get(int layer) const;
    cv::Mat get(int layer);
    unsigned long get_number_of_layers() const;
    unsigned long get_number_of_layers();
};


#endif //SHEET3_GAUSS_PYRAMID_H
