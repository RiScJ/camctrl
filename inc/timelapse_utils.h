#ifndef TIMELAPSE_UTILS_H
#define TIMELAPSE_UTILS_H

#include <QObject>

class TimelapseUtils : public QObject {
	Q_OBJECT

public:
	explicit TimelapseUtils (QObject* parent = 0) : QObject(parent) {}
	Q_INVOKABLE static void stitch(const QString dirPath);
	Q_INVOKABLE static void update_encodingRate(int rate);
private:
	static int encodingRate;
};

#endif // TIMELAPSE_UTILS_H
