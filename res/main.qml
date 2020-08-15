import QtQuick 2.6
import QtQuick.Window 2.6
import QtQuick.Controls 2.2
import QtMultimedia 5
import Qt.labs.folderlistmodel 1
import QtQuick.VirtualKeyboard 2.1
import QtQuick.Controls.Material 2.0


Window {
    id: app
    objectName: "root"

    Material.theme: Material.Dark
    Material.accent: Material.Red
    Material.foreground: "#e9e9e9"
    Material.background: "#543c44"
    Material.primary: Material.BlueGrey

    title: qsTr("Hello World")
    width: 800
    height: 480
    color: "#2c2c2c"
    visible: true

    property int forceTop: 1000

    property string modeName: "IMG"
    property string trigName: "USR"
    property string statusName: "IDLE"

    property int delayTime: 60
    property int gpio: 3
    property bool edge: false

    // Capture properties and methods
    property string homeDir: "/home/pi/"

    property string projectPath: app.homeDir + ".camctrl/Projects/"
    property string currentProject: "example"
    property string selectedProject: projectPath + currentProject
    property int currentPhoto: countIMG.count
    property int currentVideo: countVID.count
    property int currentLapse: countLPS.count
    property int currentFrame: countFRM.count

    FolderListModel { id: countIMG
        folder: "file://" + app.selectedProject
        nameFilters: ["IMG_*"]
    }

    FolderListModel { id: countVID
        folder: "file://" + app.selectedProject
        nameFilters: ["VID_*"]
    }

    FolderListModel { id: countLPS
        folder: "file://" + app.selectedProject
        nameFilters: ["LPS_*"]
    }

    FolderListModel { id: countFRM
        folder: "file://" + app.selectedProject
        nameFilters: ["FRM_*"]
    }

    StackView {
        id: stack
        initialItem: mainUI
        anchors.fill: parent

        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }

        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }

        popEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 200
            }
        }

        popExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to:0
                duration: 200
            }
        }

    }

    UI_Main {
        id: mainUI

        onOpenRemoteUI: stack.push(remoteUI)
        onOpenProjectUI: stack.push(projectUI)
        onOpenControlUI: stack.push(controlUI)
        onOpenTriggerUI: stack.push(triggerUI)
        onOpenHelpUI: stack.push(helpUI)
        onOpenInfoUI: stack.push(infoUI)
        onOpenSetupUI: stack.push(setupUI)
    }

//    UI_Remote {
//        id: remoteUI
//    }

    UI_Project {
        id: projectUI

        onOpenMainUI: stack.pop()

        onNewProject: stack.push(newProjectUI)
        onDeleteProject: {
            deleteProjectUI.visible = true
            projectUI.enabled = false
        }
//        onSelectProject:
        onOpenProject: stack.push(openProjectUI)
    }

    UI_Project_New {
        id: newProjectUI

        onCancel: stack.pop()
    }

    UI_Project_Delete {
        id: deleteProjectUI

        onDone: projectUI.enabled = true
    }

    UI_Project_Open {
        id: openProjectUI
    }

    UI_Control {
        id: controlUI

        onOpenMainUI: stack.pop()
    }

//    UI_Trigger {
//        id: triggerUI

//        onOpenMainUI: stack.pop()
//    }

//    UI_Help {
//        id: helpUI

