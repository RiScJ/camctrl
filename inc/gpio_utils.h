#ifndef GPIO_UTILS_H
#define GPIO_UTILS_H

#include <QObject>

#define BLOCK_SIZE 		(4*1024)

// //////////////////// // //// // //////////////////////////////////// //
enum Bank {			    // Qty.	// Description							//
// //////////////////// // //// // //////////////////////////////////// //
	GPFSEL = 0x00/4,	// 6	// function select						//
	GPSET  = 0x1C/4,	// 2	// pin output set						//
	GPCLR  = 0x28/4,	// 2	// pin output clear						//
	GPLEV  = 0x34/4,	// 2	// pin level							//
	GPEDS  = 0x40/4,	// 2	// pin event detect status				//
	GPREN  = 0x4C/4,	// 2	// pin rising edge detect enable		//
	GPFEN  = 0x58/4,	// 2	// pin falling edge detect enable		//
	GPHEN  = 0x64/4,	// 2	// pin high detect enable				//
	GPLEN  = 0x70/4,	// 2	// pin low detect enable				//
	GPAREN = 0x7C/4,	// 2	// pin async rising edge detect			//
	GPAFEN = 0x88/4,	// 2	// pin async falling edge detect		//
	GPPUD  = 0xE4/4		// 4	// pull up/down							//
// //////////////////// // //// // //////////////////////////////////// //
};

class TEST_GPIOUtils;
class TEST_GPIO;

class GPIOUtils : public QObject {
	Q_OBJECT

public:
	explicit GPIOUtils (QObject* parent = 0) : QObject(parent) {}
	static void setup_pin(int pin, bool pud, bool io);
	Q_INVOKABLE static void trigger_frames(int pin, bool edge);
	Q_INVOKABLE static void stop_frames(void);
	Q_INVOKABLE static void trigger_images(int pin, bool edge);
	Q_INVOKABLE static void stop_images(void);
	Q_INVOKABLE static void trigger_video(int pin);
	Q_INVOKABLE static void stop_video(void);
	static void start(void);
	static void stop(void);
	static bool read(int pin);
	static void write(int pin);

private:
	friend class TEST_GPIOUtils;
	friend class TEST_GPIO;
	static bool running;

	static void attach_interrupt(int pin, bool edge, void (*callback)(void));
	static void attach_interrupt(int pin, void (*callback)(void));
	static void detach_interrupt(void);
	static void await_edge(const int pin, const bool edge, void (*callback)(void));


	static void make_input(int pin);
	static void make_output(int pin);

	static void pull_up(int pin);
	static void pull_down(int pin);
	static void pull_float(int pin);

	static void clear(int pin);
	static void set(int pin);


	static int map_peripheral(void);
	static int unmap_peripheral(void);
	static unsigned long addr_p;
	static int mem_fd;
	static void *map;
	static volatile unsigned int *addr;

	static bool check(const std::vector<bool> vec);
};




#endif // GPIO_UTILS_H
