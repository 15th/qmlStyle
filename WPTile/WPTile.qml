import QtQuick 2.5
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

    readonly property bool flipped: __flipped //只读 当前磁铁的是否能翻转的状态 当该值为true时，开始翻转动画 为false时动画停止

    signal setting() //设置磁贴的信号
    signal clicked() //点击信号

    property bool __flipped: false //翻转标志 当该值为true时，开始翻转动画 为false时动画停止
    property bool __setting: false //是否为setting状态 true为setting状态 false为普通状态

    Flipable {
        id: flipable

        width: middleSize
        height: middleSize
        property real runAngle: 0 //动画运行的角度

        back: __style ? __style.back : undefined
        front: __style ? __style.front : undefined

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
                if (flipable.side===Flipable.Back) {
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
                __flipped = false
                __setting = true
                root.setting()
            }
        }

        onReleased: {
            hold.stop()
            if (!__setting && !isHold) {
                root.clicked()
            }
        }
    }

    Loader {
        id: delbtn
        anchors.top: parent.top
        anchors.right: parent.right
        sourceComponent: __style ? __style.deletebutton : undefined
        visible: false

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("papapapa")
                root.visible = false
            }
        }
    }

    on__FlippedChanged: {
        if (__flipped) {
            console.log("im running...")
            sleep.start()
        }else{
            console.log("im stopped...")
            run.stop()
            sleep.stop()
            delbtn.visible = true
        }
    }

    onActiveFocusChanged: {
        if (!activeFocus){
            __setting = false
            __flipped = true
        }
    }

    Component.onCompleted: {
        __flipped = true
    }

    function beginFlip() {
        //触发开始翻转方法
        delbtn.visible = false
        __flipped = true
        __setting = false
    }

    function reset() {
        //pin到桌面（恢复）方法
        root.visible = true
        beginFlip()
    }
}

