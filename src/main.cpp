#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "fileutils.h"
#include "gpio.h"
#include "timelapse_utils.h"
#include "rsync_utils.h"
#include "camera_utils.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
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

    GPIO* gpio = new GPIO();
    engine.rootContext()->setContextProperty("GPIO", gpio);

    TimelapseUtils* timelapseUtils = new TimelapseUtils();
    engine.rootContext()->setContextProperty("TimelapseUtils", timelapseUtils);

    RsyncUtils* rsyncUtils = new RsyncUtils();
    engine.rootContext()->setContextProperty("rsync", rsyncUtils);

    CameraUtils* cameraUtils = new CameraUtils();
    engine.rootContext()->setContextProperty("cam", cameraUtils);

    CameraUtils::start_preview();

    engine.load(url);

    return app.exec();
}
