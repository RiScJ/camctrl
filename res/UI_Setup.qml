import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
	id: setupUI

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
			text: "Application"
			horizontalAlignment: Text.AlignLeft
			verticalAlignment: Text.AlignTop
			renderType: Text.QtRendering
			textFormat: Text.AutoText
			anchors.verticalCenterOffset: 2
			font.family: "cmmi10"
			font.bold: false
			font.pointSize: 20
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
				setupUI.visible = false
			}
		}

		Label {
			id: label1
			y: 22
			color: "#ffffff"
			text: "Configuration"
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
			anchors.leftMargin: 168
			font.italic: false
		}
		anchors.topMargin: 0
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.leftMargin: 0
		Material.primary: "#413a48"
	}

	Button {
		id: button_annotations
		x: 22
		y: 55
		width: 223
		height: 409
		text: qsTr("ANNOTATIONS")
		font.pointSize: 17
		bottomPadding: 350
		rightPadding: 30
		font.family: "CMU Concrete"

		CheckBox {
			id: check_annotateTime
			x: 14
			y: 70
			width: 178
			height: 41
			text: qsTr("Time")
			font.pointSize: 15

			onClicked: {
				cam.update_annotations(4 * (checkState - 1))
			}
		}

		CheckBox {
			id: check_annotateDate
			x: 14
			y: 117
			width: 178
			height: 41
			text: qsTr("Date")
			font.pointSize: 15

			onClicked: {
				cam.update_annotations(8 * (checkState - 1))
			}
		}

		CheckBox {
			id: check_annotateShutter
			x: 14
			y: 164
			width: 190
			height: 41
			text: qsTr("Shutter settings")
			font.pointSize: 15

			onClicked: {
				cam.update_annotations(16 * (checkState - 1))
			}
		}

		CheckBox {
			id: check_annotateCAF
			x: 14
			y: 211
			width: 178
			height: 41
			text: qsTr("CAF settings")
			font.pointSize: 15

			onClicked: {
				cam.update_annotations(32 * (checkState - 1))
			}
		}

		CheckBox {
			id: check_annotateGain
			x: 14
			y: 258
			width: 178
			height: 41
			text: qsTr("Gain settings")
			font.pointSize: 15

			onClicked: {
				cam.update_annotations(64 * (checkState - 1))
			}
		}

		CheckBox {
			id: check_annotateMotion
			x: 14
			y: 305
			width: 190
			height: 41
			text: qsTr("Motion settings")
			font.pointSize: 15

			onClicked: {
				cam.update_annotations(256 * (checkState - 1))
			}
		}

		CheckBox {
			id: check_annotateBlack
			x: 14
			y: 352
			width: 201
			height: 41
			text: qsTr("Black background")
			font.pointSize: 15

			onClicked: {
				cam.update_annotations(1024 * (checkState - 1))
			}
		}
	}

	Button {
		id: button_encodingRate
		x: 266
		y: 55
		width: 511
		height: 140
		text: qsTr("TIMELAPSE ENCODING RATE")
		bottomPadding: 80
		rightPadding: 150
		font.pointSize: 17
		font.family: "CMU Concrete"

		Slider {
			id: slider_encodingRate
			x: 8
			y: 68
			width: 353
			height: 48
			to: 240
			from: 1
			value: 30

			onMoved: {
				TimelapseUtils.update_encodingRate(Math.floor(value))
			}
		}

		Label {
			id: label_encodingRate
			x: 393
			y: 49
			width: 48
			height: 52
			text: Math.floor(slider_encodingRate.value)
			rightPadding: 5
			horizontalAlignment: Text.AlignRight
			font.pointSize: 30
			font.italic: true
			font.family: "CMU Typewriter Text"
		}

		Label {
			x: 436
			y: 68
			width: 48
			height: 52
			text: qsTr("fps")
			font.family: "CMU Typewriter Text"
			font.pointSize: 20
			rightPadding: 5
			horizontalAlignment: Text.AlignRight
			font.italic: true
		}
	}
}
