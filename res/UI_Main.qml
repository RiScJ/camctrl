import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
	id: mainUI

	x: 0
	y: 0
	z: app.forceTop + 2
	width: 800
	height: 480
	color: "#1a2026"

	//    visible: true
	enabled: visible

	signal openRemoteUI
	signal openProjectUI
	signal openControlUI
	signal openTriggerUI
	signal openHelpUI
	signal openInfoUI
	signal openSetupUI

	Button {
		id: button_openRemoteUI

		Material.background: "#2a3b3b"
		x: 415
		y: 157
		width: 355
		height: 117
		text: qsTr("Remote Sync")
		padding: 0
		leftPadding: 0
		topPadding: 0
		rightPadding: 150
		bottomPadding: 60
		font.pointSize: 17
		font.family: "CMU Concrete"

		enabled: false

		onClicked: {
			openRemoteUI()
			mainUI.visible = false
		}

		Image {
			id: image4
			x: 264
			y: 27
			width: 64
			height: 64
			opacity: 0.557
			fillMode: Image.PreserveAspectFit
			source: "icons/remote-access.png"
		}
	}

	Button {
		id: button_openProjectUI

		Material.background: "#2a3b3b"
		x: 415
		y: 25
		width: 355
		height: 117
		text: qsTr("PROJECTS")
		bottomPadding: 60
		rightPadding: 200
		leftPadding: 0
		topPadding: 0
		font.italic: false
		font.pointSize: 17
		font.family: "CMU Concrete"
		font.bold: false
		font.capitalization: Font.MixedCase
		font.weight: Font.Normal

		onClicked: {
			openProjectUI()
			mainUI.visible = false
		}
	}

	Button {
		id: button_openControlUI

		Material.background: "#2a3b3b"
		x: 33
		y: 25
		width: 355
		height: 117
		text: qsTr("Control")
		padding: 0
		font.bold: false
		font.family: "CMU Concrete"
		bottomPadding: 60
		font.weight: Font.Normal
		font.pointSize: 17
		topPadding: 0
		rightPadding: 210
		font.capitalization: Font.AllUppercase
		font.italic: false
		leftPadding: 0

		onClicked: {
			openControlUI()
			mainUI.visible = false
		}

		Image {
			id: image
			x: 261
			y: 27
			width: 64
			height: 64
			smooth: true
			antialiasing: true
			fillMode: Image.PreserveAspectFit
			source: "icons/aperture.png"
		}

		Image {
			id: image1
			x: 645
			y: 27
			width: 64
			height: 64
			antialiasing: true
			fillMode: Image.PreserveAspectFit
			source: "icons/project.png"
			smooth: true
		}
	}

	Button {
		id: button_openTriggerUI

		x: 33
		y: 157
		width: 355
		height: 117
		text: qsTr("TRIGGER SETUP")
		font.family: "CMU Concrete"
		bottomPadding: 60
		Material.background: "#2a3b3b"
		font.pointSize: 17
		rightPadding: 130
		topPadding: 0
		padding: 0
		leftPadding: 0

		onClicked: {
			openTriggerUI()
			mainUI.visible = false
		}

		Image {
			id: image3
			x: 263
			y: 27
			width: 64
			height: 64
			fillMode: Image.PreserveAspectFit
			source: "icons/timer.png"
		}
	}

	Button {
		id: button_openHelpUI

		x: 415
		y: 291
		width: 165
		height: 168
		text: qsTr("HELP")
		bottomPadding: 108
		font.family: "CMU Concrete"
		Material.background: "#2a3b3b"
		padding: 0
		topPadding: 0
		rightPadding: 80
		font.pointSize: 17
		leftPadding: 0

		onClicked: {
			openHelpUI()
			mainUI.visible = false
		}

		Image {
			id: image6
			x: 51
			y: 64
			width: 64
			height: 64
			fillMode: Image.PreserveAspectFit
			source: "icons/paper.png"
		}
	}

	Button {
		id: button_openInfoUI

		x: 223
		y: 291
		width: 165
		height: 168
		text: qsTr("INFO")
		font.family: "CMU Concrete"
		bottomPadding: 108
		Material.background: "#2a3b3b"
		font.pointSize: 17
		rightPadding: 80
		topPadding: 0
		padding: 0
		leftPadding: 0

		onClicked: {
			openInfoUI()
			mainUI.visible = false
		}

		Image {
			id: image5
			x: 51
			y: 64
			width: 64
			height: 64
			fillMode: Image.PreserveAspectFit
			source: "icons/statistics.png"
		}
	}

	Button {
		id: button_openSetupUI

		x: 33
		y: 291
		width: 165
		height: 168
		text: qsTr("SETTINGS")
		bottomPadding: 108
		font.family: "CMU Concrete"
		Material.background: "#2a3b3b"
		padding: 0
		topPadding: 0
		rightPadding: 20
		font.pointSize: 17
		leftPadding: 0

		onClicked: {
			openSetupUI()
			mainUI.visible = false
		}

		Image {
			id: image2
			x: 51
			y: 64
			width: 64
			height: 64
			fillMode: Image.PreserveAspectFit
			source: "icons/settings.png"
		}
	}

	// Later add a configuration option for the user to enable this
	//	RoundButton {
	//		id: button_openMiscMenu

	//		Material.background: "#1a2026"
	//		x: 690
	//		y: 15
	//		width: 80
	//		height: 80
	//		text: "\u2630"
	//		bottomPadding: 7
	//		font.family: "CMU Bright"
	//		font.pointSize: 30

	//		onClicked: {
	//			miscMenu.popup()
	//		}
	//	}

	//	Menu {
	//		id: miscMenu

	//		MenuItem {
	//			text: "Quit"
	//			onTriggered: {
	//				Qt.quit()
	//			}
	//		}
	//	}
}
