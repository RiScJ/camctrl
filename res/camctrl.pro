QT += quick qml

static {
	QT += svg
	QTPLUGIN += qtvirtualkeyboardplugin
}

CONFIG += c++11 disable-desktop

DEFINES += QT_DEPRECATED_WARNINGS

INCLUDEPATH += \
        $$PWD/../inc/ \
        $$PWD/../src/ \
        $$PWD/../res/ \
        /usr/include/python3.8/

HEADERS += \
    ../inc/fileutils.h \
    ../inc/gpio.h \
    ../inc/rsync_utils.h \
    ../inc/timelapse_utils.h

SOURCES += \
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

