#ifndef GPIO_H
#define GPIO_H

#include <QObject>
#include <thread>

#include <stdio.h>

#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include <unistd.h>

#define BLOCK_SIZE 		(4*1024)

class GPIO : public QObject {
    Q_OBJECT

public:
    explicit GPIO (QObject* parent = 0) : QObject(parent) {}
    static void setup_pin(int pin, bool pud, bool io);
    static void attach_interrupt(int pin, bool edge, void (*callback)(void));
    static void detach_interrupt(void);
    static void start(void);
    static void stop(void);

private:
    static bool running;
    static void await_edge(int pin, bool edge, void (*callback)(void));
    static bool read(int pin);
    static void make_input(int pin);
    static void make_output(int pin);
    static void pull_up(int pin);
    static void pull_down(int pin);
    static void map_peripheral(void);
    static void unmap_peripheral(void);
    static const unsigned long addr_p = 0x7e215000;
    static int mem_fd;
    static void *map;
    static volatile unsigned int *addr;
};




#endif // GPIO_H
