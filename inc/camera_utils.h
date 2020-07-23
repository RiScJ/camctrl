#ifndef CAMERA_UTILS_H
#define CAMERA_UTILS_H

#include <QObject>

class CameraUtils : public QObject {
    Q_OBJECT

public:
    explicit CameraUtils (QObject* parent = 0) : QObject(parent) {}
    static void set_homeDir(std::string dir);
    Q_INVOKABLE static void set_project(QString proj);
    Q_INVOKABLE static void start_preview(void);
    Q_INVOKABLE static void stop_preview(void);
    Q_INVOKABLE static void start_recording(void);
    Q_INVOKABLE static void stop_recording(void);
    Q_INVOKABLE static void capture(void);

private:
    static std::string homeDir;
    static std::string project;
    static const int CAMERA_VIEWPORT_X = 0;
    static const int CAMERA_VIEWPORT_Y = 0;
    static const int CAMERA_VIEWPORT_WIDTH = 600;
    static const int CAMERA_VIEWPORT_HEIGHT = 460;
    static std::string get_preview_arg(void);
};

#endif // CAMERA_UTILS_H
