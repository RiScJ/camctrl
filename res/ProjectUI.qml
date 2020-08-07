import QtQuick 2.6
import QtQuick.Window 2.6
import QtQuick.Controls 2.2
import QtMultimedia 5
import Qt.labs.folderlistmodel 1
import QtQuick.VirtualKeyboard 2.1


Rectangle { id: projectUI
    z: app.forceTop - 1
    width: 600
    height: 460
    color: "#ffffff"
    visible: stack.subapp == "projects"

    Rectangle { id: projectListTitle
        x: 0
        y: 0
        z: app.forceTop + 5
        width: 600
        height: 40
        color: "#000000"
        visible: stack.subapp == "projects"

        Text {
            anchors.left: parent.left
            anchors.leftMargin: 0
            z: app.forceTop + 1
            text: qsTr("Name")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 4
            font.weight: Font.DemiBold
            style: Text.Normal
            font.capitalization: Font.SmallCaps
            font.italic: true
            color: "#ffffff"
            font.pointSize: 19
            font.bold: false
            //font.family: "Courier"
            topPadding: 10
            leftPadding: 10
        }

        Text {
            anchors.right: parent.right
            anchors.rightMargin: 0
            z: app.forceTop + 1
            text: qsTr("Last modified")
            font.italic: true
            font.capitalization: Font.SmallCaps
            font.weight: Font.DemiBold
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 4
            color: "#ffffff"
            font.pointSize: 19
            font.bold: false
            //font.family: "Courier"
            topPadding: 10
            rightPadding: 10
        }

    }

    ListView {
        id: listView
        z: app.forceTop
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 40
        visible: true
        snapMode: ListView.SnapToItem
        model: projectListModel
        delegate: projectListDelegate
        focus: true
        currentIndex: 0
        highlight: Rectangle {
            z: app.forceTop
            color:"#32fc9e"
            opacity: 0.5
            focus: true
        }
        highlightFollowsCurrentItem: true

        Component { id: projectListDelegate
            Rectangle {

                width: ListView.view.width
                height: 30

                color: fileName == app.currentProject ? "#fc9e32" : index % 2 == 0 ? "#a4a4a4" : "#444444"

                Text { id: fileNameText
                    anchors.left: parent.left
                    anchors.leftMargin: 0
                    z: app.forceTop + 1
                    text: fileName
                    color: "#000000"
                    font.pointSize: 14
                    font.bold: false
                    font.family: "Courier"
                    topPadding: 10
                    leftPadding: 10
                }

                Text { id: fileModText
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    z: app.forceTop + 1
                    text: fileModified.toLocaleDateString(Qt.locale("en_US"), "d MMM yyyy")
                    color: "#000000"
                    font.pointSize: 14
                    font.bold: false
                    font.family: "Courier"
                    topPadding: 10
                    leftPadding: 10
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        listView.currentIndex = index
                    }
                }

            }

        }

        FolderListModel { id: projectListModel
            folder: "file://" + projectPath
        }

    }


}

/*##^##
Designer {
    D{i:0;height:460;width:600}
}
##^##*/
