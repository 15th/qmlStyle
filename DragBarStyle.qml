import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

Style {
    id:style

    //背景上的按钮们
    property Component buttons: Row {
        height: parent.height

        Rectangle {
            height: parent.height
            width: 80
            color: "#f9cdac"

            Text{
                anchors.centerIn: parent
                text:"修改"
                color: "#ffffff"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    control.modifyfun()
                }
            }
        }

        Rectangle {
            id:aaaa
            height: parent.height
            width: 80
            color: "#fc9d9a"

            Text{
                anchors.centerIn: parent
                text:"删除"
                color: "#ffffff"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    control.deletefun()
                }
            }
        }
    }

    //上层面板样式
    property Component upper: Rectangle {
        anchors.fill: parent
        color: "#ffffff"
        Text {
            anchors.centerIn: parent
            text:"点一下或者拖拽就会打开"
            color: "#666666"
        }

    }

    //布局面板 可以设置底板背景颜色 不过一般看不见吧
    property Component panel: Item {
        anchors.fill: parent
    }
}

