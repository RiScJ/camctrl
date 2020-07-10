#ifndef TIMELAPSE_UTILS_H
#define TIMELAPSE_UTILS_H

#include <QObject>

class TimelapseUtils : public QObject {
    Q_OBJECT

public:
    explicit TimelapseUtils (QObject* parent = 0) : QObject(parent) {}
    Q_INVOKABLE static void stitch(const QString &dirPath);
};

#endif // TIMELAPSE_UTILS_H
