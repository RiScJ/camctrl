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
    *(addr + ((pin)/10)) &= ~(7<<(((pin)%10)*3));
};


void GPIOUtils::make_output(int pin) {
    make_input(pin);
    *(addr + ((pin)/10)) |=  (1<<(((pin)%10)*3));
};


void GPIOUtils::pull_up(int pin) {
    *(addr + 37 + (pin/16)*2) |= 1;
};


void GPIOUtils::pull_down(int pin) {

};


bool GPIOUtils::read(int pin) {
    return *(addr + 13 + (pin/32)) &= (1 << pin%32);
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


void GPIOUtils::map_peripheral(void)
{
   // Open /dev/mem
   if ((mem_fd = open("/dev/mem", O_RDWR|O_SYNC) ) < 0) {
      printf("Failed to open /dev/mem, try checking permissions.\n");
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
        perror("mmap");
   }

   addr = (volatile unsigned int *)map;
};


void GPIOUtils::unmap_peripheral(void) {
    munmap(map, BLOCK_SIZE);
    close(mem_fd);
};
