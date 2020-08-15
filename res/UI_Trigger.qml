import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
	id: triggerUI

	x: 0
	y: 0
	z: app.forceTop + 2
	width: 800
	height: 480
	color: "#1a2026"

	visible: false
	enabled: visible

	signal openMainUI

	function updateTimers() {
		app.delayTime = 60 * tumbler_delayMin.currentIndex + tumbler_delaySec.currentIndex
		app.durationTime = 60 * tumbler_durationMin.currentIndex + tumbler_durationSec.currentIndex
	}

	ToolBar {
		id: toolBar
		width: 800
		height: 40
		Label {
			id: label
			y: 22
			color: "#ffffff"
			text: "Trigger"
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
				updateTimers()
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
		id: button_gpioNumber
		x: 29
		y: 66
		width: 362
		height: 87
		text: qsTr("GPIO")
		rightPadding: 290
		bottomPadding: 40
		font.italic: false
		font.pointSize: 17
		font.family: "CMU Concrete"

		SpinBox {
			id: spin_gpioNumber
			x: 99
			y: 18
			width: 243
			height: 55
			value: 3
			to: 30
			topPadding: 52
			font.italic: true
			font.family: "CMU Typewriter Text"
			font.pointSize: 30

			onValueModified: {
				app.gpio = value
			}
		}
	}

	Button {
		id: button_gpioEdge
		x: 29
		y: 169
		width: 362
		height: 87
		text: qsTr("EDGE")
		font.family: "CMU Concrete"
		bottomPadding: 40
		font.pointSize: 17
		rightPadding: 281
		font.italic: false

		ComboBox {
			id: combo_gpioEdge
			x: 192
			y: 15
			width: 151
			height: 56
			topPadding: 3
			font.capitalization: Font.SmallCaps
			font.pointSize: 21
			font.family: "cmmi10"
			model: ["Falling", "Rising"]
			editable: false
			currentIndex: 0

			onCurrentIndexChanged: {
				app.edge = currentIndex
			}
		}
	}

	Button {
		id: button
		x: 418
		y: 66
		width: 351
		height: 190
		text: qsTr("TIMER")
		rightPadding: 250
		bottomPadding: 140
		font.pointSize: 17
		font.family: "CMU Concrete"

		Tumbler {
			id: tumbler_delayMin
			x: 112
			y: 16
			width: 40
			height: 162
			font.pointSize: 20
			font.italic: true
			font.family: "CMU Typewriter Text"
			currentIndex: 0
			visibleItemCount: 5
			model: 60
		}

		Tumbler {
			id: tumbler_delaySec
			x: 163
			y: 16
			width: 35
			height: 162
			font.pointSize: 20
			font.family: "CMU Typewriter Text"
			model: 60
			currentIndex: 0
			visibleItemCount: 5
			font.italic: true
		}

		Label {
			x: 155
			y: 82
			text: qsTr(":")
			font.family: "cmr10"
			font.pointSize: 20
		}

		Tumbler {
			id: tumbler_durationMin
			x: 231
			y: 16
			width: 40
			height: 162
			font.family: "CMU Typewriter Text"
			model: 60
			currentIndex: 0
			font.pointSize: 20
			visibleItemCount: 5
			font.italic: true
		}

		Tumbler {
			id: tumbler_durationSec
			x: 282
			y: 16
			width: 35
			height: 162
			font.family: "CMU Typewriter Text"
			model: 60
			currentIndex: 0
			font.pointSize: 20
			visibleItemCount: 5
			font.italic: true
		}

		Label {
			x: 274
			y: 82
			text: qsTr(":")
			font.family: "cmr10"
			font.pointSize: 20
		}
	}
}
