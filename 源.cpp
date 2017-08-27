#include <iostream>
using namespace std;
#pragma pack(4)
struct A
{
	char _iC1;
	long _il;
	char _iC2;
	double _id;
};
//´òÂÒË³Ğò
struct B
{
	char _iC1;
	char _iC2;
	long _il;
	double _id;
};
int main() {
	cout << sizeof(A) << endl;
	cout << sizeof(B) << endl;
	cout << "char =" << sizeof(char) << sizeof(int) << sizeof(long int) << sizeof(float) << sizeof(double) << endl;

	getchar();
	return 0;
}