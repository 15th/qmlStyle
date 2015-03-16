import QtQuick 2.4
import QtQuick.Controls 1.3

Item {
    width: 320
    height: 480

    Text {
        id: title
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "简单的换肤换色示例"
        color: "#666"
    }

    Row {
        height: 50
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        Button {
            id: changeskin
            height: parent.height
            text: "点一下改变皮肤"
            onClicked: {
                changeskin.forceActiveFocus()
            }
        }
        Button {
            id: changecolor
            height: parent.height
            text: "点一下改变颜色"
            onClicked: {
                changecolor.forceActiveFocus()
            }
        }
    }
}

