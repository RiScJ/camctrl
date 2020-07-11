#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>

class FileUtils : public QObject {
    Q_OBJECT
public:
    explicit FileUtils (QObject* parent = 0) : QObject(parent) {}
    Q_INVOKABLE static bool mkdir(const QString &dirName);
    Q_INVOKABLE static bool removeDir(const QString &dirName);
    Q_INVOKABLE static qint64 dirSize(const QString &dirPath);
    Q_INVOKABLE static QString formatSize(const qint64 &size);
    Q_INVOKABLE static QString formattedDirSize(const QString &dirPath);
    Q_INVOKABLE static qint64 totalStorage();
    Q_INVOKABLE static qint64 freeStorage();
    Q_INVOKABLE static bool touch(const QString &path);
    Q_INVOKABLE static bool rm(const QString &path);
    Q_INVOKABLE static QString readFile(const QString &path);
};

#endif // FILEUTILS_H
