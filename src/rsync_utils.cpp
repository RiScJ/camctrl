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
};


QString RsyncUtils::getConfigParam(const QString &path, const QString &param) {
    QStringList config = readConfig(path);
    if (config.length() > 1) {
        if (param == "CMD") {
            return config[0];
        } else if (param == "FLAGS") {
            return config[2];
        } else if (param == "USER") {
            return config[3];
        } else if (param == "HOST") {
            return config[5];
        } else if (param == "DEST") {
            return config[7];
        } else {
            return nullptr;
        }
    } else {
        return nullptr;
    }
};


void RsyncUtils::sync(const QString &path, const QString &cmd, const QString &flags, const QString &user, const QString &host, const QString &dest) {
    std::string command;
    command += qPrintable(cmd);
    command += " ";
    if (!flags.isEmpty()) {
        command += "-";
        command += qPrintable(flags);
        command += " ";
    }
    if (!user.isEmpty()) {
        command += qPrintable(user);
        command += "@";
    }
    command += qPrintable(host);
    command += ":";
    command += qPrintable(dest);

    QFile file(path);
    if(file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(&file);

        out << command.c_str() << '\n';

        file.close();
    }
}


void RsyncUtils::setConfig(const QString &path, const QString &cmd, const QString &flags, const QString &user, const QString &host, const QString &dest) {
    std::string config;
    config += qPrintable(cmd);
    config += "\t-\t";
    config += qPrintable(flags);
    config += "\t";
    config += qPrintable(user);
    config += "\t@\t";
    config += qPrintable(host);
    config += "\t:\t";
    config += qPrintable(dest);

    QFile file(path);
    if(file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(&file);
        out << config.c_str() << '\n';
        file.close();
    }
}























