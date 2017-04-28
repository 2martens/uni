#include <stdio.h>
#include <opencv2/opencv.hpp>

int main()
{
  // exercise 1
  float g[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16};
  cv::Mat M(4, 4, CV_8UC1, g);
  std::cout << M << std::endl << std::endl;
  // exercise 2
  M.at<uchar>(1, 2) = 100;
  std::cout << M << std::endl << std::endl;
  // exercise 3
  std::cout << "The elements of the matrix: ";
  for (int row = 0; row < M.rows; ++row)
  {
    for (int col = 0; col < M.cols; ++col)
    {
      if (row != 0 || col != 0)
      {
        std::cout << ",";
      }
      std::cout << " " << static_cast<int>(M.at<uchar>(row, col));
    }
  }
  std::cout << std::endl << std::endl;
  //exercise 4
  cv::Mat K(M);
  K.at<uchar>(1, 2) = 200;
  std::cout << "M: " << M << std::endl << "K: " << K << std::endl << std::endl;
  //exercise 5
  cv::Mat B = cv::Mat(400, 400, CV_8UC3, cv::Scalar(255, 0, 0));
  cv::namedWindow("Display Image", cv::WINDOW_FULLSCREEN);
  cv::imshow("Display Image", B);
  cv::waitKey(0);
  return 0;
}

