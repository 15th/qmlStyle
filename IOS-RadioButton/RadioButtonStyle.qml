import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Private 1.0


Style {
    id:style
    property real bkBorderWidth: 1 //背景边框宽度
    property real btnBorderWidth: 0.75 //按钮边框宽度

    property color borderColor: "#B4B4B4" //边框颜色
    property color checkedColor: "#4BD962" //选中颜色
    property color defaultColor: "#FFFFFF" //未选中颜色

    property Component upper: Rectangle {
        height: control.height-style.bkBorderWidth*2
        width: control.pressed ? 4/3*height : height
        radius: height/2
        color: style.defaultColor
        border.width: style.btnBorderWidth
        border.color: style.borderColor

        Behavior on width {
            PropertyAnimation {
            }
        }

    }

    property Component mask: Rectangle {
        height: control.height-style.bkBorderWidth*2
        width: parent.width
        radius: height/2
        color: control.checked ? style.checkedColor : style.borderColor
    }

    property Component background: Rectangle {
        height: control.height
        width: control.width
        radius: height/2
        color: style.defaultColor
        border.width: control.checked || (control.pressed && !control.checked) ? height : style.bkBorderWidth
        border.color: control.checked ? style.checkedColor : style.borderColor

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

