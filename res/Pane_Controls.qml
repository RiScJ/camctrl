import QtQuick 2.6
import QtQuick.Controls 2.2

Pane {
    background: Rectangle {
        color: "#444444"
        border.width: 0
    }
    x: 600
    width: 200
    height: 440
    anchors.top: mainBar.bottom
    anchors.topMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0

    property string menuTitle: "Control"

    // Photo capturing button
    Button { id: captureButton
        width: 150
        text: {
            app.statusName === "IDLE"
                    ?
                        app.trigName === "USR"
                            ?
                                qsTr("CAPTURE")
                            :
                                app.trigName === "TMR"
                                    ?
                                        qsTr("START\nTIMED\nCAPTURE")
                                    :
                                        qsTr("START\nEXT\nCAPTURE")
                    :
                        app.trigName === "USR"
                            ?
                                qsTr("CAPTURE")
                            :
                                app.trigName === "TMR"
                                    ?
                                        qsTr("STOP\nTIMED\nCAPTURE")
                                    :
                                        qsTr("STOP\nEXT\nCAPTURE")
        }
        wheelEnabled: false
        font.family: "Courier"
        font.pointSize: 23
        bottomPadding: 0
        rightPadding: 0
        leftPadding: 0
        topPadding: 10
        anchors.top: toolSeparator.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        visible: app.modeName === "IMG"
        enabled: app.modeName === "IMG"
        onClicked: {
            app.statusName === "IDLE"
                    ?
                        app.trigName === "USR" ? app.capturePhoto() : app.trigName === "TMR" ? app.captureTimedPhotos() : app.captureEXTPhotos()
                    :
                        app.trigName === "TMR" ? app.stopTimedPhotos() : app.stopEXTPhotos()
        }
    }

    Button { id: recordButton
        width: 150
        text: {
            app.statusName === "IDLE"
                    ?
                        app.trigName === "USR"
                            ?
                                qsTr("RECORD")
                            :
                                app.trigName === "TMR"
                                    ?
                                        qsTr("START\nTIMED\nRECORD")
                                    :
                                        qsTr("START\nEXT\nRECORD")
                    :
                        app.trigName === "USR"
                            ?
                                qsTr("STOP")
                            :
                                app.trigName === "TMR"
                                    ?
                                        qsTr("STOP\nTIMED\nRECORD")
                                    :
                                        qsTr("STOP\nEXT\nRECORD")
        }
        font.family: "Courier"
        font.pointSize: 23
        bottomPadding: 0
        rightPadding: 0
        leftPadding: 0
        topPadding: 10
        anchors.top: toolSeparator.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        visible: app.modeName === "VID"
        enabled: app.modeName === "VID"
        onClicked: {
            app.statusName === "IDLE"
                    ?
                        app.trigName === "USR" ? app.startRecording() : app.trigName === "TMR" ? app.startTimedRecording() : app.startEXTRecording()
                    :
                        app.trigName === "USR" ? app.stopRecording() : app.trigName === "TMR" ? app.stopTimedRecording() : app.stopEXTRecording()
        }
    }

    Button { id: lapseButton
        width: 150
        text: app.modeName === "LPS" ? qsTr("LAPSE") : qsTr("STOP")
        font.family: "Courier"
        font.pointSize: 23
        bottomPadding: 0
        rightPadding: 0
        leftPadding: 0
        topPadding: 10
        anchors.top: toolSeparator.bottom
        anchors.topMargin: app.modeName === "LPS" ? 10 : app.trigName === "USR" ? 90 : 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        visible: app.modeName === "LPS" | app.modeName === "FRM"
        enabled: app.modeName === "LPS" | app.modeName === "FRM"
        onClicked: {
            app.modeName === "LPS" ? app.startLapse() : app.stopLapse()
        }
    }

    Button { id: captureFrame
        width: 150
        text: qsTr("CAPTURE")
        font.family: "Courier"
        font.pointSize: 23
        bottomPadding: 0
        rightPadding: 0
        leftPadding: 0
        topPadding: 10
        anchors.top: toolSeparator.bottom
        anchors.topMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 90
        visible: app.modeName === "FRM" & app.trigName === "USR"
        enabled: app.modeName === "FRM" & app.trigName === "USR"
        onClicked: {
            app.captureLapseFrame()
        }
    }

    ToolSeparator {
        id: toolSeparator
        y: 235
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        orientation: Qt.Horizontal
    }

    Button { id: modeButton
        x: 10
        y: 12
        width: 72
        height: 64
        text: qsTr("MODE")
        font.bold: false
        topPadding: 12
        font.family: "Courier"
        font.pointSize: 15
        enabled: app.statusName === "IDLE"
        onClicked: {
            if (app.modeName === "IMG") {
                app.modeName = "VID"
            } else if (app.modeName === "VID") {
                app.modeName = "LPS"
            } else {
                app.modeName = "IMG"
            }
        }
    }

    Button { id: trigButton
        x: 94
        y: 12
        width: 72
        height: 64
        text: qsTr("TRIG")
        font.family: "Courier"
        topPadding: 12
        font.pointSize: 15
        enabled: app.statusName === "IDLE"
        onClicked: {
            if (app.trigName === "USR") {
                app.trigName = "EXT"
            } else if (app.trigName === "EXT") {
                app.trigName = "TMR"
            } else {
                app.trigName = "USR"
            }
        }
    }

    Button { id: overlaysButton
        x: 10
        y: 87
        width: 156
        height: 64
        text: qsTr("OVERLAYS")
        topPadding: 12
        font.pointSize: 15
        font.bold: false
        font.family: "Courier"
        enabled: false
        onClicked: {
            stack.pop()
        }
    }

    Button { id: optionsButton
        x: 10
        y: 162
        width: 156
        height: 64
        text: qsTr("OPTIONS")
        topPadding: 12
        font.pointSize: 15
        font.bold: false
        font.family: "Courier"
        enabled: app.statusName === "IDLE"
        onClicked: {
            stack.push(optionsPane)
            mainBar.currentMenuName = "Options"
        }
    }
}
