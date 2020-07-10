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

    property string menuTitle: "Projects"

    Button { id: newProjButton
        enabled: true
        width: 80
        height: 79
        text: "NEW"
        topPadding: 15
        font.pointSize: 24
        font.family: "Courier"
        display: AbstractButton.TextBesideIcon
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 3
        visible: true

        onClicked: {
            newProjectUI.visible = true
        }
    }

    Button { id: deleteProjButton
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
            delProjectUI.visible = true
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

    Button { id: selectProjButton
        width: 176
        height: 79
        text: "SELECT"
        anchors.left: parent.left
        anchors.leftMargin: 0
        topPadding: 15
        anchors.top: parent.top
        visible: true
        anchors.topMargin: 109
        display: AbstractButton.TextBesideIcon
        font.pointSize: 24
        font.family: "Courier"

        onClicked: {
            app.currentProject = projectListModel.get(listView.currentIndex, "fileName")
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

    Button { id: openProjButton
        enabled: false
        width: 176
        height: 79
        text: "OPEN"
        anchors.left: parent.left
        anchors.leftMargin: 0
        topPadding: 15
        anchors.top: parent.top
        visible: true
        anchors.topMargin: 213
        font.pointSize: 24
        display: AbstractButton.TextBesideIcon
        font.family: "Courier"
    }
}
