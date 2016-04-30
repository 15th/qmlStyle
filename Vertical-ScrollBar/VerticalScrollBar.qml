import QtQuick 2.5
import QtQuick.Controls 1.3
import QtQuick.Controls.Private 1.0

Control {
    id: root
    implicitWidth: 10
    implicitHeight: parent.height

    style: Qt.createComponent("VerticalScrollBarStyle.qml", root)

    property Item handleItem // verticalscrollbar 控制的Flickable类控件，必须要设置哦，不设置滚轮是没有反应的
    property alias size: scrollbtn.height //滚轮的长度 height
    property alias position: scrollbtn.y //滚轮的高度 y

    property int __scrollState: 0 //-1向上滚 0不滚 1向下滚
    property int __scrollStep: 20 //按下空白时候的移动步长
    property double __offset: 0
    property bool __dragScroll: false //是否按下滚轮

    clip: true

    Timer {
        interval: 20
        running: !!handleItem
                 &&__scrollState!==0
                 && handleItem.contentY>=0
                 && handleItem.contentY<=handleItem.contentHeight-handleItem.height
        repeat: true
        onTriggered: {
            if (!!handleItem) {
                handleItem.contentY += __scrollStep*__scrollState
            }
        }
    }

    Loader {
        id: backboard
        property Component __bkract //背景图案
        anchors.fill: parent
        sourceComponent: __style && __style.background ? __style.background : __bkract
    }

    Loader {
        id: scrollbtn
        property Component __scrollbtn //滑轮图案
        width: parent.width
        sourceComponent: __style && __style.scroll ? __style.scroll : __scrollbtn

        onYChanged: {
            if (y<mousearea.mouseY && y>mousearea.mouseY-height) {
                __scrollState = 0
            }
        }
    }

    MouseArea {
        id: mousearea
        anchors.fill: backboard

        property double oldY: -1
        onPressed: {
            if(mouseY<=scrollbtn.y) {//按住滚轮空白区域滚轮往上
                __scrollState = -1

            }else if(mouseY>=scrollbtn.y+scrollbtn.height) {//按住滚轮空白区域滚轮往下
                __scrollState = 1

            }else {
                __scrollState = 0
                __dragScroll = true
                oldY = mouseY

                __offset = !!handleItem? handleItem.contentY-oldY*handleItem.contentHeight/handleItem.height : 0
            }
        }
        onReleased: {
            __scrollState = 0
            __dragScroll = false
            oldY = -1
        }
        onPositionChanged: {
            if(!!handleItem && pressed && oldY!==-1) {
                var offsetMouseY = mouseY*handleItem.contentHeight/handleItem.height
                handleItem.contentY = __offset+offsetMouseY>=0? (__offset+offsetMouseY<=handleItem.contentHeight-handleItem.height? __offset+offsetMouseY : handleItem.contentHeight-handleItem.height) : 0
            }
        }
    }
}
