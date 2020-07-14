#include <assert.h>

#include <QTextStream>
#include <QFile>

#include "configuration.h"

QString projectDir;
QString remoteDir;

const QString Configuration::projectDir(void) {
    QFile* file = new QFile("FIGURE THIS OUT");
    if (file->open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(file);
        bool found = false;
        QString* line = new QString();
        while (!found) {
            assert(in.readLineInto(line));
            if (line->contains("PROJECT_DIR=")) {
                found = true;
                line->remove("PROJECT_DIR=");
            }
        }
        return *line;
    } else {
        return "";
    }
}


const QString Configuration::remoteDir(void) {
    QFile* file = new QFile("FIGURE THIS OUT");
    if (file->open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(file);
        bool found = false;
        QString* line = new QString();
        while (!found) {
            assert(in.readLineInto(line));
            if (line->contains("PROJECT_DIR=")) {
                found = true;
                line->remove("PROJECT_DIR=");
            }
        }
        return *line;
    } else {
        return "";
    }
}