//        onOpenMainUI: stack.pop()
//    }

    UI_Info {
        id: infoUI

        onOpenMainUI: stack.pop()
    }

    UI_Setup {
        id: setupUI

        onOpenMainUI: stack.pop()
    }





    // Delete project window
    Rectangle { id: newRemoteUI
        x: 0
        y: 0
        z: app.forceTop + 2
        width: 800
        height: 480
        color: "#4e4e4e"
        visible: false

        TextField { id: newRemoteTextField
            enabled: newRemoteUI.visible
            y: 52
            height: 60
            z: app.forceTop + 5
            text: ""
            anchors.right: newRemoteCancelButton.left
            anchors.rightMargin: 15
            anchors.left: parent.left
            anchors.leftMargin: 40
            leftPadding: 15
            topPadding: 14
            font.pointSize: 17
            font.bold: false
            visible: true
            //font.family: "Courier"
            placeholderText: qsTr("New remote name")
        }

        Button { id: newRemoteCancelButton
            enabled: newRemoteUI.visible
            x: 533
            y: 52
            width: 100
            height: 60
            text: qsTr("CANCEL")
            topPadding: 14
            font.bold: false
            font.pointSize: 17
            //font.family: "Courier"
            anchors.right: newRemoteCreateButton.left
            anchors.rightMargin: 15

            onClicked: {
                newRemoteTextField.text = ""
                newRemoteUI.visible = false
            }
        }

        Button { id: newRemoteCreateButton
            enabled: newRemoteUI.visible
            x: 685
            y: 52
            width: 100
            height: 60
            text: qsTr("CREATE")
            topPadding: 14
            font.pointSize: 17
            //font.family: "Courier"
            anchors.right: parent.right
            anchors.rightMargin: 40

            onClicked: {
                fileUtils.touch(app.homeDir + ".camctrl/remote/" + newRemoteTextField.text + ".conf")
                newRemoteTextField.text = ""
                newRemoteUI.visible = false
            }
        }
    }

    Rectangle { id: delRemoteUI
        x: 100
        y: 150
        z: app.forceTop + 2
        width: 400
        height: 200
        color: "#000000"
        visible: false

        Label { id: deleteRemoteLabel
            x: 50
            y: 12
            z: app.forceTop + 2
            width: 300
            height: 30
            color: "#ffffff"
            text: qsTr("Are you sure you want to delete the\nhighlighted remote?\nThis cannot be undone.")
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 13
            //font.family: "Courier"
        }

        Button { id: confirmDeleteRemoteButton
            enabled: delRemoteUI.visible
            y: 70
            width: 170
            height: 107
            text: qsTr("CONFIRM")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.left: parent.left
            anchors.leftMargin: 20
            topPadding: 14
            font.bold: false
            font.pointSize: 17
            //font.family: "Courier"

            onClicked: {
                fileUtils.rm(app.homeDir + ".camctrl/remote/" + remoteListModel.get(remoteListView.currentIndex, "fileName"))
                delRemoteUI.visible = false
            }
        }

        Button { id: cancelDeleteRemoteButton
            enabled: delRemoteUI.visible
            x: 210
            y: 73
            width: 170
            height: 107
            text: qsTr("CANCEL")
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            topPadding: 14
            font.pointSize: 17
            //font.family: "Courier"

            onClicked: {
                delRemoteUI.visible = false
            }
        }
}




    InputPanel {
            id: inputPanel
            y: Qt.inputMethod.visible ? parent.height - inputPanel.height : parent.height
            z: app.forceTop + 10
            anchors.left: parent.left
            anchors.right: parent.right
    }

}

/*##^##
Designer {
    D{i:0;formeditorColor:"#4c4e50"}D{i:2;anchors_height:400;anchors_width:200;anchors_x:77;anchors_y:25}
D{i:6;anchors_height:150;anchors_width:166;anchors_x:0;anchors_y:267}D{i:7;anchors_height:150;anchors_width:166;anchors_x:0;anchors_y:267}
D{i:8;anchors_x:71}D{i:5;invisible:true}D{i:14;anchors_height:400;anchors_width:200}
D{i:15;anchors_height:400;anchors_width:200;anchors_x:37;anchors_y:8}D{i:16;anchors_height:400;anchors_width:200;anchors_x:37;anchors_y:8}
D{i:17;anchors_x:130;anchors_y:8}D{i:18;anchors_x:204}D{i:19;anchors_x:190}D{i:20;anchors_x:190}
D{i:9;invisible:true}D{i:23;invisible:true}D{i:33;invisible:true}D{i:47;invisible:true}
D{i:57;invisible:true}D{i:58;invisible:true}D{i:54;invisible:true}D{i:68;invisible:true}
D{i:69;invisible:true}D{i:70;invisible:true}D{i:71;invisible:true}D{i:72;invisible:true}
D{i:80;invisible:true}D{i:81;invisible:true}D{i:82;invisible:true}
}
##^##*/
