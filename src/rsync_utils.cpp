#include <stdio.h>
#include <stdlib.h>

#include <QDir>
#include <QFile>
#include <QTextStream>
#include <QDebug>

#include "rsync_utils.h"

QStringList RsyncUtils::readConfig(const QString path) {
    QStringList config;
    QFile* file = new QFile(path);
    if (file->open(QIODevice::ReadWrite | QIODevice::Text)) {
        QTextStream in(file);
        config << in.readAll().remove(QChar('\n')).split("\t");
        file->close();
    }
    return config;
};


QString RsyncUtils::getConfigParam(const QString path, const QString param) {
    QStringList config = readConfig(path);
    if (config.length() > 1) {
        if (param == "CMD") {
            return config.at(0);
        } else if (param == "FLAGS") {
            return config.at(2);
        } else if (param == "USER") {
            return config.at(3);
        } else if (param == "HOST") {
            return config.at(5);
        } else if (param == "DEST") {
            return config.at(7);
        } else {
            return "";
        }
    } else {
        return "";
    }
};


void RsyncUtils::sync(const QString projectPath, const QString configPath) {
    std::string config;
    config += qPrintable(getConfigParam(configPath, "CMD"));
    if (!getConfigParam(configPath, "FLAGS").isEmpty()) {
        config += " -";
        config += qPrintable(getConfigParam(configPath, "FLAGS"));
    }
    config += " ";
    config += qPrintable(projectPath);
    if (!getConfigParam(configPath, "USER").isEmpty()) {
        config += " ";
        config += qPrintable(getConfigParam(configPath, "USER"));
        config += "@";
    } else {
        config += " ";
    }
    config += qPrintable(getConfigParam(configPath, "HOST"));
    config += ":";
    config += qPrintable(getConfigParam(configPath, "DEST"));

    system(config.c_str());
}


void RsyncUtils::setConfig(const QString path, const QString cmd, const QString flags, const QString user, const QString host, const QString dest) {
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

    QFile* file = new QFile(path);
    if (file->open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(file);
        out << config.c_str() << '\n';
        file->close();
    }
}























