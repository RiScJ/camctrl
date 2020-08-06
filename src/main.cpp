#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "fileutils.h"
#include "gpio_utils.h"
#include "timelapse_utils.h"
#include "rsync_utils.h"
#include "camera_utils.h"

#include "test_gpio_utils.hpp"

#include <unistd.h>

Q_DECL_EXPORT int main(int argc, char *argv[])
{
	int opt;
	bool flag_test = false;

	opterr = 0;

	while ((opt = getopt(argc, argv, "t")) != -1) {
		switch ( opt ) {
		case 't':
			flag_test = true;
			break;
		case '?':
			break;
		default: {
			abort();
		}
		}
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

	CameraUtils::start("IMG");

	GPIOUtils::start();
	GPIOUtils::setup_pin(17, 1, 1); // The GPIO stuff in general needs some love

	engine.load(url);

	return app.exec();
}
