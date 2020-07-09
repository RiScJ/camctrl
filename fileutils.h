#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>

class FileUtils : public QObject {
    Q_OBJECT
public:
    explicit FileUtils (QObject* parent = 0) : QObject(parent) {}
    Q_INVOKABLE static bool mkdir(const QString &dirName);
    Q_INVOKABLE static bool removeDir(const QString &dirName);
};

#endif // FILEUTILS_H
