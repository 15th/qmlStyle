import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Controls.Private 1.0

Style {
    id:style

    //背景样式
    property Component background: Rectangle {
        color: "#fcfcfc"
        Rectangle {
            width: 1
            height: control.height
            color: "#cccccc"
        }
    }

    //滚动条滚轮
    property Component scroll: Item {
        Rectangle {
            width: parent.width-4
            height: parent.height-4
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: 0.5
            anchors.verticalCenter: parent.verticalCenter
            color: control.__dragScroll? "#777777" : "#bbbbbb"
            radius: width
        }
    }
}
