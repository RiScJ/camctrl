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
    Material.background: Material.Teal
    Material.primary: Material.BlueGrey


    title: qsTr("Hello World")
    width: 800
    height: 480
    color: "#2c2c2c"
    visible: true

    // z-height reserved for items which must always be on top
    property int forceTop: 1000

    property string modeName: "IMG"
    property string trigName: "USR"

    // STATUS properties and methods
    property int numStatuses: 3
    property int status: 0
    property string statusName: "IDLE"
    property var statusList: ["IDLE", "CAPTURING", "RECORDING", "LISTENING"]

    function switchStatus(status) {
        app.status = status
        app.updateStatusName()
    }

    function updateStatusName() {
        app.statusName = app.statusList[app.status]
    }


    // Capture properties and methods
    property string homeDir: "/home/pi/"

    property string projectPath: app.homeDir + ".camctrl/Projects/"
    property string currentProject: "example"
    property string selectedProject: projectPath + currentProject
    property int currentPhoto: countIMG.count
    property int currentVideo: countVID.count
    property int currentLapse: countLPS.count
    property int currentFrame: countFRM.count


    function capturePhoto() {
        cam.capture(app.modeName)
    }

    function captureTimedPhotos() {
        app.switchStatus(1)
        timer.running = true
    }

    function captureEXTPhotos() {
        app.switchStatus(3)
    }

    function stopTimedPhotos() {
        app.switchStatus(0)
        timer.running = false
    }

    function stopEXTPhotos() {
        app.switchStatus(0)
    }

    function startRecording() {
        app.switchStatus(2)
        cam.record()
    }

    function stopRecording() {
        app.switchStatus(0)
        cam.record()
    cam.stop()
    cam.start(app.modeName)
    }

    function startTimedRecording() {

    }

    function stopTimedRecording() {

    }

    function startEXTRecording() {
        app.switchStatus(3)
    }

    function stopEXTRecording() {
        app.switchStatus(0)
    }

    function toggleVideoState() {
        if (app.statusName == "IDLE") {
            app.startRecording()
        } else if (app.statusName == "RECORDING") {
            app.stopRecording()
        }
    }

    function startLapse() {
        app.switchStatus(3)
        app.modeName = "FRM"
        if (app.trigName === "TMR") {
            timer.running = true
        } else if (app.trigName === "EXT") {
            gpioUtils.trigger_frames(gpioSpin.value, extEdgeCombo.currentIndex)
        }
    cam.start(app.modeName)
    }

    function captureLapseFrame() {
        cam.capture(app.modeName)
    }

    function stopLapse() {
        app.modeName = "LPS"
        app.switchStatus(0)
        if (app.trigName === "TMR") {
            timer.running = false
        } else if (app.trigName === "EXT") {
            gpioUtils.stop_frames()
        }

        cam.stop()
        TimelapseUtils.stitch(app.selectedProject)
        cam.start(app.modeName)
    }

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

//    // Timer object for timed capture control
//    Timer { id: timer
//        interval: optionsPane.delayTime
//        running: false
//        repeat: true
//        onTriggered: {
//            if (app.modeName === "IMG"){
//                app.capturePhoto()
//            } else if (app.modeName === "VID") {

//            } else if (app.modeName === "FRM") {
//                app.captureLapseFrame()
//            }
//        }
//    }


    /*
     * UI WINDOWS BE HERE
     *
     *
     */

    UI_Main {
        id: mainUI

        onOpenRemoteUI: remoteUI.visible = true
        onOpenProjectUI: projectUI.visible = true
        onOpenControlUI: controlUI.visible = true
        onOpenTriggerUI: triggerUI.visible = true
        onOpenHelpUI: helpUI.visible = true
        onOpenInfoUI: infoUI.visible = true
        onOpenSetupUI: setupUI.visible = true
    }

//    UI_Remote {
//        id: remoteUI
//    }

    UI_Project {
        id: projectUI

        onOpenMainUI: mainUI.visible = true
    }

    UI_Control {
        id: controlUI

        onOpenMainUI: mainUI.visible = true
    }

//    UI_Trigger {
//        id: triggerUI
//    }

//    UI_Help {
//        id: helpUI
//    }

//    UI_Info {
//        id: infoUI
//    }

//    UI_Setup {
//        id: setupUI
//    }

    /*
     *
     *
     *
     */







    // Status bar, gives user additional information about app states







    // New project window
    Rectangle { id: newProjectUI
        x: 0
        y: 0
        z: app.forceTop + 2
        width: 800
        height: 480
        color: "#4e4e4e"
        visible: false

        TextField { id: newProjTextField
            enabled: newProjectUI.visible
            y: 52
            height: 60
            z: app.forceTop + 5
            text: ""
            anchors.right: newProjCancelButton.left
            anchors.rightMargin: 15
            anchors.left: parent.left
            anchors.leftMargin: 40
            leftPadding: 15
            topPadding: 14
            font.pointSize: 17
            font.bold: false
            visible: true
            //font.family: "Courier"
            placeholderText: qsTr("New project name")
        }

        Button { id: newProjCancelButton
            enabled: newProjectUI.visible
            x: 533
            y: 52
            width: 100
            height: 60
            text: qsTr("CANCEL")
            topPadding: 14
            font.bold: false
            font.pointSize: 17
            //font.family: "Courier"
            anchors.right: newProjCreateButton.left
            anchors.rightMargin: 15

            onClicked: {
                newProjTextField.text = ""
                newProjectUI.visible = false
            }
        }

        Button { id: newProjCreateButton
            enabled: newProjectUI.visible
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
                fileUtils.mkdir(projectPath + newProjTextField.text)
                newProjTextField.text = ""
                newProjectUI.visible = false
            }
        }
    }

    // Delete project window
    Rectangle { id: delProjectUI
        x: 100
        y: 150
        z: app.forceTop + 2
        width: 400
        height: 200
        color: "#000000"
        visible: false

        Label { id: deleteProjectLabel
            x: 50
            y: 12
            z: app.forceTop + 2
            width: 300
            height: 30
            color: "#ffffff"
            text: qsTr("Are you sure you want to delete the\nhighlighted project?\nThis cannot be undone.")
            verticalAlignment: Text.AlignTop
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 13
            //font.family: "Courier"
        }

        Button { id: confirmDeleteProjectButton
            enabled: delProjectUI.visible
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
                fileUtils.removeDir(projectPath + projectListModel.get(listView.currentIndex, "fileName"))
                delProjectUI.visible = false
            }
        }

        Button { id: cancelDeleteProjectButton
            enabled: delProjectUI.visible
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
                delProjectUI.visible = false
            }
        }
}

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
