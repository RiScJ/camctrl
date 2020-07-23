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
    ../inc/camera_utils.h \
    ../inc/fileutils.h \
    ../inc/gpio.h \
    ../inc/rsync_utils.h \
    ../inc/timelapse_utils.h

SOURCES += \
        ../src/camera_utils.cpp \
        ../src/fileutils.cpp \
        ../src/gpio.cpp \
        ../src/main.cpp \
        ../src/rsync_utils.cpp \
        ../src/timelapse_utils.cpp \
        ../tests/test_rsync_utils.cpp

RESOURCES += \
        ../res/qml.qrc

qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES +=

