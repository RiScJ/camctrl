#include <QDir>
#include <QFile>
#include <QTextStream>
#include <QDebug>

#include "rsync_utils.h"

QStringList RsyncUtils::readConfig(const QString &path) {
    QStringList config;
    QFile file(path);
    file.open(QIODevice::ReadWrite);
    QTextStream in(&file);
    config << in.readAll().remove(QChar('\n')).split("\t");
    return config;
}
