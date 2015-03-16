import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Controls.Private 1.0
import QtGraphicalEffects 1.0

Style {
    id:style

    /*! 4个按钮的宽(长=宽) */
    property real btnWidth: 25
    /*! 4个按钮距离大圆的距离 */
    property real btnMargin: 10

    /*! 背景 */
    property Component background: Rectangle {
        radius: height/2
        color: "#00000000"
        border.width: 2
        border.color: "#77ffffff"
    }

    /*! 鼠标指针 */
    property Component pointer: Item {
        height: 45
        width: height

        RectangularGlow {
            id: effect
            anchors.fill: lightsize
            glowRadius: 25
            spread: 0.1
            color: "#EB5800"
            cornerRadius: lightsize.height/2 + glowRadius
        }

        Item {
            id: lightsize
            height: 40
            width: height
            anchors.centerIn: parent
            visible: false
        }

        Rectangle {
            height: 20
            width: height
            radius: height/2
            anchors.centerIn: parent
            color: "#EC6700"
            visible: control.__chooseBtn===0 ? true:false

            RadialGradient {
                anchors.fill: parent
                source: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "#EC6700" }
                    GradientStop { position: 0.7; color: "#9C531A" }
                }
            }
        }
        Rectangle {
            height: control.__chooseBtn===0 ? 35:45
            width: height
            radius: height/2
            anchors.centerIn: parent
            color: "#00000000"
            border.width: control.__chooseBtn===0 ? 8:2
            border.color: "#ffffff"
        }
    }

    /*! 上面的按钮 */
    property Component topbtn: Rectangle {
        height: style.btnWidth
        width: height
        radius: height/2

        Text {
            anchors.centerIn: parent
            color: "#333"
            text:"●ˍ●"
        }
    }

    /*! 下面的按钮 */
    property Component bottombtn: Rectangle {
        height: style.btnWidth
        width: height
        radius: height/2

        Text {
            anchors.centerIn: parent
            color: "#333"
            text:"●▽●"
        }
    }

    /*!  左边的按钮 */
    property Component leftbtn: Rectangle {
        height: style.btnWidth
        width: height
        radius: height/2

        Text {
            anchors.centerIn: parent
            color: "#333"
            text:"●ε●"
        }
    }

    /*! 右边的按钮 */
    property Component rightbtn: Rectangle {
        height: style.btnWidth
        width: height
        radius: height/2

        Text {
            anchors.centerIn: parent
            color: "#333"
            text:"●^●"
        }
    }

    /*! 面板 */
    property Component panel: Item {
        anchors.fill: parent

        Loader {
            id: backgroundloader
            height: Math.min(root.height-style.btnWidth*2-style.btnMargin*2, root.width-style.btnWidth*2-style.btnMargin*2)
            width: height
            anchors.centerIn: parent
            sourceComponent: background
        }
    }
}

