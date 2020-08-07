#include "test_gpio.hpp"
#include "camctrl_error.hpp"

using namespace std;
using namespace camctrl_err;

TEST_GPIO::TEST_GPIO(void) {

	GPIOUtils::map_peripheral();

	for (int pin = 0; pin < 20; pin++) {
		GPIOUtils::setup_pin(pin, 1, 1);
	}

	while (true) {
		for (int pin = 0; pin < 20; pin++) {
			bool state = GPIOUtils::read(pin);
			string code = state ? green : red;
			cout << code << state << reset << " ";
		}
		cout << "\r";
	}
};












