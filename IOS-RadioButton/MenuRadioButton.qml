import QtQuick 2.4
import "./"

Item {
    id: menu
    width: 320
    height: 480

    property var titleList: ["飞行模式","WLAN","蓝牙","段落文字优化","自动旋转触摸",
        "防误触模式","静音模式","显示流量信息","显示密码"]


    Text {
        id: title
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "系统设置"
        color: "#666"
    }

    Rectangle {
        anchors.top: title.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        border.width: 1
        border.color: "#ccc"
        color: "#eee"
        radius: 10
        clip: true

        ListView {
            id: listview
            anchors.fill: parent
            model: titleList
            delegate: Item {
                width: parent.width
                height: 50
                Text {
                    text: modelData
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    color: "#333"
                }
                RadioButton {
                    width: 40
                    height: 25
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                }
                Rectangle {
                    width: parent.width
                    height: 1
                    color: "#ccc"
                    anchors.bottom: parent.bottom
                    visible: index!==listview.count-1
                }
            }
            onFlickStarted: menu.forceActiveFocus()
        }
    }
}

