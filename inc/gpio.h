#ifndef GPIO_H
#define GPIO_H

#include <QObject>

class GPIO : public QObject {
    Q_OBJECT

public:
    explicit GPIO (QObject* parent = 0) : QObject(parent) {}

public slots:
    void attachInterrupt(const QString &pin);

signals:
    void risingEdge();
};

#endif // GPIO_H
