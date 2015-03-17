import QtQuick 2.4
import QtQuick.Controls.Styles 1.3
import Ths 1.0

// in skin1

TextFieldStyle {
    id: style

    textColor: ColorPalette.color(1)

    background: Rectangle {
        color: ColorPalette.color(2)
    }

    /*!设置标题显示内容*/
    property Component title: Rectangle {
        width: 80
        color: ColorPalette.color(1)

        Text{
            id: titletext
            anchors.centerIn: parent
            text: control.title
            color: ColorPalette.color(3)
        }
    }

    panel :Item {
        anchors.fill: parent

        property int topMargin: 4
        property int leftMargin: titleLoader.width+5
        property int rightMargin: control.__contentHeight/3
        property int bottomMargin: 4

        property color textColor: style.textColor
        property color selectionColor: style.selectionColor
        property color selectedTextColor: style.selectedTextColor

        implicitWidth: backgroundLoader.implicitWidth || Math.round(control.__contentHeight * 8)
        implicitHeight: backgroundLoader.implicitHeight || Math.max(25, Math.round(control.__contentHeight * 1.2))
        baselineOffset: 4 + control.__baselineOffset

        property color placeholderTextColor: style.placeholderTextColor
        property font font: style.font

        Loader{
            id:backgroundLoader
            anchors.fill: parent
            sourceComponent: background
        }

        Loader{
            id:titleLoader
            anchors.left: backgroundLoader.Left
            anchors.top: backgroundLoader.top
            anchors.bottom: backgroundLoader.bottom
            sourceComponent: title
        }
    }
}
