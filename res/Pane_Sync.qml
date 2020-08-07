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
    anchors.top: mainBar.bottom
    anchors.topMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0
    visible: false

    property string menuTitle: "Sync"

    property string selectedRemote: ""

    Button { id: addSync_Button
        enabled: true
        width: 80
        height: 48
        text: "SELECT"
        rightPadding: 10
        bottomPadding: 14
        font.italic: true
        topPadding: 15
        font.pointSize: 15
        //font.family: "Courier"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 3
        visible: true

        onClicked: {
            //if (!syncPane.selectedRemotes.includes(remoteListModel.get(remoteListView.currentIndex, "fileName"))) {
            //    syncPane.selectedRemotes.push(remoteListModel.get(remoteListView.currentIndex, "fileName"))
            //} else {
            //    console.log("Already selected.")
            //}
            //console.log(syncPane.selectedRemotes)
            syncPane.selectedRemote = remoteListModel.get(remoteListView.currentIndex, "fileName")
        }
    }

    Button { id: removeSync_Button
        y: 60
        width: 176
        height: 48
        text: "REMOVE"
        rightPadding: 10
        bottomPadding: 14
        font.italic: true
        anchors.left: parent.left
        anchors.leftMargin: 0
        topPadding: 15
        anchors.top: addSync_Button.bottom
        visible: true
        anchors.topMargin: 10
        font.pointSize: 15
        //font.family: "Courier"

        onClicked: {
            syncPane.selectedRemote = ""
        }

    }

    ToolSeparator {
        anchors.left: parent.left
        orientation: Qt.Horizontal
        anchors.leftMargin: 0
        anchors.top: removeSync_Button.bottom
        anchors.right: parent.right
        anchors.topMargin: 5
        anchors.rightMargin: 0
    }

    Button { id: pushSync_Button
        enabled: true
        width: 176
        height: 48
        text: "PUSH"
        anchors.top: removeSync_Button.bottom
        anchors.topMargin: 33
        rightPadding: 10
        bottomPadding: 14
        font.italic: true
        anchors.left: parent.left
        anchors.leftMargin: 0
        topPadding: 15
        visible: true
        font.pointSize: 15
        //font.family: "Courier"
        onClicked: {
            rsync.sync(app.selectedProject, app.homeDir + ".camctrl/remote/" + syncPane.selectedRemote)
        }
    }
}
