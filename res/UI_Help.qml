import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
	id: helpUI

	x: 0
	y: 0
	z: app.forceTop + 2
	width: 800
	height: 480
	color: "#1a2026"

	visible: false
	enabled: visible

	signal openMainUI

	ScrollView {
		x: 0
		y: 40
		width: 600
		height: 440
		background: Rectangle {
			anchors.fill: parent
			color: "#eeeeee"
		}

		TextArea {
			wrapMode: Text.WordWrap
			font.family: "Courier"
			readOnly: true
			text: fileUtils.readFile(app.homeDir + "camctrl/README.md")
			anchors.fill: parent
		}
	}

	ToolBar {
		id: toolBar
		width: 800
		height: 40
		Label {
			id: label
			y: 22
			color: "#ffffff"
			text: "uWu"
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
			}
		}
		anchors.topMargin: 0
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.leftMargin: 0
		Material.primary: "#413a48"
	}
}

/*##^##
Designer {
	D{i:2;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:12}D{i:3;anchors_height:439;anchors_width:600;anchors_x:6;anchors_y:19}
D{i:1;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:0}
}
##^##*/

