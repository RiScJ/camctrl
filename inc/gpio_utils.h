#ifndef GPIO_UTILS_H
#define GPIO_UTILS_H

#include <QObject>

#define BLOCK_SIZE 		(4*1024)

class GPIOUtils : public QObject {
    Q_OBJECT

public:
    explicit GPIOUtils (QObject* parent = 0) : QObject(parent) {}
    static void setup_pin(int pin, bool pud, bool io);
    Q_INVOKABLE static void trigger_frames(int pin, bool edge);
    Q_INVOKABLE static void stop_frames(void);
    static void start(void);
    static void stop(void);
    static bool read(int pin);

private:
    static bool running;
    static void attach_interrupt(int pin, bool edge, void (*callback)(void));
    static void detach_interrupt(void);
    static void await_edge(int pin, bool edge, void (*callback)(void));
    static void make_input(int pin);
    static void make_output(int pin);
    static void pull_up(int pin);
    static void pull_down(int pin);
    static void map_peripheral(void);
    static void unmap_peripheral(void);
    static unsigned long addr_p;
    static int mem_fd;
    static void *map;
    static volatile unsigned int *addr;
};




#endif // GPIO_UTILS_H
