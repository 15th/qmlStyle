import QtQuick 2.4
import "./"

Rectangle {
    width: 320
    height: 480
    color: "#000"

    LockscreenShortcut {
        height: parent.height-50
        width: parent.width-50
        anchors.centerIn: parent
    }
}

