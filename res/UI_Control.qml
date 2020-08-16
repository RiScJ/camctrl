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

	property int remainingTime: app.delayTime

	ToolBar {
		id: statusBar
		background: Rectangle {
			color: "#000000"
			border.width: 0
		}
		x: 0
		y: 460
		z: app.forceTop // Always shown
		width: 600
		height: 20
		font.family: "CMU Typewriter Text"

		Label {
			id: nameLabel
			x: 5
			y: 0
			color: "#ffffff"
			text: app.currentProject
			font.capitalization: Font.MixedCase
			font.pointSize: 11
			verticalAlignment: Text.AlignBottom
			horizontalAlignment: Text.AlignLeft
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

		Label {
			id: modeLabel
			x: 130
			y: 0
			color: "#19ff1c"
			text: qsTr(app.modeName)
			anchors.left: toolSeparator1.right
			anchors.leftMargin: 1
			anchors.top: parent.top
			anchors.topMargin: -4
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 4
			font.capitalization: Font.AllUppercase
			topPadding: 3
			font.pointSize: 14
		}

		Label {
			id: trigLabel
			y: 0
			color: "#19ff1c"
			text: qsTr(app.trigName)
			anchors.left: toolSeparator2.right
			anchors.leftMargin: 0
			anchors.top: parent.top
			anchors.topMargin: -4
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 4
			topPadding: 3
			font.capitalization: Font.AllUppercase
			font.pointSize: 14
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

		Label {
			id: statusLabel
			x: 503
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
			anchors.topMargin: -4
			anchors.bottom: parent.bottom
			anchors.bottomMargin: 4
			anchors.right: parent.right
			anchors.rightMargin: 7
			topPadding: 3
			font.capitalization: Font.AllUppercase
			font.pointSize: 14
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
			text: "GPIO " + app.gpio
			anchors.left: toolSeparator3.right
			anchors.leftMargin: -3
			topPadding: 3
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.topMargin: -4
			anchors.bottomMargin: 4
			font.capitalization: Font.AllUppercase
			font.pointSize: 14
			visible: app.trigName == "EXT"
		}

		Label {
			id: tmrLabel
			y: 0
			color: "#74ccfe"
			text: Math.floor(
					  remainingTime / 60) + "\' " + remainingTime % 60 + "\""
			anchors.left: toolSeparator3.right
			anchors.leftMargin: 8
			topPadding: 3
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.topMargin: -4
			anchors.bottomMargin: 4
			font.capitalization: Font.AllUppercase
			font.pointSize: 14
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
			font.italic: false
			anchors.left: toolSeparator4.right
			anchors.leftMargin: 1
			topPadding: 3
			anchors.top: parent.top
			anchors.bottom: parent.bottom
			anchors.topMargin: -4
			anchors.bottomMargin: 4
			font.capitalization: Font.AllUppercase
			font.pointSize: 14
		}

		Label {
			id: label_edgeDB
			x: 342
			y: 1
			width: 15
			height: 24
			color: "#74ccfe"
			text: app.edge ? "d" : "b"
			font.bold: true
			font.family: "cmsy10"
			topPadding: 3
			font.pointSize: 10
			font.capitalization: Font.MixedCase
			visible: app.trigName == "EXT"
		}

		Label {
			id: label_edgeCE
			x: 341
			y: 1
			width: 15
			height: 24
			color: "#74ccfe"
			text: app.edge ? "c" : "e"
			font.family: "cmsy10"
			font.bold: true
			font.pointSize: 10
			topPadding: 3
			font.capitalization: Font.MixedCase
			visible: app.trigName == "EXT"
		}
	}

	Menu {
		id: modeMenu

		MenuItem {
			text: "Image"
			onTriggered: {
				app.modeName = "IMG"
			}
		}

		MenuItem {
			text: "Video"
			onTriggered: {
				app.modeName = "VID"
			}
		}

		MenuItem {
			text: "Timelapse"
			onTriggered: {
				app.modeName = "LPS"
			}
		}
	}

	Menu {
		id: trigMenu

		MenuItem {
			text: "Manual"
			onTriggered: {
				app.trigName = "USR"
			}
		}

		MenuItem {
			text: "External"
			onTriggered: {
				app.trigName = "EXT"
			}
		}

		MenuItem {
			text: "Timed"
			onTriggered: {
				app.trigName = "TMR"
			}
		}
	}

	Pane {
		x: 600
		y: 0
		width: 200
		height: 480
		Button {
			id: button_cycleMode
			x: 0
			y: 42
			width: 162
			height: 75
			text: qsTr("MODE")
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.horizontalCenterOffset: 0
			bottomPadding: 30
			font.family: "CMU Concrete"
			rightPadding: 75
			font.pointSize: 17

			onClicked: {
				modeMenu.popup()
			}
		}

		Button {
			id: button_cycleTrigger
			x: 1
			y: 123
			width: 162
			height: 75
			text: qsTr("TRIGGER")
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.horizontalCenterOffset: 0
			font.family: "CMU Concrete"
			bottomPadding: 30
			font.pointSize: 17
			rightPadding: 40

			onClicked: {
				trigMenu.popup()
			}
		}

		ToolSeparator {
			y: 199
			anchors.right: parent.right
			orientation: Qt.Horizontal
			anchors.rightMargin: 0
			anchors.left: parent.left
			anchors.leftMargin: 0
		}

		Button {
			id: button_addOverlay
			x: 2
			y: 224
			width: 162
			height: 75
			text: qsTr("OVERLAYS")
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.horizontalCenterOffset: 0
			bottomPadding: 30
			font.family: "CMU Concrete"
			rightPadding: 25
			font.pointSize: 17

			enabled: false
		}

		ToolSeparator {
			y: 299
			anchors.right: parent.right
			orientation: Qt.Horizontal
			anchors.rightMargin: 0
			anchors.left: parent.left
			anchors.leftMargin: 0
		}

		Button {
			id: button_capture
			x: 9
			y: 324
			width: 162
			height: 132
			text: {
				if (app.statusName == "IDLE") {
					if (app.modeName == "IMG") {
						"CAPTURE"
					} else if (app.modeName == "VID") {
						"RECORD"
					} else if (app.modeName == "LPS") {
						"LAPSE"
					}
				} else {
					"STOP"
				}
			}

			anchors.horizontalCenter: parent.horizontalCenter
			anchors.horizontalCenterOffset: 0
			font.family: "CMU Concrete"
			bottomPadding: 84
			font.pointSize: 17
			rightPadding: {
				if (app.statusName == "IDLE") {
					if (app.modeName == "IMG") {
						35
					} else if (app.modeName == "VID") {
						45
					} else if (app.modeName == "LPS") {
						70
					}
				} else {
					85
				}
			}

			enabled: !((app.modeName == "LPS" && app.trigName == "USR")
					   || (app.modeName == "VID" && app.trigName == "TMR"))

			onClicked: {
				if (text == "CAPTURE") {
					if (app.trigName == "TMR") {
						app.statusName = "LISTENING"
						timer.running = true
					} else if (app.trigName == "EXT") {
						app.statusName = "LISTENING"
						// do something to do the thing, you know
					} else if (app.trigName == "USR") {
						cam.capture(app.modeName)
					}
				} else if (text == "RECORD") {
					app.statusName = "RECORDING"
					cam.record()
				} else if (text == "LAPSE") {
					app.statusName = "LISTENING"
					app.modeName = "FRM"
					if (app.trigName == "TMR") {
						timer.running = true
					} else if (app.trigName == "EXT") {
						gpioUtils.trigger_frames(app.gpio, app.edge)
					}
					cam.start(app.modeName)
				} else if (text == "STOP") {
					app.statusName = "IDLE"
					if (app.modeName === "IMG") {
						timer.running = false
					} else if (app.modeName == "VID") {
						cam.record()
						cam.stop()
						cam.start(app.modeName)
					} else {
						app.modeName = "LPS"
						if (app.trigName == "TMR") {
							timer.running = false
						} else if (app.trigName == "EXT") {
							gpioUtils.stop_frames()
						}
						cam.stop()
						TimelapseUtils.stitch(app.selectedProject)
						cam.start(app.modeName)
					}
				}
			}
		}

		ToolBar {
			x: 162
			y: 72

			width: 200
			height: 40
			anchors.left: parent.left
			anchors.leftMargin: -12
			anchors.top: parent.top
			anchors.topMargin: -12

			Material.primary: "#413a48"

			Label {
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
		background: Rectangle {
			color: "#261a20"
			border.width: 0
		}
	}

	Rectangle {
		id: rectangle
		x: 0
		y: 0
		width: 600
		height: 460
		color: "#000000"
	}

	// Timer for timed triggering
	Timer {
		id: timer
		interval: app.delayTime * 1000
		running: false
		repeat: true
		onTriggered: {
			if (app.modeName === "IMG") {
				cam.capture(app.modeName)
			} else if (app.modeName === "VID") {

				// Will think of the "right way" to do this later
			} else if (app.modeName === "FRM") {
				app.capture(app.modeName)
			}
		}
	}

	// Timer to update remaining time until next trigger
	Timer {
		interval: 1000
		running: timer.running
		repeat: true
		onTriggered: {
			if (remainingTime == 0) {
				remainingTime = app.delayTime
			} else {
				remainingTime--
			}
		}
	}
}

/*##^##
Designer {
	D{i:3;invisible:true}D{i:4;invisible:true}D{i:5;invisible:true}D{i:6;invisible:true}
D{i:7;invisible:true}D{i:8;invisible:true}D{i:9;invisible:true}D{i:10;invisible:true}
D{i:12;invisible:true}D{i:13;invisible:true}D{i:14;invisible:true}D{i:15;anchors_width:14;anchors_x:346}
D{i:16;anchors_width:14;anchors_x:346}D{i:20;anchors_x:56}D{i:22;anchors_x:56}D{i:24;anchors_width:360}
D{i:25;anchors_x:66}
}
##^##*/

