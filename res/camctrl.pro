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
		$$PWD/../res/ \
		$$PWD/../tests/inc/ \
		$$PWD/../tests/src/ \
		/opt/vc/include

HEADERS += \
	../inc/camctrl_error.hpp \
	../inc/camera_utils.h \
	../inc/fileutils.h \
	../inc/rsync_utils.h \
	../inc/timelapse_utils.h

SOURCES += \
		../src/camctrl_error.cpp \
		../src/camera_utils.cpp \
		../src/fileutils.cpp \
		../src/main.cpp \
		../src/rsync_utils.cpp \
		../src/timelapse_utils.cpp \
		../tests/src/test_rsync_utils.cpp

RESOURCES += \
		../res/qml.qrc


qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

# Outcomment these during non-BCM development

#HEADERS += \
#	../inc/gpio_utils.h \
#	../tests/inc/test_gpio_utils.hpp \
#	../tests/inc/test_gpio.hpp

#SOURCES += \
#		../src/gpio_utils.cpp \
#		../tests/src/test_gpio_utils.cpp \
#		../tests/src/test_gpio.cpp

#LIBS += -L/opt/vc/lib -lbcm_host
