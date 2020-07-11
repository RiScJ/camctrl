import QtQuick 2.0
import QtQuick.Controls 2.2

Rectangle {
    x: 0
    y: 0
    z: app.forceTop + 2
    width: 800
    height: 480
    color: "#4e4e4e"
    visible: true

    Button { id: configRemoteCancelButton
        enabled: configRemoteUI.visible
        x: 534
        y: 36
        width: 110
        height: 152
        text: qsTr("CANCEL")
        topPadding: 14
        font.bold: false
        font.pointSize: 17
        font.family: "Courier"
        anchors.right: configRemoteCreateButton.left
        anchors.rightMargin: 20

        onClicked: {
            configRemoteUI.visible = false
        }
    }

    Button { id: configRemoteCreateButton
        enabled: configRemoteUI.visible
        x: 664
        y: 36
        width: 110
        height: 152
        text: qsTr("APPLY")
        topPadding: 14
        font.pointSize: 17
        font.family: "Courier"
        anchors.right: parent.right
        anchors.rightMargin: 26

        onClicked: {

        }
    }

    ComboBox { id: rCMD_Combo
        x: 39
        y: 36
        enabled: true
        topPadding: 0
        font.pointSize: 17
        font.italic: true
        font.family: "Courier"
        displayText: "rsync"
        textRole: ""
    }

    Label {
        id: label
        x: 265
        y: 100
        width: 22
        height: 32
        color: "#ffffff"
        text: qsTr("@")
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignTop
        font.bold: false
        font.italic: false
        font.family: "Courier"
        font.pointSize: 27
    }

    Label {
        id: label1
        x: 13
        y: 153
        width: 22
        height: 32
        color: "#ffffff"
        text: qsTr(":")
        font.bold: false
        font.pointSize: 27
        font.italic: false
        verticalAlignment: Text.AlignTop
        font.family: "Courier"
        horizontalAlignment: Text.AlignHCenter
    }

    Label {
        id: label2
        x: 211
        y: 44
        width: 22
        height: 32
        color: "#ffffff"
        text: qsTr("-")
        font.bold: false
        font.pointSize: 27
        font.italic: false
        verticalAlignment: Text.AlignTop
        font.family: "Courier"
        horizontalAlignment: Text.AlignHCenter
    }

    TextField {
        id: textField
        x: 239
        y: 36
        width: 273
        height: 40
        text: "avz"
        topPadding: 10
        font.italic: true
        font.pointSize: 17
        font.family: "Courier"
        placeholderText: qsTr("Text Field")
    }

    TextField {
        id: textField1
        x: 293
        y: 92
        width: 219
        height: 40
        text: "127.0.0.1"
        topPadding: 10
        font.italic: true
        font.pointSize: 17
        font.family: "Courier"
        placeholderText: qsTr("HOST")
    }

    TextField {
        id: textField2
        x: 39
        y: 92
        width: 219
        height: 40
        text: "pi"
        topPadding: 10
        font.italic: true
        font.pointSize: 17
        font.family: "Courier"
        placeholderText: qsTr("[USER]")
    }

    TextField {
        id: textField3
        x: 39
        y: 149
        width: 473
        height: 39
        text: "/example/destination"
        topPadding: 10
        font.italic: true
        font.pointSize: 17
        font.family: "Courier"
        placeholderText: qsTr("DEST")
    }
}
