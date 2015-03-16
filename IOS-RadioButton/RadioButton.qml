import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

Control {
    id:root

    implicitWidth: 140
    implicitHeight: 80

    style: Qt.createComponent("RadioButtonStyle.qml", root)

    /*! 是否被选中 */
    property bool checked: false
    /*! 是否被按下，按下并不一定选中 */
    readonly property bool pressed: mousearea.pressed || upperma.pressed

    MouseArea {
        id: mousearea
        anchors.fill: parent
        onClicked: {
            root.forceActiveFocus()
            root.checked = !root.checked
        }
    }

    Loader {
        id: maskloader
        property Component __mask //上层按钮
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: __style && __style.bkBorderWidth ? __style.bkBorderWidth : 0
        anchors.rightMargin: parent.width-upperloader.x-upperloader.width
        anchors.verticalCenter: parent.verticalCenter
        sourceComponent: __style && __style.mask ? __style.mask : __mask
    }

    Loader {
        id: upperloader
        property Component __up //上层按钮
        property real bkBorderWidth: __style && __style.bkBorderWidth ? __style.bkBorderWidth : 0
        anchors.verticalCenter: parent.verticalCenter
        sourceComponent: __style && __style.upper ? __style.upper : __up
        x: root.checked ? root.width-width-bkBorderWidth : bkBorderWidth

        onXChanged: {
            if (x===root.width-width-bkBorderWidth) {
                root.checked = true
            }else if (x===bkBorderWidth) {
                root.checked = false
            }
        }

        MouseArea {
            id:upperma
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAxis
            drag.maximumX: root.width-upperloader.width-upperloader.bkBorderWidth
            drag.minimumX: upperloader.bkBorderWidth
            onClicked: {
                root.forceActiveFocus()
                root.checked = !root.checked
            }
        }
    }
}

