import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
    id: controlUI

    color: "#261a20"
    x: 0
    y: 0
    width: 800
    height: 480

    visible: false
    enabled: visible

    signal openMainUI

    Pane {
        id: pane

        x: 600
        y: 0
        width: 200
        height: 480

        background: Rectangle {
            color: parent.parent.color
        }

        ToolBar {
            id: toolBar

            width: 200
            height: 40
            anchors.left: parent.left
            anchors.leftMargin: -12
            anchors.top: parent.top
            anchors.topMargin: -12

            Material.primary: "#413a48"

            Label {
                id: label
                y: 22
                color: "#ffffff"
                text: qsTr("Control")
                anchors.verticalCenterOffset: 2
                font.italic: false
                font.bold: false
                font.capitalization: Font.MixedCase
                font.family: "cmmi10"
                font.pointSize: 20
                anchors.left: parent.left
                anchors.leftMargin: 18
                anchors.verticalCenter: parent.verticalCenter
            }

            RoundButton {
                id: roundButton
                x: 150
                y: 0
                width: 38
                height: 38
                text: "*"
                anchors.verticalCenterOffset: 1
                rightPadding: 12
                clip: false
                font.bold: false
                topPadding: 28
                font.capitalization: Font.AllLowercase
                bottomPadding: 5
                font.pointSize: 19
                font.family: "cmsy10"
                anchors.right: parent.right
                anchors.rightMargin: 10
                anchors.verticalCenter: parent.verticalCenter

                onClicked: {
                    openMainUI()
                    controlUI.visible = false
                }
            }
        }
    }












    ToolBar { id: statusBar
//        background: Rectangle {
//            color: "#000000"
//            border.width: 0
//        }
//        x: 0
//        y: 460
//        z: app.forceTop // Always shown
//        width: 600
//        height: 20

//        Label { id: nameLabel
//            x: 5
//            y: 0
//            color: "#ffffff"
//            text: app.currentProject
//            font.capitalization: Font.MixedCase
//            font.pointSize: 11
//            verticalAlignment: Text.AlignBottom
//            horizontalAlignment: Text.AlignLeft
//            //font.family: "Courier"
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//            anchors.top: parent.top
//            anchors.topMargin: 0
//            anchors.left: parent.left
//            anchors.leftMargin: 5
//        }

//        ToolSeparator {
//            id: toolSeparator1
//            x: 125
//            y: 0
//            scale: 1
//            anchors.left: parent.left
//            anchors.leftMargin: 125
//            anchors.top: parent.top
//            anchors.topMargin: 0
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//        }

//        Label { id: modeLabel
//            x: 130
//            y: 0
//            color: "#19ff1c"
//            text: qsTr(app.modeName)
//            anchors.left: toolSeparator1.right
//            anchors.leftMargin: 5
//            anchors.top: parent.top
//            anchors.topMargin: 0
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//            font.capitalization: Font.AllUppercase
//            topPadding: 3
//            font.pointSize: 14
//            //font.family: "Courier"
//        }

//        Label { id: trigLabel
//            y: 0
//            color: "#19ff1c"
//            text: qsTr(app.trigName)
//            anchors.left: toolSeparator2.right
//            anchors.leftMargin: 5
//            anchors.top: parent.top
//            anchors.topMargin: 0
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//            topPadding: 3
//            font.capitalization: Font.AllUppercase
//            font.pointSize: 14
//            //font.family: "Courier"
//        }

//        ToolSeparator {
//            id: toolSeparator2
//            x: 185
//            y: 0
//            anchors.left: parent.left
//            anchors.leftMargin: 185
//            anchors.top: parent.top
//            anchors.topMargin: 0
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//        }

//        ToolSeparator {
//            id: toolSeparator3
//            x: 242
//            y: 0
//            anchors.left: parent.left
//            anchors.leftMargin: 242
//            anchors.top: parent.top
//            anchors.topMargin: 0
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//        }

//        Label { id: statusLabel
//            y: 0
//            color: {
//                if (app.statusName == "IDLE") {
//                    "#575c60"
//                } else if (app.statusName == "CAPTURING") {
//                    "#ff0000"
//                } else if (app.statusName == "RECORDING") {
//                    "#ff0000"
//                } else if (app.statusName == "LISTENING") {
//                    "#0000ff"
//                }
//            }
//            text: qsTr(app.statusName)
//            anchors.top: parent.top
//            anchors.topMargin: 0
//            anchors.bottom: parent.bottom
//            anchors.bottomMargin: 0
//            anchors.right: parent.right
//            anchors.rightMargin: 5
//            topPadding: 3
//            font.capitalization: Font.AllUppercase
//            font.pointSize: 14
//            //font.family: "Courier"
//        }

//        ToolSeparator {
//            id: toolSeparator4
//            x: 247
//            y: -2
//            anchors.left: parent.left
//            anchors.leftMargin: 345
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            anchors.topMargin: 0
//            anchors.bottomMargin: 0
//        }

//        Label {
//            id: extLabel
//            y: 0
//            color: "#74ccfe"
//            text: "GPIO " + gpioSpin.value.toString()
//            anchors.left: toolSeparator3.right
//            anchors.leftMargin: 5
//            topPadding: 3
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            anchors.topMargin: 0
//            anchors.bottomMargin: 0
//            font.capitalization: Font.AllUppercase
//            font.pointSize: 14
//            //font.family: "Courier"
//            visible: app.trigName == "EXT"
//        }

//        Label {
//            id: tmrLabel
//            y: 0
//            color: "#74ccfe"
//            text: minTumbler.currentIndex.toString() + "\' " + secTumbler.currentIndex.toString() + "\""
//            anchors.left: toolSeparator3.right
//            anchors.leftMargin: 5
//            topPadding: 3
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            anchors.topMargin: 0
//            anchors.bottomMargin: 0
//            font.capitalization: Font.AllUppercase
//            font.pointSize: 14
//            //font.family: "Courier"
//            visible: app.trigName == "TMR"
//        }

//        ToolSeparator {
//            id: toolSeparator5
//            x: 242
//            y: 2
//            anchors.left: parent.left
//            anchors.leftMargin: 412
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            anchors.topMargin: 0
//            anchors.bottomMargin: 0
//        }

//        Label {
//            id: countLabel
//            y: 0
//            color: "#d673ff"
//            text: {
//                if (app.modeName == "IMG") {
//                   ("000" + app.currentPhoto).slice(-4)
//                } else if (app.modeName == "VID") {
//                    ("000" + app.currentVideo).slice(-4)
//                } else if (app.modeName == "LPS") {
//                    ("000" + app.currentLapse).slice(-4)
//                } else if (app.modeName === "FRM") {
//                    ("000" + app.currentFrame).slice(-4)
//                } else {
//                    console.log("ERROR: Unknown application mode.")
//                }
//            }
//            anchors.left: toolSeparator4.right
//            anchors.leftMargin: 4
//            topPadding: 3
//            anchors.top: parent.top
//            anchors.bottom: parent.bottom
//            anchors.topMargin: 0
//            anchors.bottomMargin: 0
//            font.capitalization: Font.AllUppercase
//            font.pointSize: 14
//            //font.family: "Courier"
//        }
    }


}

/*##^##
Designer {
    D{i:4;anchors_x:66}D{i:3;anchors_width:360}
}
##^##*/
