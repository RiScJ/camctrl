import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle { id: newProjectUI
    x: 0
    y: 0
    width: 800
    height: 480
    color: "#261a20"

    visible: false

    signal cancel

    TextField { id: newProjTextField
        y: 52
        height: 60
        text: ""
        anchors.right: button_cancelNewProject.left
        anchors.rightMargin: 42
        anchors.left: parent.left
        anchors.leftMargin: 30
        leftPadding: 15
        topPadding: 14
        font.pointSize: 17
        font.bold: false
        placeholderText: qsTr("New project name")
    }

    Button { id: button_cancelNewProject
        x: 525
        y: 52
        width: 126
        height: 60
        text: qsTr("CANCEL")
        bottomPadding: 12
        padding: 0
        leftPadding: 8
        rightPadding: 8
        font.family: "CMU Concrete"
        topPadding: 14
        font.bold: false
        font.pointSize: 17
        anchors.right: button_createNewProject.left
        anchors.rightMargin: 19

        onClicked: {
            newProjTextField.text = ""
            cancel()
        }
    }

    Button { id: button_createNewProject
        x: 670
        y: 52
        width: 126
        height: 60
        text: qsTr("CREATE")
        font.family: "CMU Concrete"
        topPadding: 14
        font.pointSize: 17
        anchors.right: parent.right
        anchors.rightMargin: 30

        onClicked: {
            fileUtils.mkdir(projectPath + newProjTextField.text)
            newProjTextField.text = ""
            cancel()
        }
    }
}
