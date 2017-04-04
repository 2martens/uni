//
// Created by jim on 4/4/17.
//
#include <iostream>
using namespace std;

class Rectangle
{
private:
    unsigned int width;
    unsigned int height;

public:
    Rectangle(unsigned int width, unsigned int height)
    {
      this->width = width;
      this->height = height;
    }

    unsigned int area()
    {
      return this->height * this->width;
    }
};

int main()
{
  Rectangle* rec = new Rectangle(10, 20);
  cout << rec->area() << endl;
}
