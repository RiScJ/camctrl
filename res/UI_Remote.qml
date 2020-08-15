import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0
import Qt.labs.folderlistmodel 1

Rectangle {
    x: 0
    y: 0
    z: app.forceTop - 1
    width: 600
    height: 460
    color: "#ffffff"
    visible: stack.subapp == "remote" | mainBar.currentMenuName == "Sync"


    signal openMainUI

    Rectangle { id: remoteListTitle
        x: 0
        y: 0
        z: app.forceTop + 5
        width: 600
        height: 40
        color: "#000000"
        visible: stack.subapp == "remote"

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 0
            z: app.forceTop + 1
            text: qsTr("Name")
            color: "#ffffff"
            font.pointSize: 19
            font.bold: false
            //font.family: "Courier"
            topPadding: 10
            leftPadding: 10
        }

    }

    ListView {
        id: remoteListView
        z: app.forceTop
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 40
        visible: stack.subapp == "remote" | mainBar.currentMenuName == "Sync"
        snapMode: ListView.SnapToItem
        model: remoteListModel
        delegate: remoteListDelegate
        focus: true
        currentIndex: 0
        highlight: Rectangle {
               z: app.forceTop
               color:"#32fc9e"
               opacity: 0.5
               focus: true
        }
        highlightFollowsCurrentItem: true

        Component { id: remoteListDelegate
            Rectangle {

                width: ListView.view.width
                height: 50

                color: {
                    if (mainBar.currentMenuName === "Sync") {
                    syncPane.selectedRemote === fileName ? "#fc9e32" : index % 2 == 0 ? "#a4a4a4" : "#444444"
                    } else {
                        index % 2 == 0 ? "#a4a4a4" : "#444444"
                    }
                }


                Text { id: remoteNameText
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    z: app.forceTop + 1
                    text: fileName.slice(0, -5);
                    color: "#000000"
                    font.pointSize: 19
                    font.bold: false
                    //font.family: "Courier"
                    topPadding: 15
                    leftPadding: 10
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        remoteListView.currentIndex = index
                    }
                }

            }

        }

        FolderListModel { id: remoteListModel
            folder: "file://" + app.homeDir + ".camctrl/remote/"
            nameFilters: ["*.conf"]
        }

    }


}
