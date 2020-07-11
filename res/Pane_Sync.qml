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
    visible: false

    property string menuTitle: "Sync"

    Button { id: addSync_Button
        enabled: true
        width: 80
        height: 79
        text: "ADD"
        topPadding: 15
        font.pointSize: 24
        font.family: "Courier"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 3
        visible: true

        onClicked: {
            app.selectedRemote = remoteListModel.get(remoteListView.currentIndex, "fileName")
        }
    }

    Button { id: removeSync_Button
        width: 176
        height: 79
        text: "REMOVE"
        anchors.left: parent.left
        anchors.leftMargin: 0
        topPadding: 15
        anchors.top: parent.top
        visible: true
        anchors.topMargin: 99
        font.pointSize: 24
        font.family: "Courier"

        onClicked: {

        }

    }

    ToolSeparator {
        anchors.left: parent.left
        orientation: Qt.Horizontal
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: 184
        anchors.rightMargin: 0
    }

    Button { id: pushSync_Button
        enabled: true
        width: 176
        height: 79
        text: "PUSH"
        anchors.left: parent.left
        anchors.leftMargin: 0
        topPadding: 15
        anchors.top: parent.top
        visible: true
        anchors.topMargin: 203
        font.pointSize: 24
        font.family: "Courier"
    }
}
