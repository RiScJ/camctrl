import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
	id: infoUI

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
			text: "System"
			anchors.verticalCenterOffset: 2
			verticalAlignment: Text.AlignTop
			textFormat: Text.AutoText
			font.family: "cmmi10"
			font.bold: false
			renderType: Text.QtRendering
			font.pointSize: 20
			horizontalAlignment: Text.AlignLeft
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
				infoUI.visible = false
			}
		}

		Label {
			id: label1
			y: 22
			color: "#ffffff"
			text: "Information"
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
		id: button_storageInfo
		x: 20
		y: 188
		width: 248
		height: 279
		text: qsTr("storage")
		font.capitalization: Font.AllUppercase
		rightPadding: 120
		bottomPadding: 230
		font.pointSize: 17
		font.family: "CMU Concrete"

		Label {
			id: label_totalStorage
			x: 151
			y: 15
			text: Math.floor(fileUtils.totalStorage() / 1000000000)
			anchors.right: parent.right
			anchors.rightMargin: 56
		}

		Label {
			id: label_totalStorageUnit
			x: 200
			y: 22
			text: qsTr("GiB")
			font.capitalization: Font.MixedCase
			font.family: "CMU Typewriter Text"
			font.pointSize: 15
		}

		Label {
			x: 30
			y: 48
			text: qsTr("Projects")
			font.capitalization: Font.MixedCase
		}

		Label {
			x: 30
			y: 109
			text: qsTr("System")
			font.capitalization: Font.MixedCase
		}

		Label {
			x: 28
			y: 198
			text: qsTr("Available")
			font.capitalization: Font.MixedCase
		}

		ToolSeparator {
			y: 168
			anchors.right: parent.right
			anchors.rightMargin: 5
			anchors.left: parent.left
			anchors.leftMargin: 5
			orientation: Qt.Horizontal
		}

		Label {
			id: label_projectStorage
			x: 77
			y: 77
			width: 51
			height: 27
			text: Math.floor(fileUtils.dirSize(app.projectPath) / 1000000000)
			horizontalAlignment: Text.AlignRight
			font.italic: true
			font.family: "CMU Typewriter Text"
			font.pointSize: 15
			anchors.right: parent.right
			anchors.rightMargin: 150
		}

		Label {
			id: label_systemStorage
			x: 77
			y: 136
			width: 51
			height: 27
			text: Math.floor((fileUtils.totalStorage() - fileUtils.freeStorage(
								  )) / 1000000000)
			horizontalAlignment: Text.AlignRight
			font.family: "CMU Typewriter Text"
			anchors.right: parent.right
			font.pointSize: 15
			anchors.rightMargin: 150
			font.italic: true
		}

		Label {
			id: label_projectStorageUnit
			y: 77
			text: qsTr("GiB")
			anchors.left: label_projectStorage.right
			anchors.leftMargin: 15
			font.family: "CMU Typewriter Text"
			font.pointSize: 15
			font.capitalization: Font.MixedCase
		}

		Label {
			id: label_systemStorageUnit
			y: 136
			text: qsTr("GiB")
			font.family: "CMU Typewriter Text"
			font.pointSize: 15
			font.capitalization: Font.MixedCase
			anchors.left: label_systemStorage.right
			anchors.leftMargin: 15
		}

		Label {
			id: label_availableStorage
			x: 77
			y: 227
			width: 51
			height: 27
			text: Math.floor(fileUtils.freeStorage() / 1000000000)
			horizontalAlignment: Text.AlignRight
			font.family: "CMU Typewriter Text"
			anchors.right: parent.right
			font.pointSize: 15
			anchors.rightMargin: 150
			font.italic: true
		}

		Label {
			id: label_availableStorageUnit
			y: 227
			text: qsTr("GiB")
			font.family: "CMU Typewriter Text"
			font.pointSize: 15
			font.capitalization: Font.MixedCase
			anchors.left: label_availableStorage.right
			anchors.leftMargin: 15
		}

		Label {
			x: 212
			y: 81
			width: 18
			height: 20
			text: qsTr("%")
			font.family: "cmr10"
			anchors.right: parent.right
			font.pointSize: 15
			anchors.rightMargin: 18
			font.italic: true
		}

		Label {
			x: 212
			y: 140
			width: 18
			height: 20
			text: qsTr("%")
			font.family: "cmr10"
			anchors.right: parent.right
			font.pointSize: 15
			anchors.rightMargin: 18
			font.italic: true
		}

		Label {
			x: 212
			y: 231
			width: 18
			height: 20
			text: qsTr("%")
			font.family: "cmr10"
			anchors.right: parent.right
			font.pointSize: 15
			anchors.rightMargin: 18
			font.italic: true
		}

		Label {
			id: label_availableStoragePercent
			x: 186
			y: 227
			width: 31
			height: 27
			text: Math.floor(100 * fileUtils.freeStorage(
								 ) / fileUtils.totalStorage())
			font.family: "CMU Typewriter Text"
			anchors.right: parent.right
			font.pointSize: 15
			anchors.rightMargin: 31
			font.italic: true
		}

		Label {
			id: label_systemStoragePercent
			x: 186
			y: 136
			width: 31
			height: 27
			text: Math.floor(100 * (fileUtils.totalStorage(
										) - fileUtils.freeStorage(
										)) / fileUtils.totalStorage())
			font.family: "CMU Typewriter Text"
			anchors.right: parent.right
			font.pointSize: 15
			anchors.rightMargin: 31
			font.italic: true
		}

		Label {
			id: label_projectStoragePercent
			x: 186
			y: 77
			width: 31
			height: 27
			text: Math.floor(100 * fileUtils.dirSize(
								 app.projectPath) / fileUtils.totalStorage())
			font.family: "CMU Typewriter Text"
			anchors.right: parent.right
			font.pointSize: 15
			anchors.rightMargin: 31
			font.italic: true
		}
	}

	Button {
		id: button_projectCount
		x: 20
		y: 54
		width: 248
		height: 61
		text: qsTr("projects")
		font.capitalization: Font.AllUppercase
		font.family: "CMU Concrete"
		bottomPadding: 20
		font.pointSize: 17
		rightPadding: 110

		Label {
			id: label_projectCount
			x: 143
			y: 15
			width: 93
			height: 35
			text: app.projectCount
			rightPadding: 5
			font.italic: true
			font.family: "CMU Typewriter Text"
			font.pointSize: 20
			horizontalAlignment: Text.AlignRight
		}
	}

	Button {
		id: button_remoteCount
		x: 20
		y: 121
		width: 248
		height: 61
		text: qsTr("remotes")
		Label {
			id: label_remoteCount
			x: 143
			y: 15
			width: 93
			height: 35
			text: qsTr("000")
			font.italic: true
			rightPadding: 5
			font.family: "CMU Typewriter Text"
			font.pointSize: 20
			horizontalAlignment: Text.AlignRight
		}
		bottomPadding: 20
		font.family: "CMU Concrete"
		rightPadding: 118
		font.pointSize: 17
		font.capitalization: Font.AllUppercase

		enabled: false
	}

	Button {
		id: button_cpuInfo
		x: 285
		y: 54
		width: 497
		height: 61
		text: qsTr("cpu")
		bottomPadding: 20
		font.family: "CMU Concrete"
		rightPadding: 430
		font.pointSize: 17
		font.capitalization: Font.AllUppercase

		enabled: false
	}

	Button {
		id: button_memoryInfo
		x: 285
		y: 121
		width: 497
		height: 61
		text: qsTr("memory")
		Label {
			id: label_memoryUsed
			x: 140
			y: 15
			width: 73
			height: 35
			text: qsTr("14.7")
			anchors.right: label_remoteCount2.left
			anchors.rightMargin: 5
			font.family: "CMU Typewriter Text"
			font.pointSize: 20
			rightPadding: 5
			horizontalAlignment: Text.AlignRight
			font.italic: true
		}

		Label {
			id: label_remoteCount2
			y: 15
			width: 22
			height: 35
			text: qsTr("/")
			anchors.left: parent.left
			anchors.leftMargin: 215
			font.family: "CMU Typewriter Text"
			rightPadding: 5
			font.pointSize: 20
			horizontalAlignment: Text.AlignRight
			font.italic: true
		}

		Label {
			id: label_memoryTotal
			y: 15
			width: 73
			height: 35
			text: qsTr("16.9")
			anchors.left: label_remoteCount2.right
			anchors.leftMargin: 5
			font.family: "CMU Typewriter Text"
			rightPadding: 5
			font.pointSize: 20
			horizontalAlignment: Text.AlignLeft
			font.italic: true
		}

		Label {
			id: label_memoryUnit
			y: 24
			width: 37
			height: 23
			text: qsTr("GiB")
			font.capitalization: Font.MixedCase
			font.family: "CMU Typewriter Text"
			font.pointSize: 15
			rightPadding: 5
			horizontalAlignment: Text.AlignLeft
			anchors.left: label_memoryTotal.right
			anchors.leftMargin: -2
			font.italic: false
		}

		Label {
			x: 461
			y: 19
			width: 27
			height: 33
			text: qsTr("%")
			font.bold: false
			font.capitalization: Font.MixedCase
			anchors.right: parent.right
			anchors.rightMargin: 9
			font.family: "cmr10"
			font.pointSize: 20
			rightPadding: 5
			horizontalAlignment: Text.AlignLeft
			font.italic: true
		}

		Label {
			id: label_memoryPercent
			x: 425
			y: 14
			width: 32
			height: 35
			text: qsTr("32")
			font.family: "CMU Typewriter Text"
			font.pointSize: 20
			rightPadding: 5
			horizontalAlignment: Text.AlignLeft
			font.italic: true
		}
		font.family: "CMU Concrete"
		bottomPadding: 20
		font.pointSize: 17
		rightPadding: 370
		font.capitalization: Font.AllUppercase

		enabled: false
	}
}

/*##^##
Designer {
	D{i:11;anchors_x:13;anchors_y:172}D{i:14;anchors_x:129}D{i:15;anchors_x:130}D{i:17;anchors_x:134}
D{i:31;anchors_x:219}D{i:32;anchors_x:241}D{i:33;anchors_x:303}D{i:34;anchors_height:35;anchors_width:73;anchors_x:381;anchors_y:13}
D{i:35;anchors_x:382}
}
##^##*/

