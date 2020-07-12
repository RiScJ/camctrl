import QtQuick 2.6
import QtQuick.Controls 2.2

Rectangle {
    x: 0
    y: 0
    z: app.forceTop + 2
    width: 800
    height: 480
    color: "#4e4e4e"
    visible: false

    property string cmd: rsync.getConfigParam((app.homeDir + ".camctrl/remote/" + remoteListModel.get(remoteListView.currentIndex, "fileName")), "CMD")
    property string flags: rsync.getConfigParam((app.homeDir + ".camctrl/remote/" + remoteListModel.get(remoteListView.currentIndex, "fileName")), "FLAGS")
    property string user: rsync.getConfigParam((app.homeDir + ".camctrl/remote/" + remoteListModel.get(remoteListView.currentIndex, "fileName")), "USER")
    property string host: rsync.getConfigParam((app.homeDir + ".camctrl/remote/" + remoteListModel.get(remoteListView.currentIndex, "fileName")), "HOST")
    property string dest: rsync.getConfigParam((app.homeDir + ".camctrl/remote/" + remoteListModel.get(remoteListView.currentIndex, "fileName")), "DEST")

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
        anchors.right: configRemoteApplyButton.left
        anchors.rightMargin: 20

        onClicked: {
            configRemoteUI.visible = false
        }
    }

    Button { id: configRemoteApplyButton
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
            rsync.setConfig(app.homeDir + ".camctrl/remote/" + remoteListModel.get(remoteListView.currentIndex, "fileName"),
                            rCMD_Combo.displayText,
                            rFLAGS_Text.text,
                            rUSER_Text.text,
                            rHOST_Text.text,
                            rDEST_Text.text
                            )
            configRemoteUI.visible = false
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

    TextField { id: rFLAGS_Text
        x: 239
        y: 36
        width: 273
        height: 40
        text: flags
        topPadding: 10
        font.italic: true
        font.pointSize: 17
        font.family: "Courier"
        placeholderText: qsTr("args")
    }

    TextField { id: rHOST_Text
        x: 293
        y: 92
        width: 219
        height: 40
        text: host
        topPadding: 10
        font.italic: true
        font.pointSize: 17
        font.family: "Courier"
        placeholderText: qsTr("HOST")
    }

    TextField { id: rUSER_Text
        x: 39
        y: 92
        width: 219
        height: 40
        text: user
        topPadding: 10
        font.italic: true
        font.pointSize: 17
        font.family: "Courier"
        placeholderText: qsTr("[USER]")
    }

    TextField { id: rDEST_Text
        x: 39
        y: 149
        width: 473
        height: 39
        text: dest
        topPadding: 10
        font.italic: true
        font.pointSize: 17
        font.family: "Courier"
        placeholderText: qsTr("DEST")
    }
}
