#include <iostream>
#include <vector>
#include <algorithm>

int main()
{
    unsigned long n;
    std::cin >> n;
    std::vector<long> data(n);
    for (unsigned long i = 0; i < n; ++i)
    	std::cin >> data[i];

    std::sort(data.begin(), data.end());

    for (unsigned long i = 0; i < n; ++i)
	std::cout << data[i] << " ";
    std::cout << std::endl;
    return 0;
}
