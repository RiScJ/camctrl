#include "test_gpio_utils.hpp"
#include "gpio_utils.h"

#include <iostream>
#include <chrono>

using namespace std;

TEST_GPIOUtils::TEST_GPIOUtils(int argc, char* argv[]) {
	cout << "[\t\t] \t\t Mapping GPIO memory address space... ";
	auto start = chrono::steady_clock::now();
	GPIOUtils::map_peripheral();
	auto end = chrono::steady_clock::now();
	auto diff = end - start;
	cout << "\r[\tOK\t] \t" \
		 << chrono::duration_cast<chrono::milliseconds>(diff).count() \
		 << " ms\t Mapping GPIO memory address space... done.\n\n" \
		 << flush;

	string msg = "OK";
	for (int pin = 0; pin < PINC; pin++) {
		GPIOUtils::make_input(pin);


		cout << "[\t\t] \t\t Checking GPIO pin" << pin << " PUR... ";
		start = chrono::steady_clock::now();

		GPIOUtils::pull_up(pin);
		if (!GPIOUtils::read(pin)) msg = "BAD_PUR";

		end = chrono::steady_clock::now();
		diff = end - start;
		cout << "\r[\t" << msg << "\t] \t" \
			 << chrono::duration_cast<chrono::milliseconds>(diff).count() \
			 << " ms\t Checking GPIO pin " << pin << " PUR... done.\n" \
			 << flush;
		msg = "OK";



		cout << "[\t\t] \t\t Checking GPIO pin" << pin << " PDR... ";
		start = chrono::steady_clock::now();

		GPIOUtils::pull_down(pin);
		if (GPIOUtils::read(pin)) msg = "BAD_PDR";

		end = chrono::steady_clock::now();
		diff = end - start;
		cout << "\r[\t" << msg << "\t] \t" \
			 << chrono::duration_cast<chrono::milliseconds>(diff).count() \
			 << " ms\t Checking GPIO pin " << pin << " PDR... done.\n\n" \
			 << flush;
		msg = "OK";
	};

	GPIOUtils::unmap_peripheral();
};












