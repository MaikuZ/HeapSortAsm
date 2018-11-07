#include <iostream>
#include <ctime>

constexpr long rand_max = 1 << 30;

long get_random_integer() {
    long integer = rand() % rand_max;
    if (rand() % 2)
	integer *= -1;
    return integer;
}

int main()
{
    srand(time(0));
    int n;
    std::cin >> n;
    std::cout << n << std::endl;
    for (int i = 0;i < n;i++)
	std::cout << get_random_integer() << " ";
    return 0;
}
