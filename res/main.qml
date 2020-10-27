import QtQuick 2.6
import QtQuick.Window 2.6
import QtQuick.Controls 2.2
import QtMultimedia 5.0
import Qt.labs.folderlistmodel 1.0
import QtQuick.VirtualKeyboard 2.0
import QtQuick.Controls.Material 2.0

Window {
	id: app
	objectName: "root"

	Material.theme: Material.Dark
	Material.accent: Material.Red
	Material.foreground: "#e9e9e9"
	Material.background: "#543c44"
	Material.primary: Material.BlueGrey

	title: qsTr("Hello World")
	width: 800
	height: 480
	color: "#2c2c2c"
	visible: true

	property int forceTop: 1000

	property int projectCount: 0

	property string modeName: "IMG"
	property string trigName: "USR"
	property string statusName: "IDLE"

	property int delayTime: 60
	property int durationTime: 0
	property int gpio: 3
	property bool edge: false

	property int currentPhoto: countIMG.count
	property int currentVideo: countVID.count
	property int currentLapse: countLPS.count
	property int currentFrame: countFRM.count

	property string currentOpenProject: ""
	property string currentViewedFile: ""
	property string currentViewedFileType: ""

	property string currentOpenRemote: "__local__"

	property string projectPath: {
		if (currentOpenRemote == "__local__") {
			"/usr/share/camctrl/Projects/"
		} else {
			"/usr/share/camctrl/Projects/"
		}
	}

	property string currentProject: "example"
	property string selectedProject: projectPath + currentProject

	FolderListModel {
		id: countIMG
		folder: "file://" + app.selectedProject
		nameFilters: ["IMG_*"]
	}

	FolderListModel {
		id: countVID
		folder: "file://" + app.selectedProject
		nameFilters: ["VID_*"]
	}

	FolderListModel {
		id: countLPS
		folder: "file://" + app.selectedProject
		nameFilters: ["LPS_*"]
	}

	FolderListModel {
		id: countFRM
		folder: "file://" + app.selectedProject
		nameFilters: ["FRM_*"]
	}

	StackView {
		id: stack
		initialItem: mainUI
		anchors.fill: parent

		pushEnter: Transition {
			PropertyAnimation {
				property: "opacity"
				from: 0
				to: 1
				duration: 200
			}
		}

		pushExit: Transition {
			PropertyAnimation {
				property: "opacity"
				from: 1
				to: 0
				duration: 200
			}
		}

		popEnter: Transition {
			PropertyAnimation {
				property: "opacity"
				from: 0
				to: 1
				duration: 200
			}
		}

		popExit: Transition {
			PropertyAnimation {
				property: "opacity"
				from: 1
				to: 0
				duration: 200
			}
		}
	}

	UI_Main {
		id: mainUI

		onOpenRemoteUI: stack.push(remoteUI)
		onOpenProjectUI: stack.push(projectUI)
		onOpenControlUI: {
			stack.push(controlUI)
			cam.start(app.modeName)
		}
		onOpenTriggerUI: stack.push(triggerUI)
		onOpenHelpUI: stack.push(helpUI)
		onOpenInfoUI: {
			projectUI.updateProjectCount()
			stack.push(infoUI)
		}
		onOpenSetupUI: stack.push(setupUI)
		onMountRemote: {
			projectPath = ""
			projectPath = "/usr/share/camctrl/Projects/"
		}
	}

	UI_Remote {
		id: remoteUI

		onOpenMainUI: stack.pop()

		onNewRemote: stack.push(newRemoteUI)
		onDeleteRemote: {
			deleteRemoteUI.visible = true
			remoteUI.enabled = false
		}
		onSelectRemote: {
			if (currentOpenRemote != "__local__") {
				fileUtils.mount(remotePath + currentOpenRemote, projectPath)
			}
			console.log(projectPath)
		}
	}

	UI_Remote_New {
		id: newRemoteUI

		onCancel: stack.pop()
	}

	UI_Remote_Delete {
		id: deleteRemoteUI

		onCancel: remoteUI.enabled = true
		onDel: {
			remoteUI.del()
			remoteUI.enabled = true
		}
	}

	UI_Project {
		id: projectUI

		onOpenMainUI: stack.pop()

		onNewProject: stack.push(newProjectUI)
		onDeleteProject: {
			deleteProjectUI.visible = true
			projectUI.enabled = false
		}
		onOpenProject: {
			openProjectUI.setCurrentlyOpenProject()
			stack.push(openProjectUI)
		}
	}

	UI_Project_New {
		id: newProjectUI

		onCancel: stack.pop()
	}

	UI_Project_Delete {
		id: deleteProjectUI

		onCancel: projectUI.enabled = true
		onDel: {
			projectUI.del()
			projectUI.enabled = true
		}
	}

	UI_Project_Open {
		id: openProjectUI

		onPop: stack.pop()
		onViewMedia: {
			viewProjectUI.setCurrentlyViewedFile()
			viewProjectUI.setCurrentlyViewedFileType()
			stack.push(viewProjectUI)
		}
	}

	UI_Project_View {
		id: viewProjectUI

		onPop: stack.pop()
	}

	UI_Control {
		id: controlUI

		onOpenMainUI: {
			stack.pop()
			cam.stop()
		}
	}

	UI_Trigger {
		id: triggerUI

		onOpenMainUI: stack.pop()
	}

	UI_Help {
		id: helpUI

		onOpenMainUI: stack.pop()
	}

	UI_Info {
		id: infoUI

		onOpenMainUI: stack.pop()
	}

	UI_Setup {
		id: setupUI

		onOpenMainUI: stack.pop()
	}

	InputPanel {
		id: inputPanel
		y: Qt.inputMethod.visible ? parent.height - inputPanel.height : parent.height
		z: app.forceTop + 10
		anchors.left: parent.left
		anchors.right: parent.right
	}
}
