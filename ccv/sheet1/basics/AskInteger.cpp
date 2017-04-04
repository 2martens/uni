//
// Created by jim on 4/4/17.
//
#include <iostream>
using namespace std;

int main()
{
  int input;
  cout << "Bitte geben Sie eine Zahl ein." << endl;
  cin >> input;
  if (input > 9)
  {
    cout << input << " ist größer gleich 10." << endl;
  }
  else if (input >= 0)
  {
    cout << input << " liegt zwischen einschließlich 0 und 9." << endl;
  }
  else
  {
    cout << input << " ist negativ." << endl;
  }
  return 0;
}
