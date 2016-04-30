import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Controls.Private 1.0

Control {
    id: root
    implicitWidth: 10
    implicitHeight: parent.height

    style: Qt.createComponent("VerticalScrollBarStyle.qml", root)

    property alias size: scrollbtn.height //滚轮的长度 height
    property alias position: scrollbtn.y //滚轮的高度 y

    Loader {
        id:backboard
        property Component __bkract //背景图案
        anchors.fill: parent
        sourceComponent: __style && __style.background ? __style.background : __bkract
    }

    Loader {
        id:scrollbtn
        property Component __scrollbtn //滑轮图案
        width: parent.width
        sourceComponent: __style && __style.scroll ? __style.scroll : __scrollbtn
    }
}
