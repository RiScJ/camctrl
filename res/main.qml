import QtQuick 2.6
import QtQuick.Window 2.6
import QtQuick.Controls 2.2
import QtMultimedia 5
import Qt.labs.folderlistmodel 1
import QtQuick.VirtualKeyboard 2.1


Window { id: app

    objectName: "root"

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

    // Timer object for timed capture control
    Timer { id: timer
        interval: optionsPane.delayTime
        running: false
        repeat: true
        onTriggered: {
            if (app.modeName === "IMG"){
                app.capturePhoto()
            } else if (app.modeName === "VID") {

            } else if (app.modeName === "FRM") {
                app.captureLapseFrame()
            }
        }
    }

    // Main menu toolbar
    ToolBar { id: mainBar
        x: 600
        y: 0
        width: 200
        height: 40

        property string currentMenuName: "Control"

        ToolButton { id: backButton
            y: 0
            text: stack.depth > 1 ? qsTr("‹") : qsTr("")
            anchors.left: parent.left
            anchors.leftMargin: 0
            enabled: stack.depth > 1
            onClicked: {
                mainBar.currentMenuName = stack.get(stack.currentItem.StackView.index - 1).menuTitle
        stack.pop()
            }
        }

        Label {
            id: label
            x: 0
            y: 0
            height: 30
            text: qsTr(mainBar.currentMenuName)
            font.italic: true
            font.weight: Font.DemiBold
            topPadding: 9
//            ////font.family: "Courier"
            anchors.left: backButton.right
            anchors.leftMargin: -3
            anchors.right: toolButton1.left
            anchors.rightMargin: 0
            font.pointSize: 19
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
        }

        ToolButton {
            id: toolButton1
            x: 12
            y: 0
            width: 48
            height: 40
            text: qsTr("⋮")
            font.bold: false
            font.pointSize: 17
            anchors.right: parent.right
            anchors.rightMargin: 0
            onClicked: {
                mainMenu.popup()
            }
        }
    }

    // Options menu pane
    Pane { id: optionsPane
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

        property string menuTitle: "Options"
        property int delayTime: 4000

        Label {
            id: label1
            color: "#ffffff"
            text: qsTr("Trigger Settings")
            font.capitalization: Font.SmallCaps
            font.weight: Font.Normal
            font.italic: true
            anchors.top: parent.top
            anchors.topMargin: 0
            font.pointSize: 20
//            //font.family: "Courier"
        }

        Label {
            id: label2
            color: "#ffffff"
            text: qsTr("External")
            font.italic: true
            //            //font.family: "Courier"
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 40
        }

        Label {
            id: label3
            color: "#ffffff"
            text: qsTr("GPIO")
//            //font.family: "Courier"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 65
        }

        SpinBox { id: gpioSpin
            x: 64
            y: 51
            width: 130
            height: 40
            font.capitalization: Font.MixedCase
            font.weight: Font.DemiBold
            font.italic: true
            value: 10
            bottomPadding: 1
            topPadding: 20
            font.pointSize: 20
//            //font.family: "Courier"
            to: 32
            editable: false
            scale: 0.6
        }

        Label {
            id: label4
            color: "#ffffff"
            text: qsTr("On...")
//            //font.family: "Courier"
            anchors.top: parent.top
            anchors.topMargin: 99
            anchors.left: parent.left
            anchors.leftMargin: 15
        }

        ComboBox { id: extEdgeCombo
            x: 64
            y: 84
            width: 130
            height: 50
            font.weight: Font.DemiBold
            font.italic: true
            editable: false
            padding: 0
            topPadding: 0
            font.pointSize: 16
//            //font.family: "Courier"
            flat: false
            textRole: ""
            currentIndex: 0
            scale: 0.6
            model: ["RISE", "FALL"]
        }

        Label {
            id: label5
            color: "#ffffff"
            text: qsTr("Timed")
            font.italic: true
            //            //font.family: "Courier"
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 150
        }

        Label {
            id: label6
            color: "#ffffff"
            text: qsTr("Delay")
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.top: parent.top
            anchors.topMargin: 170
//            //font.family: "Courier"
        }

        function formatText(count, modelData) {
                var data = count === 12 ? modelData + 1 : modelData;
                return data.toString().length < 2 ? "0" + data : data;
        }

        Component {
            id: tumblerDelegate

            Label {
                text: optionsPane.formatText(Tumbler.tumbler.count, modelData)
                opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
                color: "#000000"
                font.pointSize: 15
            }
        }

        Tumbler { id: minTumbler
            x: 70
            y: 170
            width: 36
            height: 116
            font.weight: Font.DemiBold
            font.wordSpacing: 0
            font.italic: true
//            //font.family: "Courier"
            visibleItemCount: 6
            model: 60

            delegate: tumblerDelegate
        }

        Tumbler { id: secTumbler
            x: 112
            y: 170
            width: 36
            height: 116
            font.weight: Font.DemiBold
            font.italic: true
            model: 60
            visibleItemCount: 6
            font.wordSpacing: 0
            //font.family: "Courier"

            delegate: tumblerDelegate
        }

        Label {
            id: label7
            x: 96
            y: 214
            color: "#ffffff"
            text: qsTr("'")
            font.italic: true
            font.bold: true
            font.pointSize: 15
            //font.family: "Courier"
        }

        Label {
            id: label8
            x: 140
            y: 214
            width: 26
            height: 21
            color: "#ffffff"
            text: qsTr("''")
            font.letterSpacing: -5
            font.italic: true
            font.pointSize: 15
            font.bold: true
            //font.family: "Courier"
        }

        //
    }

    // Control menu pane
    Pane_Controls {
        id: controlPane
    }

    // Status bar, gives user additional information about app states
    ToolBar { id: statusBar
        background: Rectangle {
            color: "#000000"
            border.width: 0
        }
        x: 0
        y: 460
        z: app.forceTop // Always shown
        width: 600
        height: 20
        font.family: "Courier"

        Label { id: nameLabel
            x: 5
            y: 0
            color: "#ffffff"
            text: app.currentProject
            font.family: "Courier"
            font.capitalization: Font.MixedCase
            font.pointSize: 11
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignLeft
            //font.family: "Courier"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        ToolSeparator {
            id: toolSeparator1
            x: 125
            y: 0
            scale: 1
            anchors.left: parent.left
            anchors.leftMargin: 125
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
        }

        Label { id: modeLabel
            x: 130
            y: 0
            color: "#19ff1c"
            text: qsTr(app.modeName)
            anchors.left: toolSeparator1.right
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            font.capitalization: Font.AllUppercase
            topPadding: 3
            font.pointSize: 14
            //font.family: "Courier"
        }

        Label { id: trigLabel
            y: 0
            color: "#19ff1c"
            text: qsTr(app.trigName)
            anchors.left: toolSeparator2.right
            anchors.leftMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            topPadding: 3
            font.capitalization: Font.AllUppercase
            font.pointSize: 14
            //font.family: "Courier"
        }

        ToolSeparator {
            id: toolSeparator2
            x: 185
            y: 0
            anchors.left: parent.left
            anchors.leftMargin: 185
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
        }

        ToolSeparator {
            id: toolSeparator3
            x: 242
            y: 0
            anchors.left: parent.left
            anchors.leftMargin: 242
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
        }

        Label { id: statusLabel
            y: 0
            color: {
                if (app.statusName == "IDLE") {
                    "#575c60"
                } else if (app.statusName == "CAPTURING") {
                    "#ff0000"
                } else if (app.statusName == "RECORDING") {
                    "#ff0000"
                } else if (app.statusName == "LISTENING") {
                    "#0000ff"
                }
            }
            text: qsTr(app.statusName)
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 5
            topPadding: 3
            font.capitalization: Font.AllUppercase
            font.pointSize: 14
            //font.family: "Courier"
        }

        ToolSeparator {
            id: toolSeparator4
            x: 247
            y: -2
            anchors.left: parent.left
            anchors.leftMargin: 345
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
        }

        Label {
            id: extLabel
            y: 0
            color: "#74ccfe"
            text: "GPIO " + gpioSpin.value.toString()
            anchors.left: toolSeparator3.right
            anchors.leftMargin: 5
            topPadding: 3
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            font.capitalization: Font.AllUppercase
            font.pointSize: 14
            //font.family: "Courier"
            visible: app.trigName == "EXT"
        }

        Label {
            id: tmrLabel
            y: 0
            color: "#74ccfe"
            text: minTumbler.currentIndex.toString() + "\' " + secTumbler.currentIndex.toString() + "\""
            anchors.left: toolSeparator3.right
            anchors.leftMargin: 5
            topPadding: 3
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            font.capitalization: Font.AllUppercase
            font.pointSize: 14
            //font.family: "Courier"
            visible: app.trigName == "TMR"
        }

        ToolSeparator {
            id: toolSeparator5
            x: 242
            y: 2
            anchors.left: parent.left
            anchors.leftMargin: 412
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
        }

        Label {
            id: countLabel
            y: 0
            color: "#d673ff"
            text: {
                if (app.modeName == "IMG") {
                   ("000" + app.currentPhoto).slice(-4)
                } else if (app.modeName == "VID") {
                    ("000" + app.currentVideo).slice(-4)
                } else if (app.modeName == "LPS") {
                    ("000" + app.currentLapse).slice(-4)
                } else if (app.modeName === "FRM") {
                    ("000" + app.currentFrame).slice(-4)
                } else {
                    console.log("ERROR: Unknown application mode.")
                }
            }
            anchors.left: toolSeparator4.right
            anchors.leftMargin: 4
            topPadding: 3
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            font.capitalization: Font.AllUppercase
            font.pointSize: 14
            //font.family: "Courier"
        }
    }

    // Camera viewframe
    Rectangle { id: cameraUI
        x: 0
        y: 0
        z: app.forceTop
        width: 600
        height: 460
        color: "#040404"
        visible: stack.subapp !== "projects" & stack.subapp !== "remote"

//        Camera {
//            id: camera

//            exposure {
//                exposureCompensation: 1.0
//                exposureMode: Camera.ExposurePortrait
//            }

//            videoRecorder {
//                muted: true
//                outputLocation: app.selectedProject + "/VID_" + ("000" + app.currentVideo).slice(-4)
//                frameRate: 30
//            }

//        }

//        VideoOutput {
//            source: camera
//            fillMode: VideoOutput.PreserveAspectCrop
//            anchors.fill: parent
//        }
    }

    // Project manager window
    ProjectUI {
        id: projectUI
        x: 0
        y: 0
    }

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
            font.weight: Font.DemiBold
            font.italic: true
            topPadding: 14
            font.bold: false
            font.pointSize: 15
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
            font.weight: Font.DemiBold
            font.italic: true
            topPadding: 14
            font.pointSize: 15
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

    // Remote manager window
    Rectangle { id: remoteUI
        x: 0
        y: 0
        z: app.forceTop - 1
        width: 600
        height: 460
        color: "#ffffff"
        visible: stack.subapp == "remote" | mainBar.currentMenuName == "Sync"

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
            font.italic: true
            topPadding: 14
            font.bold: false
            font.pointSize: 15
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
            font.italic: true
            topPadding: 14
            font.pointSize: 15
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

    UI_Remote_Config {
         id: configRemoteUI
    }

    // Help documentation window
    UI_Help { id: helpUI
        visible: stack.subapp == "help"
    }

    // Control pane stack
    StackView {
        id: stack
        x: 600
        y: 40
        width: 200
        height: 440
        initialItem: controlPane

        property string subapp: "control"

    }

    // Project manager control pane
    Pane_Projects {
        id: projectsPane
        visible: stack.subapp == "projects"
    }

    // Remote access/hosting/etc pane
    Pane_Remote {
        id: remotePane
        visible: stack.subapp == "remote"
    }

    // Help documentation for the user
    Pane_Help {
        id: helpPane
        visible: stack.subapp == "help"
    }

    // Display information about the system
    Pane_SysInfo {
        id: sysinfoPane
        visible: stack.subapp == "sysinfo"
    }

    Pane_Sync {
        id: syncPane
    }

    Menu { id: mainMenu

        MenuItem {
            text: "Projects"
            onTriggered: {
                stack.pop(null)
        cam.stop()
                stack.replace(projectsPane)
                stack.subapp = "projects"
                mainBar.currentMenuName = projectsPane.menuTitle
            }
        }

        MenuItem {
            text: "Control"
            onTriggered: {
                stack.pop(null)
        if (stack.subapp !== "control") {
            cam.start(app.modeName)
        }
                stack.replace(controlPane)
                stack.subapp = "control"
                mainBar.currentMenuName = controlPane.menuTitle
            }
        }

        MenuItem {
            text: "Remote"
            onTriggered: {
                stack.pop(null)
                cam.stop()
        stack.replace(remotePane)
                stack.subapp = "remote"
                mainBar.currentMenuName = remotePane.menuTitle
            }
        }

        MenuSeparator { }

        MenuItem {
            text: "Help"
            onTriggered: {
                stack.pop(null)
        cam.stop()
                stack.replace(helpPane)
                stack.subapp = "help"
                mainBar.currentMenuName = helpPane.menuTitle
            }
        }

        MenuSeparator { }

        MenuItem {
            text: "SysInfo"
            onTriggered: {
                stack.pop(null)
        cam.stop
                stack.replace(sysinfoPane)
                stack.subapp = "sysinfo"
                mainBar.currentMenuName = sysinfoPane.menuTitle
            }
        }

    }

//    InputPanel {
//            id: inputPanel
//            y: Qt.inputMethod.visible ? parent.height - inputPanel.height : parent.height
//            z: app.forceTop + 10
//            anchors.left: parent.left
//            anchors.right: parent.right
//    }

}



/*##^##
Designer {
    D{i:0;formeditorColor:"#4c4e50"}D{i:2;anchors_height:400;anchors_width:200;anchors_x:77;anchors_y:25}
D{i:5;invisible:true}D{i:7;anchors_height:150;anchors_width:166;anchors_x:0;anchors_y:267;invisible:true}
D{i:8;anchors_x:71}D{i:9;invisible:true}D{i:6;anchors_height:150;anchors_width:166;anchors_x:0;anchors_y:267;invisible:true}
D{i:14;anchors_height:400;anchors_width:200}D{i:15;anchors_height:400;anchors_width:200;anchors_x:37;anchors_y:8}
D{i:16;anchors_height:400;anchors_width:200;anchors_x:37;anchors_y:8}D{i:17;anchors_x:130;anchors_y:8}
D{i:18;anchors_x:204}D{i:19;anchors_x:190}D{i:20;anchors_x:190}D{i:23;invisible:true}
D{i:10;invisible:true}D{i:26;invisible:true}D{i:33;invisible:true}D{i:27;invisible:true}
D{i:41;invisible:true}D{i:42;invisible:true}D{i:46;invisible:true}D{i:43;invisible:true}
D{i:47;invisible:true}D{i:58;invisible:true}D{i:59;invisible:true}D{i:57;invisible:true}
D{i:60;invisible:true}D{i:51;invisible:true}D{i:65;invisible:true}D{i:69;invisible:true}
D{i:70;invisible:true}D{i:71;invisible:true}D{i:72;invisible:true}D{i:73;invisible:true}
D{i:74;invisible:true}D{i:75;invisible:true}D{i:76;invisible:true}
}
##^##*/
