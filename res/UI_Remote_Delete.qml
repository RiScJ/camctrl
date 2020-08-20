import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
	id: deleteRemoteUI

	x: 100
	y: 150
	width: 400
	height: 200
	color: "#261a20"

	visible: false

	signal cancel
	signal del

	Label {
		x: 11
		y: 16
		z: app.forceTop + 2
		width: 372
		height: 30
		color: "#ffffff"
		text: qsTr(
				  "Are you sure you want to delete the highlighted project? This cannot be undone.")
		wrapMode: Text.WordWrap
		font.family: "CMU Sans Serif"
		verticalAlignment: Text.AlignTop
		horizontalAlignment: Text.AlignHCenter
		font.pointSize: 13
		//font.family: "Courier"
	}

	Button {
		id: button_confirmDeleteRemote

		y: 70
		width: 170
		height: 107
		text: qsTr("CONFIRM")
		font.family: "CMU Concrete"
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 20
		anchors.left: parent.left
		anchors.leftMargin: 20
		topPadding: 14
		font.bold: false
		font.pointSize: 17

		onClicked: {
			del()
			deleteRemoteUI.visible = false
		}
	}

	Button {
		id: button_cancelDeleteRemote

		x: 210
		y: 73
		width: 170
		height: 107
		text: qsTr("CANCEL")
		font.family: "CMU Concrete"
		anchors.bottom: parent.bottom
		anchors.bottomMargin: 20
		anchors.right: parent.right
		anchors.rightMargin: 20
		topPadding: 14
		font.pointSize: 17

		onClicked: {
			cancel()
			deleteRemoteUI.visible = false
		}
	}
}
