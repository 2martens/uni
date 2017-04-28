#ifndef SHEET3_GAUSS_PYRAMID_H
#define SHEET3_GAUSS_PYRAMID_H

#include <opencv2/opencv.hpp>

class gauss_pyramid
{
private:
    std::vector<cv::Mat> _layers;
public:
    gauss_pyramid();
    gauss_pyramid(cv::Mat img, int number_of_layers);
    cv::Mat get(int layer);
};


#endif //SHEET3_GAUSS_PYRAMID_H
