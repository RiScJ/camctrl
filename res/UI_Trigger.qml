import QtQuick 2.6
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.0

Pane { id: optionsPane
    background: Rectangle {
        color: "#444444"
        border.width: 0
    }
    x: 600
    width: 200
    height: 440
    anchors.top: mainBar.bottom
    anchors.topMargin: 0
    anchors.right: parent.right
    anchors.rightMargin: 0

    property string menuTitle: "Options"
    property int delayTime: 4000

    signal openMainUI

    Label {
        id: label1
        color: "#ffffff"
        text: qsTr("TRIGGER")
        anchors.top: parent.top
        anchors.topMargin: 9
        font.pointSize: 19
        //font.family: "Courier"
        anchors.horizontalCenterOffset: -36
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Label {
        id: label2
        color: "#ffffff"
        text: qsTr("EXT")
        //font.family: "Courier"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 40
    }

    Label {
        id: label3
        color: "#ffffff"
        text: qsTr("GPIO")
        //font.family: "Courier"
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 65
    }

    SpinBox { id: gpioSpin
        x: 64
        y: 51
        width: 130
        height: 40
        value: 10
        bottomPadding: 1
        topPadding: 20
        font.pointSize: 20
        //font.family: "Courier"
        to: 32
        editable: false
        scale: 0.6
    }

    Label {
        id: label4
        color: "#ffffff"
        text: qsTr("On...")
        //font.family: "Courier"
        anchors.top: parent.top
        anchors.topMargin: 99
        anchors.left: parent.left
        anchors.leftMargin: 15
    }

    ComboBox { id: extEdgeCombo
        x: 64
        y: 84
        width: 130
        height: 40
        editable: false
        padding: 0
        topPadding: 0
        font.pointSize: 14
        //font.family: "Courier"
        flat: false
        textRole: ""
        currentIndex: 0
        scale: 0.6
        model: ["RISE", "FALL"]
    }

    Label {
        id: label5
        color: "#ffffff"
        text: qsTr("TMR")
        //font.family: "Courier"
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 150
    }

    Label {
        id: label6
        color: "#ffffff"
        text: qsTr("Delay")
        anchors.left: parent.left
        anchors.leftMargin: 15
        anchors.top: parent.top
        anchors.topMargin: 170
        //font.family: "Courier"
    }

    function formatText(count, modelData) {
            var data = count === 12 ? modelData + 1 : modelData;
            return data.toString().length < 2 ? "0" + data : data;
    }

    Component {
        id: tumblerDelegate

        Label {
            text: optionsPane.formatText(Tumbler.tumbler.count, modelData)
            opacity: 1.0 - Math.abs(Tumbler.displacement) / (Tumbler.tumbler.visibleItemCount / 2)
            color: "#000000"
            font.pointSize: 15
        }
    }

    Tumbler { id: minTumbler
        x: 70
        y: 170
        width: 36
        height: 116
        font.wordSpacing: 0
        font.italic: true
        //font.family: "Courier"
        visibleItemCount: 6
        model: 60

        delegate: tumblerDelegate
    }

    Tumbler { id: secTumbler
        x: 112
        y: 170
        width: 36
        height: 116
        font.italic: true
        model: 60
        visibleItemCount: 6
        font.wordSpacing: 0
        //font.family: "Courier"

        delegate: tumblerDelegate
    }

    Label {
        id: label7
        x: 96
        y: 214
        color: "#ffffff"
        text: qsTr("'")
        font.italic: true
        font.bold: true
        font.pointSize: 15
        //font.family: "Courier"
    }

    Label {
        id: label8
        x: 140
        y: 214
        width: 26
        height: 21
        color: "#ffffff"
        text: qsTr("''")
        font.letterSpacing: -5
        font.italic: true
        font.pointSize: 15
        font.bold: true
        //font.family: "Courier"
    }

    //
}
