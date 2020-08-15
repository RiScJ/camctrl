import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Rectangle {
    x: 0
    y: 0
    z: app.forceTop + 2
    width: 600
    height: 480
    color: "#4e4e4e"

    ScrollView {
        x: 0
        y: 0
        width: 600
        height: 480
        background: Rectangle {
                anchors.fill: parent
                color: "#eeeeee"
        }

        TextArea {
            wrapMode: Text.WordWrap
            font.family: "Courier"
            readOnly: true
            text: fileUtils.readFile(app.homeDir + "camctrl/README.md")
        }
    }
}

/*##^##
Designer {
    D{i:2;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:12}D{i:1;anchors_height:200;anchors_width:200;anchors_x:0;anchors_y:0}
}
##^##*/
