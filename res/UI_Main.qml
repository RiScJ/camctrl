import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
    id: mainUI

    x: 0
    y: 0
    z: app.forceTop + 2
    width: 800
    height: 480
    color: "#1a2026"

//    visible: true
    enabled: visible

    signal openRemoteUI
    signal openProjectUI
    signal openControlUI
    signal openTriggerUI
    signal openHelpUI
    signal openInfoUI
    signal openSetupUI

    Label {
        width: 280
        height: 69
        color: "#e9e9e9"
        text: qsTr("camctrl")
        anchors.left: parent.left
        anchors.leftMargin: 26
        anchors.top: parent.top
        anchors.topMargin: 20
        font.family: "cmmi10"
        renderType: Text.QtRendering
        textFormat: Text.AutoText
        font.weight: Font.Normal
        font.capitalization: Font.MixedCase
        font.bold: false
        font.italic: false
        font.pointSize: 60
    }

    Button {
        id: button_openRemoteUI

        Material.background: "#2a3b3b"
        x: 353
        y: 272
        width: 249
        height: 178
        text: qsTr("Remote Sync")
        padding: 0
        leftPadding: 0
        topPadding: 0
        rightPadding: 52
        bottomPadding: 110
        font.pointSize: 17
        font.family: "CMU Concrete"

        onClicked: {
            openRemoteUI()
            mainUI.visible = false
        }

    }

    Button {
        id: button_openProjectUI

        Material.background: "#2a3b3b"
        x: 353
        y: 107
        width: 249
        height: 153
        text: qsTr("PROJECTS")
        bottomPadding: 85
        rightPadding: 100
        leftPadding: 0
        topPadding: 0
        font.italic: false
        font.pointSize: 17
        font.family: "CMU Concrete"
        font.bold: false
        font.capitalization: Font.MixedCase
        font.weight: Font.Normal

        onClicked: {
            openProjectUI()
            mainUI.visible = false
        }

    }

    Button {
        id: button_openControlUI

        Material.background: "#2a3b3b"
        x: 33
        y: 107
        width: 297
        height: 208
        text: qsTr("Control")
        padding: 0
        font.bold: false
        font.family: "CMU Concrete"
        bottomPadding: 145
        font.weight: Font.Normal
        font.pointSize: 17
        topPadding: 0
        rightPadding: 155
        font.capitalization: Font.AllUppercase
        font.italic: false
        leftPadding: 0

        onClicked: {
            openControlUI()
            mainUI.visible = false
        }

    }

    Button {
        id: button_openTriggerUI

        x: 33
        y: 327
        width: 297
        height: 123
        text: qsTr("TRIGGER SETUP")
        font.family: "CMU Concrete"
        bottomPadding: 55
        Material.background: "#2a3b3b"
        font.pointSize: 17
        rightPadding: 75
        topPadding: 0
        padding: 0
        leftPadding: 0

        onClicked: {
            openTriggerUI()
            mainUI.visible = false
        }

    }

    Button {
        id: button_openHelpUI

        x: 625
        y: 303
        width: 145
        height: 147
        text: qsTr("HELP")
        bottomPadding: 80
        font.family: "CMU Concrete"
        Material.background: "#2a3b3b"
        padding: 0
        topPadding: 0
        rightPadding: 60
        font.pointSize: 17
        leftPadding: 0

        onClicked: {
            openHelpUI()
            mainUI.visible = false
        }

    }

    Button {
        id: button_openInfoUI

        x: 625
        y: 189
        width: 145
        height: 100
        text: qsTr("INFO")
        font.family: "CMU Concrete"
        bottomPadding: 40
        Material.background: "#2a3b3b"
        font.pointSize: 17
        rightPadding: 70
        topPadding: 0
        padding: 0
        leftPadding: 0

        onClicked: {
            openInfoUI()
            mainUI.visible = false
        }

    }

    Button {
        id: button_openSetupUI

        x: 625
        y: 107
        width: 145
        height: 69
        text: qsTr("SETUP")
        bottomPadding: 10
        font.family: "CMU Concrete"
        Material.background: "#2a3b3b"
        padding: 0
        topPadding: 0
        rightPadding: 50
        font.pointSize: 17
        leftPadding: 0

        onClicked: {
            openSetupUI()
            mainUI.visible = false
        }

    }

    RoundButton {
        id: button_openMiscMenu

        Material.background: "#1a2026"
        x: 690
        y: 15
        width: 80
        height: 80
        text: "\u2630"
        bottomPadding: 7
        font.family: "CMU Bright"
        font.pointSize: 30

        onClicked: {
            miscMenu.popup()
        }

    }

    Menu {
        id: miscMenu

        MenuItem {
            text: "Beepboop"
            onTriggered: {

            }
        }

        MenuSeparator { }

        MenuItem {
            text: "Quit"
            onTriggered: {
                Qt.quit()
            }
        }

    }

}

/*##^##
Designer {
    D{i:1;anchors_x:16;anchors_y:17}
}
##^##*/
