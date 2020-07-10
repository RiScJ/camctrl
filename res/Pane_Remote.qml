import QtQuick 2.0
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
        enabled: true
        width: 80
        height: 79
        text: "NEW"
        topPadding: 15
        font.pointSize: 24
        font.family: "Courier"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 3
        visible: true

        onClicked: {
            newRemoteUI.visible = true
        }
    }

    Button { id: deleteRemoteButton
        enabled: true
        width: 80
        height: 79
        text: qsTr("DEL")
        topPadding: 15
        font.pointSize: 24
        font.family: "Courier"
        anchors.left: parent.left
        anchors.leftMargin: 95
        anchors.top: parent.top
        visible: true
        anchors.topMargin: 3

        onClicked: {
            delRemoteUI.visible = true
        }

    }

    ToolSeparator {
        id: toolSeparator6
        anchors.top: parent.top
        anchors.topMargin: 90
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        orientation: Qt.Horizontal
    }

    Button { id: configRemoteButton
        width: 176
        height: 79
        text: "CONFIG"
        anchors.left: parent.left
        anchors.leftMargin: 0
        topPadding: 15
        anchors.top: parent.top
        visible: true
        anchors.topMargin: 109
        font.pointSize: 24
        font.family: "Courier"

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
        anchors.topMargin: 194
        anchors.rightMargin: 0
    }
}
