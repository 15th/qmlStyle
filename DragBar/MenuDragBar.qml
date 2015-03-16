import QtQuick 2.4
import "./"

Item {
    id: menu
    width: 320
    height: 480

    ListView {
        anchors.fill: parent
        model: 7
        delegate: DragBar {
        }
        onFlickStarted: menu.forceActiveFocus()
    }
}
