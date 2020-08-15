import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
    id: infoUI

    x: 0
    y: 0
    z: app.forceTop + 2
    width: 800
    height: 480
    color: "#1a2026"

    visible: false
    enabled: visible

    signal openMainUI

    ToolBar {
        id: toolBar
        width: 800
        height: 40
        Label {
            id: label
            y: 22
            color: "#ffffff"
            text: "System"
            anchors.verticalCenterOffset: 2
            verticalAlignment: Text.AlignTop
            textFormat: Text.AutoText
            font.family: "cmmi10"
            font.bold: false
            renderType: Text.QtRendering
            font.pointSize: 20
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.capitalization: Font.MixedCase
            anchors.left: parent.left
            anchors.leftMargin: 18
            font.italic: false
        }

        RoundButton {
            x: 150
            y: 0
            width: 38
            height: 38
            text: "*"
            clip: false
            anchors.verticalCenterOffset: 1
            font.family: "cmsy10"
            bottomPadding: 5
            font.bold: false
            anchors.right: parent.right
            topPadding: 28
            font.pointSize: 19
            rightPadding: 12
            anchors.verticalCenter: parent.verticalCenter
            anchors.rightMargin: 10
            font.capitalization: Font.AllLowercase

            onClicked: {
                openMainUI()
                infoUI.visible = false
            }

        }

        Label {
            id: label1
            y: 22
            color: "#ffffff"
            text: "Information"
            anchors.verticalCenterOffset: 2
            verticalAlignment: Text.AlignTop
            font.bold: false
            font.family: "cmmi10"
            textFormat: Text.AutoText
            renderType: Text.QtRendering
            font.pointSize: 20
            horizontalAlignment: Text.AlignLeft
            anchors.verticalCenter: parent.verticalCenter
            font.capitalization: Font.MixedCase
            anchors.left: parent.left
            anchors.leftMargin: 116
            font.italic: false
        }
        anchors.topMargin: 0
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.leftMargin: 0
        Material.primary: "#413a48"
    }

    Button {
        id: button_storageInfo
        x: 20
        y: 188
        width: 248
        height: 279
        text: qsTr("storage")
        font.capitalization: Font.AllUppercase
        rightPadding: 120
        bottomPadding: 230
        font.pointSize: 17
        font.family: "CMU Concrete"
    }

    Button {
        id: button_projectCount
        x: 20
        y: 54
        width: 248
        height: 61
        text: qsTr("projects")
        font.capitalization: Font.AllUppercase
        font.family: "CMU Concrete"
        bottomPadding: 20
        font.pointSize: 17
        rightPadding: 110

        Label {
            id: label_projectCount
            x: 143
            y: 15
            width: 93
            height: 35
            text: qsTr("000")
            rightPadding: 5
            font.italic: true
            font.family: "CMU Typewriter Text"
            font.pointSize: 20
            horizontalAlignment: Text.AlignRight
        }
    }

    Button {
        id: button_remoteCount
        x: 20
        y: 121
        width: 248
        height: 61
        text: qsTr("remotes")
        Label {
            id: label_remoteCount
            x: 143
            y: 15
            width: 93
            height: 35
            text: qsTr("000")
            font.italic: true
            rightPadding: 5
            font.family: "CMU Typewriter Text"
            font.pointSize: 20
            horizontalAlignment: Text.AlignRight
        }
        bottomPadding: 20
        font.family: "CMU Concrete"
        rightPadding: 118
        font.pointSize: 17
        font.capitalization: Font.AllUppercase
    }

    Button {
        id: button_cpuInfo
        x: 285
        y: 54
        width: 497
        height: 61
        text: qsTr("cpu")
        bottomPadding: 20
        font.family: "CMU Concrete"
        rightPadding: 430
        font.pointSize: 17
        font.capitalization: Font.AllUppercase
    }

    Button {
        id: button_memoryInfo
        x: 285
        y: 121
        width: 497
        height: 61
        text: qsTr("memory")
        Label {
            id: label_memoryUsed
            x: 140
            y: 15
            width: 73
            height: 35
            text: qsTr("14.7")
            anchors.right: label_remoteCount2.left
            anchors.rightMargin: 5
            font.family: "CMU Typewriter Text"
            font.pointSize: 20
            rightPadding: 5
            horizontalAlignment: Text.AlignRight
            font.italic: true
        }

        Label {
            id: label_remoteCount2
            y: 15
            width: 22
            height: 35
            text: qsTr("/")
            anchors.left: parent.left
            anchors.leftMargin: 215
            font.family: "CMU Typewriter Text"
            rightPadding: 5
            font.pointSize: 20
            horizontalAlignment: Text.AlignRight
            font.italic: true
        }

        Label {
            id: label_memoryTotal
            y: 15
            width: 73
            height: 35
            text: qsTr("16.9")
            anchors.left: label_remoteCount2.right
            anchors.leftMargin: 5
            font.family: "CMU Typewriter Text"
            rightPadding: 5
            font.pointSize: 20
            horizontalAlignment: Text.AlignLeft
            font.italic: true
        }

        Label {
            y: 24
            width: 37
            height: 23
            text: qsTr("GiB")
            font.capitalization: Font.MixedCase
            font.family: "CMU Typewriter Text"
            font.pointSize: 15
            rightPadding: 5
            horizontalAlignment: Text.AlignLeft
            anchors.left: label_memoryTotal.right
            anchors.leftMargin: -2
            font.italic: false
        }

        Label {
            x: 461
            y: 19
            width: 27
            height: 33
            text: qsTr("%")
            font.bold: false
            font.capitalization: Font.MixedCase
            anchors.right: parent.right
            anchors.rightMargin: 9
            font.family: "cmr10"
            font.pointSize: 20
            rightPadding: 5
            horizontalAlignment: Text.AlignLeft
            font.italic: true
        }

        Label {
            id: label_memoryPercent
            x: 425
            y: 14
            width: 32
            height: 35
            text: qsTr("32")
            anchors.right: label_remoteCount5.left
            anchors.rightMargin: 0
            font.family: "CMU Typewriter Text"
            font.pointSize: 20
            rightPadding: 5
            horizontalAlignment: Text.AlignLeft
            font.italic: true
        }
        font.family: "CMU Concrete"
        bottomPadding: 20
        font.pointSize: 17
        rightPadding: 370
        font.capitalization: Font.AllUppercase
    }



}

/*##^##
Designer {
    D{i:13;anchors_x:219}D{i:14;anchors_x:241}D{i:15;anchors_x:303}D{i:16;anchors_height:35;anchors_width:73;anchors_x:381;anchors_y:13}
D{i:17;anchors_x:382}
}
##^##*/
