import QtQuick 2.4
import QtQuick.Controls 1.3
import "./"

Rectangle {
    width: 320
    height: 480
    color: "#000"

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (!wptile.flipped) {
                console.log("beging flipping")
                wptile.beginFlip()
            }
        }
    }

    WPTile {
        id: wptile
        anchors.centerIn: parent
    }

    Button {
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        text: "复原磁贴"
        onClicked: {
            wptile.reset()
        }
    }
}

