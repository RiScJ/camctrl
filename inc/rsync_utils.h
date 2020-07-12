#ifndef RSYNC_UTILS_H
#define RSYNC_UTILS_H

#include <QObject>

class RsyncUtils : public QObject {
    Q_OBJECT
public:
    explicit RsyncUtils (QObject* parent = 0) : QObject(parent) {}
    static QStringList readConfig(const QString path);
    Q_INVOKABLE QString getConfigParam(const QString path, const QString param);
    Q_INVOKABLE void setConfig(const QString path, const QString cmd, const QString flags, const QString user, const QString host, const QString dest);
    Q_INVOKABLE void sync(const QString projectPath, const QString configPath);
};

#endif // RSYNC_UTILS_H
