#include <iostream>
#include <vector>

extern "C" void sort(long * data, unsigned long size);

int main()
{
    unsigned long n;
    std::cin >> n;
    std::vector<long> data(n);
    for (unsigned long i = 0; i < n; ++i)
    	std::cin >> data[i];

    sort(data.data(), n);

    for (unsigned long i = 0; i < n; ++i)
	std::cout << data[i] << " ";
    std::cout << std::endl;
    return 0;
}
