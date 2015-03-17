import QtQuick 2.4
import QtQuick.Controls 1.3
import Ths 1.0

TextField {
    id: root

    property string skinUrl: ColorPalette.skinUrl

    property string title

    style: Qt.createComponent(skinUrl+"/TextInputStyle.qml", root)

    width: parent.width
    height: 40
}

