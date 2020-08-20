import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
	id: newRemoteUI

	x: 0
	y: 0
	width: 800
	height: 480
	color: "#261a20"

	visible: false

	signal cancel

	function checkEntry() {
		return true
	}

	ComboBox {
		id: combo_remoteType
		x: 28
		y: 82
		width: 120
		height: 54
		enabled: false
		font.family: "CMU Typewriter Text"
		font.italic: true
		font.pointSize: 17
		model: ["sshfs"]
		editable: false
		currentIndex: 0
	}

	TextField {
		id: text_remoteName
		x: 28
		y: 21
		width: 747
		height: 44
		font.pointSize: 15
		placeholderText: qsTr("Remote storage name")
	}

	TextField {
		id: text_remoteUser
		x: 184
		y: 92
		width: 184
		height: 44
		horizontalAlignment: Text.AlignRight
		font.pointSize: 15
		placeholderText: qsTr("Remote username")
	}

	TextField {
		id: text_remoteHost
		x: 401
		y: 92
		width: 184
		height: 44
		font.pointSize: 15
		placeholderText: qsTr("Remote hostname")
	}

	Label {
		x: 372
		y: 94
		width: 30
		height: 30
		text: qsTr("@")
		font.italic: false
		font.family: "CMU Concrete"
		font.pointSize: 23
	}

	TextField {
		id: text_remotePort
		x: 659
		y: 92
		width: 68
		height: 44
		font.pointSize: 15
		placeholderText: qsTr("port")
	}

	TextField {
		id: text_remoteDirectory
		x: 56
		y: 168
		width: 440
		height: 44
		font.pointSize: 15
		placeholderText: qsTr("Remote storage directory")
	}

	Button {
		id: button_cancelNewRemote
		x: 659
		y: 148
		width: 116
		height: 71
		text: qsTr("CANCEL")
		font.pointSize: 15
		font.family: "CMU Concrete"

		onClicked: {
			cancel()
		}
	}

	Button {
		id: button_createNewRemote
		x: 520
		y: 148
		width: 116
		height: 71
		text: qsTr("CREATE")
		font.family: "CMU Concrete"
		font.pointSize: 15

		onClicked: {
			if (checkEntry()) {
				fileUtils.writeFile(
							app.remotePath + text_remoteName.text,
							combo_remoteType.textAt(
								combo_remoteType.currentIndex) + "\n\n"
							+ text_remoteUser.text + "\n" + text_remoteHost.text
							+ "\n" + text_remotePort.text + "\n" + text_remoteDirectory.text)
				fileUtils.mkdir(app.remoteProjectPath + text_remoteName.text)
				cancel()
			} else {

			}
		}
	}

	Label {
		x: 28
		y: 169
		width: 12
		height: 30
		text: qsTr(":/")
		font.family: "CMU Concrete"
		font.pointSize: 22
		font.italic: false
	}
}
