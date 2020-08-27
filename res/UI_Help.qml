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

	property string currentDoc: "main"

	ScrollView {
		x: 0
		y: 40
		width: 600
		height: 440
		background: Rectangle {
			color: "#261a20"
		}

		TextArea {
			x: 0
			y: 0
			width: 600
			height: 432
			wrapMode: Text.WordWrap
			font.family: "CMU Concrete"
			readOnly: true
			leftPadding: 10
			rightPadding: 25
			text: fileUtils.readFile(
					  "/usr/local/share/camctrl/docs/" + currentDoc + ".md")
			textFormat: TextArea.MarkdownText
			color: "white"
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
			text: "Documentation"
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

	Button {
		id: button_overviewHelp
		x: 620
		y: 49
		width: 159
		height: 65
		text: qsTr("OVERVIEW")
		rightPadding: 35
		bottomPadding: 20
		font.pointSize: 15
		font.family: "CMU Concrete"

		onClicked: {
			currentDoc = "main"
		}
	}

	Button {
		id: button_projectHelp
		x: 620
		y: 120
		width: 159
		height: 65
		text: qsTr("PROJECTS")
		font.pointSize: 15
		bottomPadding: 20
		font.family: "CMU Concrete"
		rightPadding: 39

		onClicked: {
			currentDoc = "project"
		}
	}

	Button {
		id: button_controlHelp
		x: 620
		y: 191
		width: 159
		height: 65
		text: qsTr("CONTROL")
		font.pointSize: 15
		bottomPadding: 20
		font.family: "CMU Concrete"
		rightPadding: 45

		onClicked: {
			currentDoc = "control"
		}
	}

	Button {
		id: button_remoteHelp
		x: 620
		y: 262
		width: 159
		height: 65
		text: qsTr("REMOTE")
		font.pointSize: 15
		bottomPadding: 20
		font.family: "CMU Concrete"
		rightPadding: 55

		enabled: false

		onClicked: {
			currentDoc = "remote"
		}
	}

	Button {
		id: button_configHelp
		x: 620
		y: 333
		width: 159
		height: 65
		text: qsTr("CONFIG")
		font.pointSize: 15
		bottomPadding: 20
		font.family: "CMU Concrete"
		rightPadding: 65

		onClicked: {
			currentDoc = "config"
		}
	}

	Button {
		id: button_licenseHelp
		x: 620
		y: 404
		width: 159
		height: 65
		text: qsTr("LICENSE")
		font.pointSize: 15
		bottomPadding: 20
		font.family: "CMU Concrete"
		rightPadding: 55

		onClicked: {
			currentDoc = "license"
		}
	}
}

/*##^##
Designer {
	D{i:3;anchors_height:439;anchors_width:600;anchors_x:6;anchors_y:19}D{i:2;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:12}
D{i:1;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:0}
}
##^##*/

