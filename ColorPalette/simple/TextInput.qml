import QtQuick 2.4
import QtQuick.Controls 1.3

TextField {
    id: root

    property string skinUrl: "skin1"

    style: Qt.createComponent(skinUrl+"/TextInputStyle.qml", root)
}

