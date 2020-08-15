import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0
import Qt.labs.folderlistmodel 1.0

Rectangle {
	id: projectUI

	x: 0
	y: 0
	z: app.forceTop - 1
	width: 600
	height: 480
	color: "#261a20"

	visible: false
	enabled: visible

	signal openMainUI

	signal newProject
	signal deleteProject
	signal openProject

	function del() {
		fileUtils.removeDir(app.projectPath + projectListModel.get(
								listView.currentIndex, "fileName"))
	}

	function updateProjectCount() {
		app.projectCount = listView.count
	}

	Pane {
		id: pane
		background: Rectangle {
			color: "#261a20"
			border.width: 0
		}
		x: 600
		y: 0
		width: 200
		height: 480

		Button {
			id: button_newProject

			x: 0
			y: 42
			width: 162
			height: 75
			text: qsTr("NEW")
			rightPadding: 95
			bottomPadding: 30
			font.pointSize: 17
			font.family: "CMU Concrete"
			anchors.horizontalCenterOffset: 0
			anchors.horizontalCenter: parent.horizontalCenter

			onClicked: {
				newProject()
			}
		}

		Button {
			id: button_deleteProject

			x: 1
			y: 123
			width: 162
			height: 75
			text: qsTr("DELETE")
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.horizontalCenterOffset: 0
			font.family: "CMU Concrete"
			bottomPadding: 30
			font.pointSize: 17
			rightPadding: 55

			onClicked: {
				deleteProject()
			}
		}

		ToolSeparator {
			y: 199
			anchors.left: parent.left
			anchors.leftMargin: 0
			anchors.right: parent.right
			anchors.rightMargin: 0
			orientation: Qt.Horizontal
		}

		Button {
			id: button_selectProject

			x: 2
			y: 224
			width: 162
			height: 75
			text: qsTr("SELECT")
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.horizontalCenterOffset: 0
			bottomPadding: 30
			font.family: "CMU Concrete"
			rightPadding: 58
			font.pointSize: 17

			onClicked: {
				app.currentProject = projectListModel.get(
							listView.currentIndex, "fileName")
			}
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
			id: button_openProject

			x: 9
			y: 324
			width: 162
			height: 132
			text: qsTr("OPEN")
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.horizontalCenterOffset: 0
			bottomPadding: 84
			font.family: "CMU Concrete"
			rightPadding: 84
			font.pointSize: 17

			onClicked: {
				openProject()
			}
		}
	}

	Rectangle {
		id: projectListTitle
		x: 0
		y: 0
		z: app.forceTop + 5
		width: 600
		height: 40
		color: "#1a2026"

		Text {
			anchors.left: parent.left
			anchors.leftMargin: 0
			z: app.forceTop + 1
			text: qsTr("Name")
			font.capitalization: Font.MixedCase
			font.italic: false
			font.family: "CMU Concrete"
			color: "#ffffff"
			font.pointSize: 20
			font.bold: false
			//font.family: "Courier"
			topPadding: 6
			leftPadding: 10
		}

		Text {
			anchors.right: parent.right
			anchors.rightMargin: 0
			z: app.forceTop + 1
			text: qsTr("Last modified")
			font.family: "CMU Concrete"
			color: "#ffffff"
			font.pointSize: 19
			font.bold: false
			//font.family: "Courier"
			topPadding: 6
			rightPadding: 10
		}
	}

	ListView {
		id: listView
		visible: true
		anchors.left: parent.left
		anchors.leftMargin: 0
		anchors.right: parent.right
		anchors.rightMargin: 0
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 0
		anchors.top: parent.top
		anchors.topMargin: 40
		snapMode: ListView.SnapToItem
		model: projectListModel
		delegate: projectListDelegate
		focus: true
		currentIndex: 0
		highlight: Rectangle {
			z: app.forceTop
			color: "#e8dfd7"
			opacity: 0.5
			focus: true
		}
		highlightFollowsCurrentItem: true

		Component {
			id: projectListDelegate
			Rectangle {

				width: ListView.view.width
				height: 50

				color: fileName == app.currentProject ? "#e8dfd7" : index % 2
														== 0 ? "#456160" : "#698483"

				Text {
					id: fileNameText
					anchors.left: parent.left
					anchors.leftMargin: 0
					text: fileName
					color: "#000000"
					font.pointSize: 19
					font.bold: false
					font.family: "CMU Typewriter Text"
					topPadding: 15
					leftPadding: 10
				}

				Text {
					id: fileModText
					anchors.right: parent.right
					anchors.rightMargin: 10
					text: fileModified.toLocaleDateString(Qt.locale("en_US"),
														  "d MMM yyyy")
					color: "#000000"
					font.pointSize: 19
					font.bold: false
					font.family: "CMU Typewriter Text"
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

		FolderListModel {
			id: projectListModel
			folder: "file://" + projectPath
		}
	}

	ToolBar {
		id: toolBar
		width: 200
		height: 40
		Label {
			id: label
			y: 22
			color: "#ffffff"
			text: qsTr("Projects")
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
			id: roundButton
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
				projectUI.visible = false
			}
		}
		anchors.topMargin: 0
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.leftMargin: 600
		Material.primary: "#413a48"
	}
}

/*##^##
Designer {
	D{i:5;anchors_x:56}D{i:7;anchors_x:56}D{i:21;anchors_x:66}D{i:20;anchors_width:360}
}
##^##*/

