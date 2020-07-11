import QtQuick 2.6
import QtQuick.Controls 2.2

Pane {
    id: pane
    background: Rectangle {
        color: "#444444"
        border.width: 0
    }
    x: 600
    width: 200
    height: 440
    visible: true
    anchors.top: mainBar.bottom
    anchors.topMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0

    property string menuTitle: "SysInfo"

    Label {
        id: label
        x: -552
        color: "#ffffff"
        text: qsTr("Projects")
        anchors.horizontalCenterOffset: 0
        rightPadding: 10
        font.pointSize: 18
        font.family: "Courier"
        anchors.horizontalCenter: parent.horizontalCenter
        visible: true
        anchors.top: parent.top
        anchors.topMargin: 10
    }

    Label {
        id: label1
        x: 0
        y: 36
        color: "#ffffff"
        text: qsTr("Project folder:")
        font.family: "Courier"
    }

    Label {
        id: label2
        y: 55
        color: "#11ff88"
        text: app.projectPath
        anchors.left: parent.left
        anchors.leftMargin: 10
        font.pointSize: 10
        font.family: "Courier"
    }

    Label {
        id: label3
        x: 0
        y: 70
        color: "#ffffff"
        text: qsTr("No. projects:")
        font.family: "Courier"
    }

    Label {
        id: label4
        y: 73
        color: "#11ff88"
        text: listView.count.toString()
        font.family: "Courier"
        anchors.left: label3.right
        font.pointSize: 10
        anchors.leftMargin: 14
    }

    Label {
        id: label5
        x: 0
        y: 86
        color: "#ffffff"
        text: qsTr("Storage used:")
        font.family: "Courier"
    }

    Label {
        id: label6
        y: 104
        color: "#11ff88"
        text: fileUtils.formattedDirSize(app.projectPath)
        font.family: "Courier"
        anchors.left: parent.left
        font.pointSize: 10
        anchors.leftMargin: 10
    }

    Label {
        id: label7
        x: 110
        y: 104
        width: 41
        height: 14
        color: "#11ff3a"
        text: (fileUtils.dirSize(app.projectPath) / fileUtils.totalStorage()).toString().slice(0, 3) + "\%"
        anchors.right: parent.right
        anchors.rightMargin: 25
        font.family: "Courier"
        font.pointSize: 10
    }

    Label {
        id: label13
        x: -552
        color: "#ffffff"
        text: qsTr("Device")
        font.family: "Courier"
        rightPadding: 10
        visible: true
        anchors.topMargin: 223
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 1
        anchors.top: parent.top
        font.pointSize: 18
    }

    Label {
        id: label17
        x: 0
        y: 247
        color: "#ffffff"
        text: qsTr("Storage:")
        font.family: "Courier"
    }

    Label {
        id: label26
        x: 125
        y: 250
        width: 41
        height: 14
        color: "#11ff3a"
        text: (100 * (fileUtils.totalStorage() - fileUtils.freeStorage()) / fileUtils.totalStorage()).toString().slice(0, 4) + "\%"
        font.family: "Courier"
        anchors.rightMargin: 10
        font.pointSize: 10
        anchors.right: parent.right
    }

    Label {
        id: label27
        y: 265
        color: "#11ff88"
        text: fileUtils.formatSize(fileUtils.totalStorage() - fileUtils.freeStorage())
        font.family: "Courier"
        anchors.left: parent.left
        font.pointSize: 10
        anchors.leftMargin: 5
    }

    Label {
        id: label28
        x: -190
        y: 295
        color: "#b5b5b5"
        text: fileUtils.formatSize(fileUtils.totalStorage())
        anchors.right: parent.right
        anchors.rightMargin: 7
        font.family: "Courier"
        font.pointSize: 10
    }

    Label {
        id: label29
        x: 79
        width: 9
        height: 14
        color: "#b5b5b5"
        text: qsTr("/")
        anchors.top: parent.top
        anchors.topMargin: 282
        anchors.right: parent.right
        anchors.rightMargin: 88
        font.family: "Courier"
        font.pointSize: 10
    }
}

/*##^##
Designer {
    D{i:2;anchors_x:-552;anchors_y:28}D{i:4;anchors_x:0}D{i:6;anchors_x:0}D{i:8;anchors_x:0}
D{i:9;anchors_x:0}D{i:10;anchors_x:"-552";anchors_y:28}D{i:12;anchors_x:0}D{i:14;anchors_x:0}
D{i:15;anchors_x:"-552";anchors_y:28}D{i:17;anchors_x:0}D{i:18;anchors_x:0}D{i:19;anchors_x:0}
D{i:20;anchors_width:9;anchors_x:0;anchors_y:308}
}
##^##*/
