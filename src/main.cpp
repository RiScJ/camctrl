// Outcomment during non-BCM development
// START BLOCK

#include "gpio_utils.h"
#include "test_gpio.hpp"
#include "test_gpio_utils.hpp"

// END BLOCK

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "fileutils.h"
#include "timelapse_utils.h"
#include "rsync_utils.h"
#include "camera_utils.h"

#include <unistd.h>
#include <iostream>

void fuse(void) {
	std::string cmd = "echo \"startx camctrl\" >> /etc/rc.local";
	system(cmd.c_str());
};

int confirm_fuse(void) {
	std::string in = "";
	for (;;) {
		std::cout << "You are attempting to fuse autostart. Are you sure? [y/N]" << std::endl;
		std::cin >> in;
		if (in == "" || in == "n" || in == "N") {
			std::cout << "Autostart behavior unchanged." << std::endl;
			return 0;
		} else if (in == "y" || in == "Y") {
			std::cout << "Fusing autostart... ";
			fuse();
			std::cout << "done.\n\nThe device will now boot into camctrl." << std::endl;
			return 0;
		} else {
			std::cout << "Invalid option." << std::endl;
		}
	}
};

int test(int argc, char* argv[]) {
	TEST_GPIOUtils(argc, argv);
	return 0;
};

Q_DECL_EXPORT int main(int argc, char *argv[])
{
	int opt;
	bool flag_test = false;
	bool flag_cli_gpio = false;
	bool flag_fuse = false;

	opterr = 0;

	while ((opt = getopt(argc, argv, "tGf")) != -1) {
		switch ( opt ) {
		case 't': {
			flag_test = true;
			break;
		}
		case 'G': {
			flag_cli_gpio = true;
			break;
		}
		case 'f': {
			flag_fuse = true;
		}
		case '?': break;
		default: abort();
		}
	}

	if (flag_fuse) return confirm_fuse();

	if (flag_cli_gpio) {
		TEST_GPIO();
		exit(0);
	}

	if (flag_test){
		return test(argc, argv);
	}

	qputenv("QT_IM_MODULE", QByteArray("qtvirtualkeyboard"));

	QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

	QGuiApplication app(argc, argv);

	QQmlApplicationEngine engine;
	const QUrl url(QStringLiteral("qrc:/main.qml"));
	QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
					 &app, [url](QObject *obj, const QUrl &objUrl) {
		if (!obj && url == objUrl)
			QCoreApplication::exit(-1);
	}, Qt::QueuedConnection);

	FileUtils* fileUtils = new FileUtils();
	engine.rootContext()->setContextProperty("fileUtils", fileUtils);

	GPIOUtils* gpio = new GPIOUtils();
	engine.rootContext()->setContextProperty("gpioUtils", gpio);

	TimelapseUtils* timelapseUtils = new TimelapseUtils();
	engine.rootContext()->setContextProperty("TimelapseUtils", timelapseUtils);

	RsyncUtils* rsyncUtils = new RsyncUtils();
	engine.rootContext()->setContextProperty("rsync", rsyncUtils);

	CameraUtils* cameraUtils = new CameraUtils();
	CameraUtils::set_homeDir("/" + FileUtils::whoami().toStdString() + "/");
	engine.rootContext()->setContextProperty("cam", cameraUtils);

	GPIOUtils::start();

	engine.load(url);

	return app.exec();
};
