pragma Singleton
import QtQuick 2.4
import Ths 1.0

QtObject {
    //基础单位
    property int baseLength: Math.round(TextStandard.font.pixelSize * 72 / TextStandard.font.pointSize / 25.4 * 2)

    function length(pureLength){
        return pureLength ? Math.round( pureLength*baseLength) : baseLength
    }
}

