import QtQuick 2.0
import QtQuick.Controls 1.3
import QtQuick.Controls.Private 1.0

Style {
    id:style

    property Item back: Rectangle {
        anchors.fill: parent
        color: "red"
    }

    property Item front: Rectangle {
        anchors.fill: parent
        color: "blue"
    }

    property Component deletebutton: Rectangle {
        width: 50
        height: 50
        color: "green"
    }

    property Component panel: Item {
//        property bool focusOn: control.activeFocus

//        Connections {
//            target: control
//            onSetting: {
//                console.log("123234234")
//            }
//        }
    }
}

