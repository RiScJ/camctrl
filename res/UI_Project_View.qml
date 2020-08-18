import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0
import Qt.labs.folderlistmodel 1.0
import QtMultimedia 5.8

Rectangle {
	id: viewProjectUI

	x: 0
	y: 0
	z: app.forceTop
	width: 800
	height: 480
	color: "#261a20"

	visible: false
	enabled: visible

	signal pop

	property string currentlyViewedFile: ""
	property string currentlyViewedFileType: ""
	property bool playing: false
	property bool isVideo: (currentlyViewedFileType == "VID"
							|| currentlyViewedFileType == "LPS")
	property bool isPhoto: !isVideo

	function setCurrentlyViewedFile() {
		currentlyViewedFile = app.currentViewedFile
	}

	function setCurrentlyViewedFileType() {
		currentlyViewedFileType = app.currentViewedFileType
	}

	Rectangle {
		width: 800
		height: 440
		x: 0
		y: 40
		color: "black"

		MouseArea {
			enabled: isVideo
			anchors.fill: parent
			onClicked: {
				if (playing) {
					player.stop()
					playing = false
				} else {
					player.play()
					playing = true
				}
			}
		}

		Image {
			id: image

			enabled: isPhoto
			source: isPhoto ? currentlyViewedFile : ""
		}

		MediaPlayer {
			id: player
			source: isVideo ? currentlyViewedFile : ""
			autoPlay: false
			autoLoad: false
		}

		VideoOutput {
			enabled: isVideo
			id: videoOutput
			source: player
			anchors.fill: parent
		}
	}

	ToolBar {
		id: toolBar
		height: 40
		anchors.right: parent.right
		anchors.rightMargin: 0
		Label {
			id: label
			y: 22
			color: "#ffffff"
			text: qsTr("Media Viewer")
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
		anchors.leftMargin: 0
		Material.primary: "#413a48"
	}
}
