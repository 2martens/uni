//
// Created by jim on 4/7/17.
//
#include <opencv2/opencv.hpp>

using namespace cv;

int main( int argc, char** argv )
{
  char* imageName = argv[1];

  Mat image;
  image = imread( imageName, 1 );

  if( argc != 2 || !image.data )
  {
    printf( " No image data \n " );
    return -1;
  }

  Mat gray_image;
  cvtColor( image, gray_image, CV_BGR2GRAY );

  imwrite( "Gray_Image.jpg", gray_image );

  namedWindow( imageName, CV_WINDOW_NORMAL );
  namedWindow( "Gray image", CV_WINDOW_NORMAL);

  imshow( imageName, image );
  imshow( "Gray image", gray_image );

  waitKey(0);

  return 0;
}
