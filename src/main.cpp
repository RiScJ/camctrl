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

Q_DECL_EXPORT int main(int argc, char *argv[])
{
	int opt;
	bool flag_test = false;
	bool flag_gpio = false;

	opterr = 0;

	while ((opt = getopt(argc, argv, "tG")) != -1) {
		switch ( opt ) {
		case 't':
			flag_test = true;
			break;
		case 'G':
			flag_gpio = true;
			break;
		case '?':
			break;
		default: {
			abort();
		}
		}
	}

	if (flag_gpio) {
		TEST_GPIO();
		exit(0);
	}

	if (flag_test){
		TEST_GPIOUtils(argc, argv);
		exit(0);
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
	engine.rootContext()->setContextProperty("cam", cameraUtils);

	GPIOUtils::start();

	engine.load(url);

	return app.exec();
}
