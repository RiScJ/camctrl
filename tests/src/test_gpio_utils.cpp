#include "test_gpio_utils.hpp"

#include <chrono>

using namespace std;
using namespace camctrl_err;

TEST_GPIOUtils::TEST_GPIOUtils(int argc, char* argv[]) {
	GPIO_ERROR err;

	cout << "[         ] \t\t Mapping GPIO memory address space... ";
	auto start = chrono::steady_clock::now();
	err = (GPIO_ERROR)GPIOUtils::map_peripheral();
	auto end = chrono::steady_clock::now();
	auto diff = end - start;
	cout << "\r" << print_errorlevel(err) << "\t" \
		 << chrono::duration_cast<chrono::microseconds>(diff).count() \
		 << " us\t Mapping GPIO memory address space... done.\n\n" \
		 << flush;

	for (int pin = 0; pin < PINC; pin++) {
		GPIOUtils::make_input(pin);


		cout << "[         ] \t\t Checking GPIO pin " << pin << " PUR... ";
		start = chrono::steady_clock::now();

		GPIOUtils::pull_up(pin);
		if (!GPIOUtils::read(pin)) err = GPIO_ERROR::E_PUD_PUR;

		end = chrono::steady_clock::now();
		diff = end - start;
		cout << "\r" << print_errorlevel(err) << "\t" \
			 << chrono::duration_cast<chrono::microseconds>(diff).count() \
			 << " us\t Checking GPIO pin " << pin << " PUR... done.\n\n" \
			 << flush;



		cout << "[         ] \t\t Checking GPIO pin " << pin << " PDR... ";
		start = chrono::steady_clock::now();

		GPIOUtils::pull_down(pin);
		if (GPIOUtils::read(pin)) err = GPIO_ERROR::E_PUD_PDR;

		end = chrono::steady_clock::now();
		diff = end - start;
		cout << "\r" << print_errorlevel(err) << "\t" \
			 << chrono::duration_cast<chrono::microseconds>(diff).count() \
			 << " us\t Checking GPIO pin " << pin << " PDR... done.\n\n" \
			 << flush;
	};

	GPIOUtils::unmap_peripheral();
};












