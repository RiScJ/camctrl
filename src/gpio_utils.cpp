#include <QDebug>
#include <chrono>
#include <thread>

#include <stdio.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include "gpio_utils.h"
#include "camera_utils.h"

#include <bcm_host.h>


void GPIOUtils::setup_pin(int pin, bool pud, bool io) {
	io ? make_input(pin) : make_output(pin);
	pud ? pull_up(pin) : pull_down(pin);
};


void GPIOUtils::trigger_frames(int pin, bool edge) {
	attach_interrupt(pin, edge, *CameraUtils::capture_frame_EXT);
};


void GPIOUtils::stop_frames(void) {
	detach_interrupt();
};


void GPIOUtils::attach_interrupt(int pin, bool edge, void (*callback)(void)) {
	setup_pin(pin, 0, 1);
	running = true;
	std::thread *thd = new std::thread(await_edge, pin, edge, callback);
	thd->detach();
};


void GPIOUtils::detach_interrupt(void) {
	running = false;
};


void GPIOUtils::start(void) {
	map_peripheral();
};


void GPIOUtils::stop(void) {
	unmap_peripheral();
};



// Private

bool GPIOUtils::running = false;
int GPIOUtils::mem_fd;
void* GPIOUtils::map;
volatile unsigned int* GPIOUtils::addr;
unsigned long GPIOUtils::addr_p = bcm_host_get_peripheral_address() + 0x200000;


void GPIOUtils::make_input(int pin) {
	int offset = pin / 10;
	int shift = pin % 10;
	shift *= 3;

	*(addr + GPFSEL + offset) &= ~(7UL << shift);	// -> 000
};


void GPIOUtils::make_output(int pin) {
	int offset = pin / 10;
	int shift = pin % 10;
	shift *= 3;

	make_input(pin);
	*(addr + GPFSEL + offset) |=  (1UL << shift);	// -> 001
};


void GPIOUtils::pull_up(int pin) {
	int offset = pin / 16; // 16 pins per register
	int shift = pin % 16;
	shift *= 2; // 2 bits per pin

	pull_float(pin);
	*(addr + GPPUD + offset) |= 1UL << shift;		// -> 01
};


void GPIOUtils::pull_float(int pin) {
	int offset = pin / 16; // 16 pins per register
	int shift = pin % 16;
	shift *= 2; // 2 bits per pin

	*(addr + GPPUD + offset) &= ~(3UL << shift);	// -> 00
};


void GPIOUtils::pull_down(int pin) {
	int offset = pin / 16;
	int shift = pin % 16;
	shift *= 2;

	pull_float(pin);
	*(addr + GPPUD + offset) |= 2UL << shift;		// -> 10
};


void GPIOUtils::set(int pin) {
	int offset = pin / 32;
	int shift = pin % 32;

	*(addr + GPSET + offset) |= 1UL << shift;
};


void GPIOUtils::clear(int pin) {
	int offset = pin / 32;
	int shift = pin % 32;

	*(addr + GPCLR + offset) |= 1UL << shift;
};


bool GPIOUtils::read(int pin) {
	int offset = pin / 32;
	int shift = pin % 32;
	return *(addr + GPLEV + offset) & (1UL << shift); // &= --> &
};


void GPIOUtils::write(int pin) {

};


void GPIOUtils::await_edge(int pin, bool edge, void (*callback)(void)) {
	bool prev = 0;
	bool curr = 0;
	while (running) {
		curr = read(pin);
		if (prev != curr) {
			if (prev ^ edge) callback();
			prev ^= 1;
		}
	}
}


int GPIOUtils::map_peripheral(void)
{
	if ((mem_fd = open("/dev/mem", O_RDWR|O_SYNC) ) < 0) {
		return 0x4011;
	}

	map = mmap(
			  NULL,
			  BLOCK_SIZE,
			  PROT_READ|PROT_WRITE,
			  MAP_SHARED,
			  mem_fd,      // File descriptor to physical memory virtual file '/dev/mem'
			  addr_p       // Address in physical map that we want this memory block to expose
			  );

	if (map == MAP_FAILED) {
		return 0x3012;
	}

	addr = (volatile unsigned int *)map;
	return 0;
};


int GPIOUtils::unmap_peripheral(void) {
	munmap(map, BLOCK_SIZE);
	close(mem_fd);
	return 0;
};
