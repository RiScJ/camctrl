#include <QDebug>
#include <chrono>
#include <thread>

#include "gpio.h"

//#include <bcm_host.h>


void GPIO::setup_pin(int pin, bool pud, bool io) {
    io ? make_input(pin) : make_output(pin);
    pud ? pull_up(pin) : pull_down(pin);
};


void GPIO::attach_interrupt(int pin, bool edge, void (*callback)(void)) {
    running = true;
    std::thread *thd = new std::thread(await_edge, pin, edge, callback);
    thd->detach();
};


void GPIO::detach_interrupt(void) {
    running = false;
};


void GPIO::start(void) {
    map_peripheral();
};


void GPIO::stop(void) {
    unmap_peripheral();
};



// Private

bool GPIO::running = false;
int GPIO::mem_fd;
void* GPIO::map;
volatile unsigned int* GPIO::addr;
unsigned long GPIO::addr_p = 0x7e215000; //bcm_host_get_peripheral_address();


void GPIO::make_input(int pin) {
    *(addr + ((pin)/10)) &= ~(7<<(((pin)%10)*3));
};


void GPIO::make_output(int pin) {
    make_input(pin);
    *(addr + ((pin)/10)) |=  (1<<(((pin)%10)*3));
};


void GPIO::pull_up(int pin) {

};


void GPIO::pull_down(int pin) {

};


bool GPIO::read(int pin) {
    return *(addr + 13 + (pin/32)) &= (1 << pin%32);
};


void GPIO::await_edge(int pin, bool edge, void (*callback)(void)) {
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


void GPIO::map_peripheral(void)
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


void GPIO::unmap_peripheral(void) {
    munmap(map, BLOCK_SIZE);
    close(mem_fd);
};
