import QtQuick 2.6
import QtQuick.Window 2.6
import QtQuick.Controls 2.2
import QtMultimedia 5
import Qt.labs.folderlistmodel 1

Window { id: app

    title: qsTr("Hello World")
    width: 800
    height: 480
    color: "#2c2c2c"
    visible: true

    // z-height reserved for items which must always be on top
    property int forceTop: 1000


    // MODE properties and methods
    property int numModes: 3
    property int mode: 0
    property string modeName: "IMG"
    property var modeList: ["IMG", "VID", "LPS"]

    function switchMode() {
        app.mode = app.mode >= app.numModes - 1 ? 0 : app.mode + 1
        app.updateModeName()
    }

    function updateModeName() {
        app.modeName = app.modeList[app.mode]
    }


    // TRIG properties and methods
    property int numTrigs: 3
    property int trig: 0
    property string trigName: "USR"
    property var trigList: ["USR", "EXT", "TMR"]

    function switchTrig() {
        app.trig = app.trig >= app.numTrigs - 1 ? 0 : app.trig + 1
        app.updateTrigName()
    }

    function updateTrigName() {
        app.trigName = app.trigList[app.trig]
    }


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
    property string projectPath: "/home/zarya/Projects/"
    property string currentProject: "example"
    property string selectedProject: projectPath + currentProject
    property int currentPhoto: countIMG.count
    property int currentVideo: countVID.count
    property int currentLapse: countLPS.count


    function capturePhoto() {
        camera.imageCapture.captureToLocation(app.selectedProject + "/IMG_" + (("000" + app.currentPhoto).slice(-4)))
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

    function captureLapseFrame() {
        app.switchStatus(1)
    }

    function startRecording() {
        app.switchStatus(2)
        camera.videoRecorder.record()
    }

    function stopRecording() {
        app.switchStatus(0)
        camera.videoRecorder.stop()
    }

    function startTimedRecording() {

    }

    function stopTimedRecording() {

    }

    function startEXTRecording() {

    }

    function stopEXTRecording() {

    }

    function toggleVideoState() {
        if (app.statusName == "IDLE") {
            app.startRecording()
        } else if (app.statusName == "RECORDING") {
            app.stopRecording()
        }
    }

    FolderListModel { id: countIMG
        folder: app.selectedProject
        nameFilters: ["IMG_*"]
    }

    FolderListModel { id: countVID
        folder: app.selectedProject
        nameFilters: ["VID_*"]
    }

    FolderListModel { id: countLPS
        folder: app.selectedProject
        nameFilters: ["LPS_*"]
    }

    // Timer object for timed capture control
    Timer { id: timer
        interval: 60000
        running: false
        repeat: true
        onTriggered: {
            app.modeName == "IMG" ? capturePhoto() : app.modeName == "VID" ? toggleVideoState() : captureLapseFrame()
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
            text: qsTr(mainBar.currentMenuName)
            topPadding: 9
            font.family: "Courier"
            anchors.left: backButton.right
            anchors.leftMargin: 0
            anchors.right: toolButton1.left
            anchors.rightMargin: 0
            font.pointSize: 19
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0
        }

        ToolButton {
            id: toolButton1
            x: 12
            y: 0
            text: qsTr("⋮")
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

        Label {
            id: label1
            color: "#ffffff"
            text: qsTr("TRIGGER")
            anchors.top: parent.top
            anchors.topMargin: 9
            font.pointSize: 19
            font.family: "Courier"
            anchors.horizontalCenterOffset: -36
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            id: label2
            color: "#ffffff"
            text: qsTr("EXT")
            font.family: "Courier"
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 40
        }

        Label {
            id: label3
            color: "#ffffff"
            text: qsTr("GPIO")
            font.family: "Courier"
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
            value: 10
            bottomPadding: 1
            topPadding: 20
            font.pointSize: 20
            font.family: "Courier"
            to: 15
            editable: false
            scale: 0.6
        }

        Label {
            id: label4
            color: "#ffffff"
            text: qsTr("On...")
            font.family: "Courier"
            anchors.top: parent.top
            anchors.topMargin: 99
            anchors.left: parent.left
            anchors.leftMargin: 15
        }

        ComboBox { id: extEdgeCombo
            x: 64
            y: 84
            width: 130
            height: 40
            editable: false
            padding: 0
            topPadding: 0
            font.pointSize: 14
            font.family: "Courier"
            flat: false
            textRole: ""
            currentIndex: 0
            scale: 0.6
            model: ["RISE", "FALL"]
        }

        Label {
            id: label5
            color: "#ffffff"
            text: qsTr("TMR")
            font.family: "Courier"
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
            font.family: "Courier"
        }

        Tumbler { id: minTumbler
            x: 70
            y: 170
            width: 36
            height: 116
            font.wordSpacing: 0
            font.italic: true
            font.pointSize: 13
            font.family: "Courier"
            font.weight: Font.Black
            font.bold: false
            visibleItemCount: 6
            model: 60
        }

        Tumbler { id: secTumbler
            x: 112
            y: 170
            width: 36
            height: 116
            font.italic: true
            font.weight: Font.Black
            model: 60
            visibleItemCount: 6
            font.wordSpacing: 0
            font.bold: false
            font.pointSize: 13
            font.family: "Courier"
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
            font.family: "Courier"
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
            font.family: "Courier"
        }

        //
    }


    // Control menu pane
    Pane { id: controlPane
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

        property string menuTitle: "Control"

        // Photo capturing button
        Button { id: captureButton
            width: 150
            text: {
                app.statusName == "IDLE"
                        ?
                            app.trigName == "USR"
                                ?
                                    qsTr("CAPTURE")
                                :
                                    app.trigName == "TMR"
                                        ?
                                            qsTr("START\nTIMED\nCAPTURE")
                                        :
                                            qsTr("START\nEXT\nCAPTURE")
                        :
                            app.trigName == "USR"
                                ?
                                    qsTr("CAPTURE")
                                :
                                    app.trigName == "TMR"
                                        ?
                                            qsTr("STOP\nTIMED\nCAPTURE")
                                        :
                                            qsTr("STOP\nEXT\nCAPTURE")
            }
            wheelEnabled: false
            font.family: "Courier"
            font.pointSize: 23
            bottomPadding: 0
            rightPadding: 0
            leftPadding: 0
            topPadding: 10
            anchors.top: toolSeparator.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            visible: app.modeName == "IMG"
            enabled: app.modeName == "IMG"
            onClicked: {
                app.statusName == "IDLE"
                        ?
                            app.trigName == "USR" ? app.capturePhoto() : app.trigName == "TMR" ? app.captureTimedPhotos() : app.captureEXTPhotos()
                        :
                            app.trigName == "TMR" ? app.stopTimedPhotos() : app.stopEXTPhotos()
            }
        }

        Button { id: recordButton
            width: 150
            text: {
                app.statusName == "IDLE"
                        ?
                            app.trigName == "USR"
                                ?
                                    qsTr("RECORD")
                                :
                                    app.trigName == "TMR"
                                        ?
                                            qsTr("START\nTIMED\nRECORD")
                                        :
                                            qsTr("START\nEXT\nRECORD")
                        :
                            app.trigName == "USR"
                                ?
                                    qsTr("STOP")
                                :
                                    app.trigName == "TMR"
                                        ?
                                            qsTr("STOP\nTIMED\nRECORD")
                                        :
                                            qsTr("STOP\nEXT\nRECORD")
            }
            font.family: "Courier"
            font.pointSize: 23
            bottomPadding: 0
            rightPadding: 0
            leftPadding: 0
            topPadding: 10
            anchors.top: toolSeparator.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            visible: app.modeName == "VID"
            enabled: app.modeName == "VID"
            onClicked: {
                app.statusName == "IDLE"
                        ?
                            app.trigName == "USR" ? app.startRecording() : app.trigName == "TMR" ? app.startTimedRecording() : app.startEXTRecording()
                        :
                            app.trigName == "USR" ? app.stopRecording() : app.trigName == "TMR" ? app.stopTimedRecording() : app.stopEXTRecording()
            }
        }

        Button { id: lapseButton
            width: 150
            text: qsTr("LAPSE")
            font.family: "Courier"
            font.pointSize: 23
            bottomPadding: 0
            rightPadding: 0
            leftPadding: 0
            topPadding: 10
            anchors.top: toolSeparator.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            visible: app.modeName == "LPS"
            enabled: app.modeName == "LPS"
        }

        ToolSeparator {
            id: toolSeparator
            y: 235
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            orientation: Qt.Horizontal
        }

        Button { id: modeButton
            x: 10
            y: 12
            width: 72
            height: 64
            text: qsTr("MODE")
            font.bold: false
            topPadding: 12
            font.family: "Courier"
            font.pointSize: 15
            enabled: app.statusName == "IDLE"
            onClicked: {
                app.switchMode()
                if (app.modeName == "VID") {
                    app.trig = 0
                    app.updateTrigName()
                } else if (app.modeName == "LPS") {
                    app.trig = 0
                    app.updateTrigName()
                }
            }
        }

        Button { id: trigButton
            x: 94
            y: 12
            width: 72
            height: 64
            text: qsTr("TRIG")
            font.family: "Courier"
            topPadding: 12
            font.pointSize: 15
            enabled: app.statusName == "IDLE" & app.modeName != "VID"
            onClicked: {
                app.switchTrig()
            }
        }

        Button { id: overlaysButton
            x: 10
            y: 87
            width: 156
            height: 64
            text: qsTr("OVERLAYS")
            topPadding: 12
            font.pointSize: 15
            font.bold: false
            font.family: "Courier"
            enabled: false
            onClicked: {
                stack.pop()
            }
        }

        Button { id: optionsButton
            x: 10
            y: 162
            width: 156
            height: 64
            text: qsTr("OPTIONS")
            topPadding: 12
            font.pointSize: 15
            font.bold: false
            font.family: "Courier"
            enabled: app.statusName == "IDLE"
            onClicked: {
                stack.push(optionsPane)
                mainBar.currentMenuName = "Options"
            }
        }
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

        Label { id: nameLabel
            x: 5
            y: 0
            color: "#ffffff"
            text: app.currentProject
            font.capitalization: Font.MixedCase
            font.pointSize: 11
            verticalAlignment: Text.AlignBottom
            horizontalAlignment: Text.AlignLeft
            font.family: "Courier"
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
            font.family: "Courier"
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
            font.family: "Courier"
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
            font.family: "Courier"
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
            font.family: "Courier"
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
            font.family: "Courier"
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
            font.family: "Courier"
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
        visible: stack.subapp == "control"

        state: {
            app.modeName == "VID" ? "VideoCapture" : "PhotoCapture"
        }

        states: [
            State {
                name: "PhotoCapture"
                StateChangeScript {
                    script: {
                        camera.stop()
                        camera.captureMode = Camera.CaptureStillImage
                        camera.start()
                    }
                }
            },
            State {
                name: "VideoCapture"
                StateChangeScript {
                    script: {
                        camera.stop()
                        camera.captureMode = Camera.CaptureVideo
                        camera.start()
                    }
                }
            }
        ]

        Camera {
            id: camera

            imageProcessing.whiteBalanceMode: CameraImageProcessing.WhiteBalanceFlash

            exposure {
                exposureCompensation: -1.0
                exposureMode: Camera.ExposurePortrait
            }

            flash.mode: Camera.FlashRedEyeReduction

            videoRecorder.muted: true
            videoRecorder.outputLocation: app.selectedProject + "/VID_" + ("000" + app.currentVideo).slice(-4)
            videoRecorder.frameRate: 30
            videoRecorder.mediaContainer: "mp4"

        }


        VideoOutput {
            source: camera
            fillMode: VideoOutput.PreserveAspectCrop
            anchors.fill: parent
            focus : visible // to receive focus and capture key events when visible
        }
    }


    // Project manager window
    Rectangle { id: projectUI
        x: 0
        y: 0
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
                color: "#ffffff"
                font.pointSize: 19
                font.bold: false
                font.family: "Courier"
                topPadding: 10
                leftPadding: 10
            }

            Text {
                anchors.right: parent.right
                anchors.rightMargin: 0
                z: app.forceTop + 1
                text: qsTr("Last modified")
                color: "#ffffff"
                font.pointSize: 19
                font.bold: false
                font.family: "Courier"
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
                    height: 50

                    color: fileName == app.currentProject ? "#fc9e32" : index % 2 == 0 ? "#a4a4a4" : "#444444"

                    Text { id: fileNameText
                        anchors.left: parent.left
                        anchors.leftMargin: 0
                        z: app.forceTop + 1
                        text: fileName
                        color: "#000000"
                        font.pointSize: 19
                        font.bold: false
                        font.family: "Courier"
                        topPadding: 15
                        leftPadding: 10
                    }

                    Text { id: fileModText
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        z: app.forceTop + 1
                        text: fileModified.toLocaleDateString(Qt.locale("en_US"), "d MMM yyyy")
                        color: "#000000"
                        font.pointSize: 19
                        font.bold: false
                        font.family: "Courier"
                        topPadding: 15
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
                folder: "/home/zarya/Projects/"
            }

        }


    }


    // Remote manager window
    Rectangle { id: remoteUI
        x: 0
        y: 0
        z: app.forceTop
        width: 600
        height: 460
        color: "#040404"
        visible: stack.subapp == "remote"


    }


    // Help documentation window
    Rectangle { id: helpUI
        x: 0
        y: 0
        z: app.forceTop
        width: 600
        height: 460
        color: "#040404"
        visible: stack.subapp == "help"


    }


    // System info window
    Rectangle { id: sysinfoUI
        x: 0
        y: 0
        z: app.forceTop
        width: 600
        height: 460
        color: "#040404"
        visible: stack.subapp == "sysinfo"


    }


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
    Pane { id: projectsPane
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
        visible: stack.subapp == "projects"

        property string menuTitle: "Projects"

        Button { id: newProjButton
            enabled: false
            width: 80
            height: 79
            text: "NEW"
            topPadding: 15
            font.pointSize: 24
            font.family: "Courier"
            display: AbstractButton.TextBesideIcon
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.topMargin: 3
            visible: true
        }

        Button { id: deleteProjButton
            enabled: false
            width: 80
            height: 79
            text: qsTr("DEL")
            topPadding: 15
            font.pointSize: 24
            font.family: "Courier"
            anchors.left: parent.left
            anchors.leftMargin: 95
            anchors.top: parent.top
            visible: true
            anchors.topMargin: 3

            onClicked: {
            }

        }

        ToolSeparator {
            id: toolSeparator6
            anchors.top: parent.top
            anchors.topMargin: 90
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0
            orientation: Qt.Horizontal
        }

        Button { id: selectProjButton
            width: 176
            height: 79
            text: "SELECT"
            anchors.left: parent.left
            anchors.leftMargin: 0
            topPadding: 15
            anchors.top: parent.top
            visible: true
            anchors.topMargin: 109
            display: AbstractButton.TextBesideIcon
            font.pointSize: 24
            font.family: "Courier"

            onClicked: {
                app.currentProject = projectListModel.get(listView.currentIndex, "fileName")
            }

        }

        ToolSeparator {
            id: toolSeparator7
            anchors.left: parent.left
            orientation: Qt.Horizontal
            anchors.leftMargin: 0
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 194
            anchors.rightMargin: 0
        }

        Button { id: openProjButton
            enabled: false
            width: 176
            height: 79
            text: "OPEN"
            anchors.left: parent.left
            anchors.leftMargin: 0
            topPadding: 15
            anchors.top: parent.top
            visible: true
            anchors.topMargin: 213
            font.pointSize: 24
            display: AbstractButton.TextBesideIcon
            font.family: "Courier"
        }
    }

    // Remote access/hosting/etc pane
    Pane { id: remotePane

    }

    // Help documentation for the user
    Pane { id: helpPane

    }

    // Display information about the system
    Pane { id: sysinfoPane

    }


    Menu { id: mainMenu

        MenuItem {
            text: "Projects"
            onTriggered: {
                stack.pop(null)
                stack.replace(projectsPane)
                stack.subapp = "projects"
                mainBar.currentMenuName = projectsPane.menuTitle
            }
        }

        MenuItem {
            text: "Control"
            onTriggered: {
                stack.pop(null)
                stack.replace(controlPane)
                stack.subapp = "control"
                mainBar.currentMenuName = controlPane.menuTitle
            }
        }

        MenuItem {
            text: "Remote"
            onTriggered: {
                stack.pop(null)
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
                stack.replace(sysinfoPane)
                stack.subapp = "sysinfo"
                mainBar.currentMenuName = sysinfoPane.menuTitle
            }
        }

    }

}

/*##^##
Designer {
    D{i:0;formeditorColor:"#4c4e50"}D{i:2;anchors_height:400;anchors_width:200;anchors_x:77;anchors_y:25}
D{i:6;anchors_height:150;anchors_width:166;anchors_x:0;anchors_y:267}D{i:7;anchors_height:150;anchors_width:166;anchors_x:0;anchors_y:267}
D{i:8;anchors_x:71}D{i:14;anchors_height:400;anchors_width:200}D{i:15;anchors_height:400;anchors_width:200;anchors_x:37;anchors_y:8}
D{i:16;anchors_height:400;anchors_width:200;anchors_x:37;anchors_y:8}D{i:17;anchors_x:130;anchors_y:8}
D{i:18;anchors_x:204}D{i:19;anchors_x:190}D{i:20;anchors_x:190}
}
##^##*/
