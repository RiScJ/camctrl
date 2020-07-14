QT += quick qml

static {
	QT += svg
	QTPLUGIN += qtvirtualkeyboardplugin
}

QMAKE_CXXFLAGS += -g -rdynamic

CONFIG += c++11 disable-desktop

DEFINES += QT_DEPRECATED_WARNINGS

INCLUDEPATH += \
        $$PWD/../inc/ \
        $$PWD/../src/ \
        $$PWD/../res/

HEADERS += \
    ../inc/configuration.h \
    ../inc/fileutils.h \
    ../inc/gpio.h \
    ../inc/rsync_utils.h \
    ../inc/timelapse_utils.h

SOURCES += \
        ../src/configuration.cpp \
        ../src/fileutils.cpp \
        ../src/gpio.cpp \
        ../src/main.cpp \
        ../src/rsync_utils.cpp \
        ../src/timelapse_utils.cpp

RESOURCES += \
        ../res/qml.qrc

LIBS += -L/usr/lib -lcrypt -lpthread -ldl -lutil -lm -lm

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

