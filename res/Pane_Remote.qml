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

    property string menuTitle: "Remote"

    Button { id: newRemoteButton
        enabled: remotePane.visible
        width: 80
        height: 48
        text: "NEW"
        bottomPadding: 14
        rightPadding: 11
        font.italic: true
        topPadding: 15
        font.pointSize: 15
        //font.family: "Courier"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 3

        onClicked: {
            newRemoteUI.visible = true
        }
    }

    Button { id: deleteRemoteButton
        enabled: remotePane.visible
        width: 80
        height: 48
        text: qsTr("DEL")
        bottomPadding: 14
        rightPadding: 11
        font.italic: true
        topPadding: 15
        font.pointSize: 15
        //font.family: "Courier"
        anchors.left: parent.left
        anchors.leftMargin: 95
        anchors.top: parent.top
        anchors.topMargin: 3

        onClicked: {
            delRemoteUI.visible = true
        }

    }

    ToolSeparator {
        id: toolSeparator6
        anchors.top: parent.top
        anchors.topMargin: 44
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        orientation: Qt.Horizontal
    }

    Button { id: configRemoteButton
        enabled: remotePane.visible
        width: 176
        height: 48
        text: "CONFIG"
        rightPadding: 13
        bottomPadding: 14
        font.italic: true
        anchors.left: parent.left
        anchors.leftMargin: 0
        topPadding: 15
        anchors.top: parent.top
        anchors.topMargin: 61
        font.pointSize: 15
        //font.family: "Courier"

        onClicked: {
            configRemoteUI.visible = true
        }

    }

    ToolSeparator {
        id: toolSeparator7
        anchors.left: parent.left
        orientation: Qt.Horizontal
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 103
        anchors.rightMargin: 0
    }
}
