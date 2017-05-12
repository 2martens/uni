#include <opencv2/opencv.hpp>
#include "gauss_pyramid.h"
#include "laplacian_pyramid.h"
#include "oriented_pyramid.h"

void exercise1(cv::Mat& image);

int main(int argc, char** argv) {
  if ( argc != 2 )
  {
    printf("usage: <Image_Path>\n");
    return -1;
  }

  cv::Mat image = cv::imread(argv[1]);
  //exercise1(image);
  image.convertTo(image, CV_32F);

  gauss_pyramid gauss_pyramid1 = gauss_pyramid(image, 3.0, 5);
  laplacian_pyramid laplacian_pyramid1 = laplacian_pyramid(gauss_pyramid1, 2.0);
  oriented_pyramid oriented_pyramid1 = oriented_pyramid(laplacian_pyramid1, 8);
  oriented_pyramid1.compute_feature_maps();
  for (int i = 0; i < 8; i++) {
    cv::namedWindow("feature map" + std::to_string(i), CV_WINDOW_NORMAL);
    cv::imshow("feature map" + std::to_string(i), oriented_pyramid1.get_feature_map(i));
    cv::waitKey(0);
  }

  return 0;
}

void exercise1(cv::Mat &image) {
  std::vector<cv::Mat> gabor_filters = std::vector<cv::Mat>();
  cv::Size size = cv::Size(20, 20);
  double wavelength = 3;
  double standard_deviation = 18;
  // g_1
  gabor_filters.push_back(cv::getGaborKernel(size, standard_deviation, (4.0/8.0) * CV_PI, wavelength, 1, 0, CV_32F));
  // g_2
  gabor_filters.push_back(cv::getGaborKernel(size, standard_deviation, (3.0/8.0) * CV_PI, wavelength, 1, 0, CV_32F));
  // g_3
  gabor_filters.push_back(cv::getGaborKernel(size, standard_deviation, (2.0/8.0) * CV_PI, wavelength, 1, 0, CV_32F));
  // g_4
  gabor_filters.push_back(cv::getGaborKernel(size, standard_deviation, (1.0/8.0) * CV_PI, wavelength, 1, 0, CV_32F));
  // g_5
  gabor_filters.push_back(cv::getGaborKernel(size, standard_deviation, 0, wavelength, 1, 0, CV_32F));
  // g_6
  gabor_filters.push_back(cv::getGaborKernel(size, standard_deviation, (7.0/8.0) * CV_PI, wavelength, 1, 0, CV_32F));
  // g_7
  gabor_filters.push_back(cv::getGaborKernel(size, standard_deviation, (6.0/8.0) * CV_PI, wavelength, 1, 0, CV_32F));
  // g_8
  gabor_filters.push_back(cv::getGaborKernel(size, standard_deviation, (5.0/8.0) * CV_PI, wavelength, 1, 0, CV_32F));

  for (unsigned long i = 0; i < 8; i++) {
    cv::namedWindow("g_" + std::to_string(i + 1), CV_WINDOW_NORMAL);
    cv::imshow("g_" + std::to_string(i + 1), gabor_filters.at(i));
    cv::waitKey(0);
  }

  // read input image
  image.convertTo(image, CV_32F);

  for (unsigned long i = 0; i < 8; i++) {
    cv::Mat filtered_image;
    cv::filter2D(image, filtered_image, -1, gabor_filters.at(i), cv::Point(-1, -1), 0, cv::BORDER_CONSTANT);
    cv::namedWindow("filtered_" + std::to_string(i + 1), CV_WINDOW_NORMAL);
    cv::imshow("filtered_" + std::to_string(i + 1), filtered_image);
    cv::waitKey(0);
  }
}
