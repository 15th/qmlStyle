import QtQuick 2.4
import QtQuick.Controls 1.2
import QtQuick.Controls.Private 1.0

Control {
    id:root

    implicitWidth: 400
    implicitHeight: 480

    style: Qt.createComponent("LockscreenShortcutStyle.qml", root)

    /*! 当前小圆移动的位置 只读 */
    readonly property point pointer: __pointer
    /*! 小圆回原位的速度 数值越大速度越慢 */
    property real speed: 250
    /*! 距离按钮多少距离触发选中效果 */
    property real triggerDistance: 50

    /*! 选中上面图标的信号 */
    signal isTop()
    /*! 选中下面图标的信号 */
    signal isBottom()
    /*! 选中左边图标的信号 */
    signal isLeft()
    /*! 选中右边图标的信号 */
    signal isRight()

    /*! 当前小圆移动的位置 私有 */
    property point __pointer: Qt.point(pointer.x, pointer.y)
    /*! 选中按钮的序号 0未选中 1上面的按钮 2下面的按钮 3左边的按钮 4右边的按钮 私有 */
    property int __chooseBtn: 0


    on__ChooseBtnChanged: {
        var animationSetting = [
                    Qt.point(mousearea.topPoint.x-mousearea.pointerRadius+mousearea.widthOffset, mousearea.topPoint.y-mousearea.pointerRadius+mousearea.heightOffset),
                    Qt.point(mousearea.bottomPoint.x-mousearea.pointerRadius+mousearea.widthOffset, mousearea.bottomPoint.y-mousearea.pointerRadius+mousearea.heightOffset),
                    Qt.point(mousearea.leftPoint.x-mousearea.pointerRadius+mousearea.widthOffset, mousearea.leftPoint.y-mousearea.pointerRadius+mousearea.heightOffset),
                    Qt.point(mousearea.rightPoint.x-mousearea.pointerRadius+mousearea.widthOffset, mousearea.rightPoint.y-mousearea.pointerRadius+mousearea.heightOffset)
                ]
        if (__chooseBtn!==0) {
            mousearea.runPoint(animationSetting[__chooseBtn-1].x, animationSetting[__chooseBtn-1].y, 300)
            if (__chooseBtn==1) {
                isTop()
            }else if (__chooseBtn==2) {
                isBottom()
            }else if (__chooseBtn==3) {
                isLeft()
            }else {
                isRight()
            }
        }
    }

    onActiveFocusChanged: {
        if (!activeFocus) {
            mousearea.reset()
        }
    }

    /*! 指针小圆球loader */
    Loader {
        id: pointer
        property Component __pointer
        property real animationDuration: speed
        property real animationX: root.width/2-pointer.width/2
        property real animationY: root.height/2-pointer.height/2
        sourceComponent: __style && __style.pointer ? __style.pointer : __pointer
        x: root.width/2-pointer.width/2
        y: root.height/2-pointer.height/2

        PropertyAnimation {
            id: runX
            target: pointer
            property: "x"
            to: pointer.animationX
            duration: pointer.animationDuration
        }
        PropertyAnimation {
            id: runY
            target: pointer
            property: "y"
            to: pointer.animationY
            duration: pointer.animationDuration
        }
    }

    /*! 上面的按钮loader */
    Loader {
        id: topbtnloader
        property Component __topbtn
        sourceComponent: __style && __style.topbtn ? __style.topbtn : __topbtn
        anchors.bottom: mousearea.top
        anchors.bottomMargin: __style && __style.btnMargin ? __style.btnMargin : 0
        anchors.horizontalCenter: mousearea.horizontalCenter
    }

    /*! 下面的按钮loader */
    Loader {
        id: bottombtnloader
        property Component __bottombtn
        sourceComponent: __style && __style.bottombtn ? __style.bottombtn : __bottombtn
        anchors.top: mousearea.bottom
        anchors.topMargin: __style && __style.btnMargin ? __style.btnMargin : 0
        anchors.horizontalCenter: mousearea.horizontalCenter
    }

    /*!  左边的按钮loader */
    Loader {
        id: leftbtnloader
        property Component __leftbtn
        sourceComponent: __style && __style.leftbtn ? __style.leftbtn : __leftbtn
        anchors.right: mousearea.left
        anchors.rightMargin: __style && __style.btnMargin ? __style.btnMargin : 0
        anchors.verticalCenter: mousearea.verticalCenter
    }

    /*! 右边的按钮loader */
    Loader {
        id: rightbtnloader
        property Component __rightbtn
        sourceComponent: __style && __style.rightbtn ? __style.rightbtn : __rightbtn
        anchors.left: mousearea.right
        anchors.leftMargin: __style && __style.btnMargin ? __style.btnMargin : 0
        anchors.verticalCenter: mousearea.verticalCenter
    }

    /*! 整体的鼠标区域 */
    MouseArea {
        id: mousearea
        height: movingAreaRadius*2
        width: movingAreaRadius*2
        anchors.centerIn: parent

        /*! 4个按钮的宽(长=宽) */
        property real btnWidth: __style && __style.btnWidth ? __style.btnWidth : 0
        /*! 4个按钮距离大圆的距离 */
        property real btnMargin: __style && __style.btnMargin ? __style.btnMargin : 0

        /*! 背景大圆半径 */
        property real movingAreaRadius: Math.min(root.height-btnWidth*2-btnMargin*2, root.width-btnWidth*2-btnMargin*2)/2
        /*! 指针小圆半径 */
        property real pointerRadius: pointer.height/2
        /*! 宽度上的偏移量 在显示原点的时候要加上偏移量 */
        property real widthOffset: root.width/2-movingAreaRadius
        /*! 高度上的偏移量 */
        property real heightOffset: root.height/2-movingAreaRadius
        /*! 圆心x坐标 */
        property real centerX: movingAreaRadius
        /*! 圆心y坐标 */
        property real centerY: movingAreaRadius

        /*! 上面的按钮坐标 */
        property point topPoint: Qt.point(movingAreaRadius, -btnMargin-btnWidth/2)
        /*! 下面的按钮坐标 */
        property point bottomPoint: Qt.point(movingAreaRadius, movingAreaRadius*2+btnMargin+btnWidth/2)
        /*! 左边的按钮坐标 */
        property point leftPoint: Qt.point(-btnMargin-btnWidth/2, movingAreaRadius)
        /*! 右边的按钮坐标 */
        property point rightPoint: Qt.point(movingAreaRadius*2+btnMargin+btnWidth/2, movingAreaRadius)

        /*! 是否激活移动小圆 true激活 false不激活 这个属性使得在圆外触发鼠标区域的时候不会移动小圆 */
        property bool movingActive: false

        onPressed: {
            root.forceActiveFocus()
            movingActive = isInCircle(mouse)
        }

        onReleased: {
            if (__chooseBtn===0) {
                reset()
            }
        }

        onPositionChanged: {
            getPointerXY(mouse)

            var nowX = pointer.x-widthOffset+pointerRadius
            var nowY = pointer.y-heightOffset+pointerRadius
            __chooseBtn = isNear(nowX, nowY)
        }

        /*! 计算两点之间的距离 并将其返回 */
        function distance(x1, y1, x2, y2) {
            return Math.sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2))
        }

        /*! 计算某个给定点与上下左右四个点之间的距离 0-上 1-下 2-左 3-右 */
        function compDistance(x, y) {
            var topl = distance(x, y, topPoint.x, topPoint.y)
            var bottoml = distance(x, y, bottomPoint.x, bottomPoint.y)
            var leftl = distance(x, y, leftPoint.x, leftPoint.y)
            var rightl = distance(x, y, rightPoint.x, rightPoint.y)
            return [topl, bottoml, leftl, rightl]
        }

        /*! 判断是否可以移动鼠标小圆点 返回true可以 false不可以移动 x,y为当前坐标 */
        function canMoving(x, y) {
            return __chooseBtn===0 || __chooseBtn!==isNear(x,y)
        }

        /*! 通过动画，将鼠标小圆点运动到x,y坐标的位置 runSpeed为运动的速度 */
        function runPoint(x, y, runSpeed) {
            pointer.animationDuration = runSpeed
            pointer.animationX = x
            pointer.animationY = y
            runX.start()
            runY.start()
        }

        /*!
          判断鼠标当前坐标是否在圆内 如果在圆内自动移动圆点到鼠标位置
          返回ture在圆内 返回false在圆外
        */
        function isInCircle(mouse) {
            var pointX = mouse.x-centerX //所选点在坐标系上的x值
            var pointY = mouse.y-centerY //所选点在坐标系上的y值

            if (pointX*pointX+pointY*pointY<=movingAreaRadius*movingAreaRadius && canMoving(mouse.x, mouse.y)) {
                pointer.x = mouse.x-pointerRadius+widthOffset
                pointer.y = mouse.y-pointerRadius+heightOffset
                __chooseBtn = isNear(mouse.x, mouse.y)
                return true
            }else {
                return false
            }
        }

        /*! 计算pointer该显示在什么位置上 */
        function getPointerXY(mouse) {
            var pointX = mouse.x-centerX //所选点在坐标系上的x值
            var pointY = mouse.y-centerY //所选点在坐标系上的y值

            if (movingActive && !isInCircle(mouse)) {
                //当点不在圆内，判断其在第几象限
                var l = distance(pointX, pointY, 0, 0) //当前点距离圆心之间的距离
                var limitX = (movingAreaRadius/l*pointX)+movingAreaRadius //边缘x的坐标
                var limitY = (movingAreaRadius/l*pointY)+movingAreaRadius //边缘y的坐标
                if (canMoving(limitX, limitY)) {
                    pointer.x = limitX-pointerRadius+widthOffset
                    pointer.y = limitY-pointerRadius+heightOffset
                }
            }
        }

        /*! 判断pointer是否接近某个图标 x,y为当前坐标 */
        function isNear(x, y) {
            var nowDistance = compDistance(x, y)
            if (nowDistance[0]<=triggerDistance) {
                //选中上面的按钮
                return 1
            }else if (nowDistance[1]<=triggerDistance) {
                //选中下面的按钮
                return 2
            }else if (nowDistance[2]<=triggerDistance) {
                //选中左边的按钮
                return 3
            }else if (nowDistance[3]<=triggerDistance) {
                //选中右边的按钮
                return 4
            }else {
                //哪个都没有被选中
                return 0
            }

        }

        /*! 重置圆点位置 */
        function reset() {
            __chooseBtn = 0
            var nowl = distance(mouseX, mouseY, centerX, centerY)
            runPoint(root.width/2-pointer.width/2, root.height/2-pointer.height/2, nowl/movingAreaRadius*speed)
        }

    }
}
