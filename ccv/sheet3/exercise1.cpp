#include <opencv2/opencv.hpp>

int main(int argc, char** argv ) {
// exercise 1

// matrix M
  float m[] = {1.0, 1.0, 1.0, 1.0, 2.0, 1.0, 1.0, 1.0, 1.0};
  cv::Mat M(3, 3, CV_32FC1, m);
// gaussian filter kernel
  float g[] = {1, 2, 1, 2, 4, 2, 1, 2, 1};
  cv::Mat G(3, 3, CV_32FC1, g);
  G = G * 0.0625;
// output G
  std::cout << G << std::endl << std::endl;

// convolve 1.
  cv::Mat M_1;
  cv::filter2D(M, M_1, -1, G, cv::Point(-1, -1), 0, cv::BORDER_CONSTANT);
// output M_1
  std::cout << M_1 << std::endl << std::endl;

// convolve 2.
  float g_1[] = {1, 2, 1};
  cv::Mat G_1(1, 3, CV_32FC1, g_1);
  G_1 = G_1 * 0.25;
  float g_2[] = {1, 2, 1};
  cv::Mat G_2(3, 1, CV_32FC1, g_2);
  G_2 = G_2 * 0.25;
// output G_1, G_2
  std::cout << G_1 << std::endl << std::endl;
  std::cout << G_2 << std::endl << std::endl;

  cv::Mat M_2;
  cv::Mat M_3;
  cv::filter2D(M, M_2, -1, G_1, cv::Point(-1, -1), 0, cv::BORDER_CONSTANT);
  cv::filter2D(M_2, M_3, -1, G_2, cv::Point(-1, -1), 0, cv::BORDER_CONSTANT);
// output M_3
  std::cout << M_3 << std::endl << std::endl;

// convolve 3.
  cv::Mat M_4;
  cv::GaussianBlur(M, M_4, cv::Size(3, 3), 0, 0, cv::BORDER_CONSTANT);
  std::cout << M_4 << std::endl << std::endl;
}
