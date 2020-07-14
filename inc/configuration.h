#ifndef CONFIGURATION_H
#define CONFIGURATION_H

#include <QObject>

class Configuration : public QObject {
    Q_OBJECT
public:
    explicit Configuration (QObject* parent = 0) : QObject(parent) { }
    static const QString homeDir(void);
    static const QString projectDir(void);
    static const QString remoteDir(void);
};

#endif // CONFIGURATION_H
