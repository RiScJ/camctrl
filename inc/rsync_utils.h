#ifndef RSYNC_UTILS_H
#define RSYNC_UTILS_H

#include <QObject>

class RsyncUtils : public QObject {
    Q_OBJECT
public:
    explicit RsyncUtils (QObject* parent = 0) : QObject(parent) {}
    Q_INVOKABLE static QStringList readConfig(const QString &path);
};

#endif // RSYNC_UTILS_H
