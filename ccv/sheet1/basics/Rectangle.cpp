//
// Created by jim on 4/4/17.
//
#include <iostream>
#include "Rectangle.h"
using namespace std;

Rectangle::Rectangle(unsigned int width, unsigned int height)
{
  this->width = width;
  this->height = height;
}

unsigned int Rectangle::area()
{
  cout << this->width * this->height << endl;
}
