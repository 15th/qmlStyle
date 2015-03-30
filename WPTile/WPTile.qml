import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Private 1.0

Control {
    id:root
    implicitWidth: middleSize
    implicitHeight: middleSize

    style: Qt.createComponent("WPTileStyle.qml", root)

    property real middleSize: 100 //正常磁贴的大小 小磁贴为1/2*middleSize 大磁贴为2*middleSize

    property real speedTime: 200 //动画速度(ms) 越小越快
    property real sleepTime: 1000 //翻转间的休息时间(ms)
    property real holdTime: 2000 //按下多久(ms)触发setting

    signal setting() //设置磁贴的信号
    signal clicked() //点击信号

    property bool __flipped: false //翻转标志 当该值为true时，开始翻转动画 为false时动画停止
    property bool __setting: false //是否为setting状态 true为setting状态 false为普通状态

    Flipable {
        id: flipable

        width: middleSize
        height: middleSize
        property bool isSideA: false //是否是A动画结束触发的timer true为A面触发timer false为B面触发timer
        property real runAngle: 0 //动画运行的角度

        back: __style.back
        front: __style.front

        transform: Rotation {
            id: rotation
            origin.x: width/2
            origin.y: height/2
            axis.x: 1
            axis.y: 0
            axis.z: 0

            NumberAnimation on angle {
                id:run
                target: rotation
                properties: "angle"
                from: flipable.runAngle
                to: flipable.runAngle-210
                duration: speedTime
                running: false
                alwaysRunToEnd: true
                onStopped: {
                    swing.start()
                }
            }
            NumberAnimation on angle {
                id:swing
                target: rotation
                properties: "angle"
                from: flipable.runAngle-210
                to: flipable.runAngle-180
                duration: speedTime*2
                running: false
                alwaysRunToEnd: true
                onStopped: {
                    if (__flipped) {
                        flipable.isSideA = !flipable.isSideA
                        sleep.start()
                    }
                }
            }
        }

        Timer {
            id:sleep
            running:false
            interval:sleepTime
            onTriggered: {
                if (flipable.isSideA) {
                    flipable.runAngle = flipable.runAngle-180
                }else {
                    flipable.runAngle = 0
                }
                run.start()
            }
        }
    }

    MouseArea {
        anchors.fill: flipable
        property bool isHold: false //是否触发长时间按下的信号 true触发了 false没触发

        onPressed: {
            root.forceActiveFocus()
            if (!__setting) {
                isHold = false
                hold.start()
            }
        }

        Timer {
            id: hold
            running: false
            interval: holdTime
            onTriggered: {
                parent.isHold = true
                root.__flipped = false
                root.__setting = true
                root.setting()
            }
        }

        onReleased: {
            if (!__setting && !isHold) {
                root.clicked()
            }
        }
    }

    on__FlippedChanged: {
        if (__flipped) {
            sleep.start()
        }else{
            run.stop()
            sleep.stop()
            flipable.isSideA = false
        }
    }

    onActiveFocusChanged: {
        if (!activeFocus){
            root.__setting = false
            root.__flipped = true
        }
    }

    Component.onCompleted: {
        __flipped = true
    }
}

