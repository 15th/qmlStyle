pragma Singleton
import QtQuick 2.4


Item {
    id:colorRoot

    property string skinUrl: "skin1" //皮肤url
    property string colorType: "purple" //主题颜色

    property string __colorComponentUrl: "qrc:/ColorPalette/simple/"+skinUrl+"/ColorTable.qml" //主题URL

    property Component __colorComponent: null

    property var __colorTable

    onColorTypeChanged: {
        colorRoot.initComponent()
    }

    function initComponent() {
        colorRoot.__colorComponent = Qt.createComponent(colorRoot.__colorComponentUrl)
        if (colorRoot.__colorComponent.status === Component.Ready) {
            colorRoot.__colorTable = colorRoot.__colorComponent.createObject(colorRoot);
        }
    }

    function color(type) {
        if (__colorComponent === null) {
            colorRoot.initComponent()
        }
        try {
            if (colorRoot.__colorTable[colorRoot.colorType].hasOwnProperty(type)){
                return colorRoot.__colorTable[colorRoot.colorType][type]
            }else{
                return "#000000"
            }
        }catch (err) {
            return "#000000"
        }
    }
}
