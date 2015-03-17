import QtQuick 2.4
import QtQuick.Controls 1.3
import Ths 1.0
import "simple"

Item {
    width: 320
    height: 480

    property var skinSet: ["skin1", "skin2"] //皮肤集
    property var colorSet: { //颜色集 方便随机颜色
        "skin1":["purple","blue"],
        "skin2":["green","yellow"],
    }

    Text {
        id: title
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 10
        text: "简单的换肤换色示例"
        color: "#666"
    }

    Column {
        anchors.top: title.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: 10
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        spacing: 10

        TextInput {
            title: "姓名"
            text: "狗蛋"
        }
        TextInput {
            title: "年龄"
            text: "18"
        }

        Text {
            text: "当前主题名字: "+ColorPalette.skinUrl
            color: "#666"
        }

        Text {
            text: "当前主题颜色: "+ColorPalette.colorType
            color: "#666"
        }
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
            property int index: 0
            onClicked: {
                changeskin.forceActiveFocus()
                index = index+1
                ColorPalette.skinUrl = skinSet[index%2]
                changecolor.index = 0
                ColorPalette.colorType = colorSet[ColorPalette.skinUrl][changecolor.index%2]
            }
        }
        Button {
            id: changecolor
            height: parent.height
            text: "点一下改变颜色"
            property int index: 0
            onClicked: {
                changecolor.forceActiveFocus()
                index = index+1
                ColorPalette.colorType = colorSet[ColorPalette.skinUrl][index%2]
            }
        }
    }
}

