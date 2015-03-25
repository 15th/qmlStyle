import QtQuick 2.4
import QtQuick.Controls 1.3

//eg.
import "Base"
import "ColorPalette"
import "DragBar"
import "IOS-RadioButton"
import "LockscreenShortcut"
import "./WPTile"

ApplicationWindow {
    title: qsTr("qmlStyle")
    width: 320
    height: 480
    visible: true

    LauncherList {
        anchors.fill: parent
        Component.onCompleted: {
            addExample("DragBar", "实现QQ列表界面侧划效果", Qt.resolvedUrl("DragBar/MenuDragBar.qml"))
            addExample("ColorPalette", "一种调色板类似的实现策略", Qt.resolvedUrl("ColorPalette/MenuColorPalette.qml"))
            addExample("IOS-RadioButton", "仿照ios开关按钮效果", Qt.resolvedUrl("IOS-RadioButton/MenuRadioButton.qml"))
            addExample("LockscreenShortcut", "仿小米锁屏4界面方向快捷键", Qt.resolvedUrl("LockscreenShortcut/MenuLockscreenShortcut.qml"))
            addExample("WPTile", "WP风格磁贴实现", Qt.resolvedUrl("WPTile/MenuWPTile.qml"))
        }
    }
}
