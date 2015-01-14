import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

Control {
    id:root

    implicitWidth: parent.width
    implicitHeight: 80

    style: Qt.createComponent("DragBarStyle.qml", root)

    property real boundary: 40 //滑动开关的边界值
    property alias isOpen: dragRec.isOpen //是否打开标志 true打开 false关闭

    onActiveFocusChanged: {
        if (!activeFocus) {
            isOpen = false
        }
    }

    Loader {
        id:backboard
        property Component __bkButtons //背景图标
        height: parent.height
        anchors.right: parent.right
        sourceComponent: __style && __style.buttons ? __style.buttons : __bkButtons
    }

    Loader {
        id: dragRec
        property Component __upPanel //上层面板
        property bool isOpen: false //是否打开标志 true打开 false关闭
        height: parent.height
        width: parent.width
        Drag.active: dragArea.drag.active
        sourceComponent: __style && __style.upper ? __style.upper : __upPanel

        onIsOpenChanged: {
            if (isOpen) {
                dropOpen.start()
            }else {
                dropClose.start()
            }
        }

        PropertyAnimation on x {
            id:dropOpen
            running:false
            to:dragArea.drag.minimumX
            easing.type: Easing.InOutQuad
        }

        PropertyAnimation on x {
            id:dropClose
            running:false
            to:dragArea.drag.maximumX
            easing.type: Easing.InOutQuad
        }

        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAxis
            drag.maximumX: 0
            drag.minimumX: -backboard.width
            property point oldPosition

            onPressed: {
                oldPosition = Qt.point(mouse.x, mouse.y)
            }

            onReleased: {
                var nowPosition = Qt.point(mouse.x, mouse.y)
                root.forceActiveFocus()
                if (!dragRec.isOpen) {
                    if ((dragRec.x !== 0 && nowPosition.x-oldPosition.x<nowPosition.y-oldPosition.y) || oldPosition.x===mouse.x ){
                        dragRec.isOpen = true
                    }else {
                        dropClose.start()
                    }
                }else {
                    dragRec.isOpen = false
                }
            }
        }
    }

    function modifyfun(){
        console.log("修改操作")
    }

    function deletefun() {
        console.log("删除操作")
    }
}

