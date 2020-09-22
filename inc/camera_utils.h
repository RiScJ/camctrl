#ifndef CAMERA_UTILS_H
#define CAMERA_UTILS_H

#include <QObject>

enum Mode {
	NUL,
	IMG,
	VID,
	LPS,
	FRM
};

class CameraUtils : public QObject {
	Q_OBJECT

public:
	explicit CameraUtils (QObject* parent = 0) : QObject(parent) {}
	static void set_homeDir(std::string dir);
	static void capture_frame_EXT(void);
	static void capture_video_EXT(void);
	static void capture_image_EXT(void);
	Q_INVOKABLE static void set_project(QString proj);
	Q_INVOKABLE static void update_annotations(int anot);
	Q_INVOKABLE static void start(QString mode);
	Q_INVOKABLE static void stop(void);
	Q_INVOKABLE static void capture(QString mode);
	Q_INVOKABLE static void record(void);
	Q_INVOKABLE static bool get_status(void);
	Q_INVOKABLE static void update_frameRate(int rate);
	static std::string frameRate;
	static bool recording;

private:
	static std::string homeDir;
	static std::string project;
	static int annotation;
	static const int CAMERA_VIEWPORT_X = 0;
	static const int CAMERA_VIEWPORT_Y = 0;
	static const int CAMERA_VIEWPORT_WIDTH = 600;
	static const int CAMERA_VIEWPORT_HEIGHT = 460;
	static std::string get_preview_arg(void);
	static std::string get_annotation_arg(void);
	static void start_still(void);
	static void capture_still(void);
	static void stop_still(void);
	static void start_vid(void);
	static void stop_vid(void);
	static void start_lapse(void);
	static void capture_frame(void);
	static void stop_lapse(void);
	static Mode resolve(QString mode);



};

#endif // CAMERA_UTILS_H
