#include <QDebug>
#include <chrono>
#include <thread>

#include "gpio.h"


void GPIO::attachInterrupt(const QString &pin) {

    emit risingEdge();

    qDebug() << qPrintable(pin);
}
