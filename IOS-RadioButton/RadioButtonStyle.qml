import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

Style {
    id:style
    property real bkBorderWidth: 2 //背景边框宽度

    property Component upper: Rectangle {
        height: control.height-style.bkBorderWidth*2
        width: control.pressed ? 4/3*height : height
        radius: height/2
        color: "white"
        border.width: 1
        border.color: "gray"

        Behavior on width {
            PropertyAnimation {
            }
        }
    }

    property Component mask: Rectangle {
        height: control.height-style.bkBorderWidth*2
        width: parent.width
        radius: height/2
        color: control.checked ? "green" : "gray"
    }

    property Component background: Rectangle {
        height: control.height
        width: control.width
        radius: height/2
        color: "white"
        border.width: control.checked || (control.pressed && !control.checked) ? height : style.bkBorderWidth
        border.color: control.checked ? "green" : "gray"

        Behavior on border.width {
            PropertyAnimation {
                duration: 350
            }
        }
    }

    //布局面板
    property Component panel: Item {
        anchors.fill: parent

        Loader {
            anchors.centerIn: parent
            sourceComponent: background
        }

    }
}

