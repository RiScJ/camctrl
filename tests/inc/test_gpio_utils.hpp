#ifndef TEST_GPIO_UTILS_HPP
#define TEST_GPIO_UTILS_HPP

enum ERROR_GPIOUtils {
	MEM
};

class TEST_GPIOUtils {
public:
	explicit TEST_GPIOUtils(int argc, char* argv[]);
private:
	static const int PINC = 58;

};

#endif // TEST_GPIO_UTILS_HPP
