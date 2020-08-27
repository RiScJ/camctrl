import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0
import Qt.labs.folderlistmodel 1.0

Rectangle {
	id: openProjectUI

	x: 0
	y: 0
	z: app.forceTop - 1
	width: 600
	height: 480
	color: "#261a20"

	visible: false
	enabled: visible

	property string currentlyOpenProject: ""

	signal pop
	signal viewMedia

	function del() {
		fileUtils.removeDir(app.projectPath + projectListModel.get(
								listView.currentIndex, "fileName"))
	}

	function updateProjectCount() {
		app.projectCount = listView.count
	}

	function setCurrentlyOpenProject() {
		currentlyOpenProject = app.currentOpenProject
	}

	function updateFilters() {
		currentlyOpenProjectListModel.nameFilters = []
		if (check_filterIMG.checked) {
			currentlyOpenProjectListModel.nameFilters.push("IMG_*")
		}
		if (check_filterVID.checked) {
			currentlyOpenProjectListModel.nameFilters.push("VID_*")
		}
		if (check_filterLPS.checked) {
			currentlyOpenProjectListModel.nameFilters.push("LPS_*")
		}
		if (check_filterFRM.checked) {
			currentlyOpenProjectListModel.nameFilters.push("FRM_*")
		}
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

		ToolSeparator {
			y: 299
			anchors.right: parent.right
			orientation: Qt.Horizontal
			anchors.rightMargin: 0
			anchors.left: parent.left
			anchors.leftMargin: 0
		}

		Button {
			id: button_viewMedia

			x: 9
			y: 324
			width: 162
			height: 132
			text: qsTr("VIEW")
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.horizontalCenterOffset: 0
			bottomPadding: 84
			font.family: "CMU Concrete"
			rightPadding: 84
			font.pointSize: 17

			onClicked: {
				app.currentViewedFile = currentlyOpenProjectListModel.folder
						+ "/" + currentlyOpenProjectListModel.get(
							currentlyOpenProjectListView.currentIndex,
							"fileName")
				app.currentViewedFileType = currentlyOpenProjectListModel.get(
							currentlyOpenProjectListView.currentIndex,
							"fileName").substr(0,3)
				viewMedia()
			}
		}

		Button {
			id: button_filterMedia
			x: 0
			y: 43
			width: 162
			height: 256
			text: qsTr("FILTER")
			rightPadding: 66
			anchors.horizontalCenterOffset: 0
			bottomPadding: 210
			font.family: "CMU Concrete"
			font.pointSize: 17
			anchors.horizontalCenter: parent.horizontalCenter

			CheckBox {
				id: check_filterIMG
				x: 10
				y: 47
				text: qsTr("Images")
				font.pointSize: 15
				font.family: "CMU Concrete"
				checked: true

				onClicked: {
					updateFilters()
				}
			}

			CheckBox {
				id: check_filterVID
				x: 10
				y: 89
				text: qsTr("Videos")
				font.family: "CMU Concrete"
				font.pointSize: 15
				checked: true

				onClicked: {
					updateFilters()
				}
			}

			CheckBox {
				id: check_filterLPS
				x: 10
				y: 134
				text: qsTr("Timelapses")
				font.family: "CMU Concrete"
				font.pointSize: 15
				checked: true

				onClicked: {
					updateFilters()
				}
			}

			CheckBox {
				id: check_filterFRM
				x: 10
				y: 178
				text: qsTr("Frames")
				font.family: "CMU Concrete"
				font.pointSize: 15
				checked: true

				onClicked: {
					updateFilters()
				}
			}
		}
	}

	Rectangle {
		id: currentlyOpenProjectListTitle
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
		id: currentlyOpenProjectListView
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
		model: currentlyOpenProjectListModel
		delegate: currentlyOpenProjectListDelegate
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
			id: currentlyOpenProjectListDelegate
			Rectangle {

				width: ListView.view.width
				height: 50

				color: fileName == app.currentProject ? "#e8dfd7" : index % 2
														== 0 ? "#456160" : "#698483"

				Text {
					id: fileNameText
					anchors.left: parent.left
					anchors.leftMargin: 0
					text: fileName.slice(0, -4)
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
						currentlyOpenProjectListView.currentIndex = index
					}
				}
			}
		}

		FolderListModel {
			id: currentlyOpenProjectListModel
			folder: "file://" + currentlyOpenProject
			nameFilters: ["IMG_*", "VID_*", "LPS_*", "FRM_*"]
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
			text: qsTr("Contents")
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
				pop()
			}
		}
		anchors.topMargin: 0
		anchors.top: parent.top
		anchors.left: parent.left
		anchors.leftMargin: 600
		Material.primary: "#413a48"
	}
}

