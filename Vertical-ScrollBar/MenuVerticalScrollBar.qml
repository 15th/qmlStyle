import QtQuick 2.6
import QtQuick.Controls 1.4
import "./"

Item {
    width: 320
    height: 480

    Rectangle {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
        border.width: 1
        border.color: "#cccccc"

        Flickable {
            id: content
            anchors.fill: parent
            contentHeight: words.contentHeight
            boundsBehavior: Flickable.StopAtBounds
            interactive: false
            clip: true

            Text {
                id: words
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.topMargin: 5
                anchors.bottomMargin: anchors.topMargin
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                lineHeight: 1.5
                text: "Who killed Cock Robin?
I,said the Sparrow,
With my bow and arrow,
I killed Cock Robin.
Who saw him die?
I,said the Fly.
With my little eye,
I saw him die.
Who caught his blood?
I,said the Fish,
With my little dish,
I caught his blood.
Who'll make his shroud?
I,said the Beetle,
With my thread and needle,
I'll make the shroud.
Who'll dig his grave?
I,said the Owl,
With my pick and shovel,
I'll dig his grave.
Who'll be the parson?
I,said the Rook,
With my little book,
I'll be the parson.
Who'll be the clerk?
I,said the Lark,
If it's not in the dark,
I'll be the clerk.
Who'll carry the link?
I,said the Linnet,
I'll fetch it in a minute,
I'll carry the link.
Who'll be chief mourner?
I,said the Dove,
I mourn for my love,
I'll be chief mourner.
Who'll carry the coffin?
I,said the Kite,
If it's not through the night,
I'll carry the coffin.
Who'll bear the pall?
We,said the Wren,
Both the cock and the hen,
We'll bear the pall.
Who'll sing a psalm?
I,said the Thrush,
As she sat on a bush,
I'll sing a psalm.
Who'll toll the bell?
I,said the Bull,
Because I can pull,
So Cock Robin,farewell.
All the birds of the air
Fell a-sighing and a-sobbing,
When they heard the bell toll
For poor Cock Robin.
NOTICE
To all it concerns,
This notice apprises,
The Sparrow's for trial,
At next bird assizes."
            }
        }
        VerticalScrollBar {
            id: scrollbar
            height: content.height-2
            anchors.right: content.right
            anchors.rightMargin: 1
            anchors.verticalCenter: content.verticalCenter

            handleItem: content
            size: content.visibleArea.heightRatio * content.height
            position: content.visibleArea.yPosition * content.height-1
        }
    }
}
