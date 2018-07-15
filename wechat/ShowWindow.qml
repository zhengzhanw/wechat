import QtQuick 2.0
import QtQuick.Window 2.2

Window {
    id: inletSettingPanel
    title: "消息提示框"
    flags: Qt.FramelessWindowHint|Qt.Popup
    minimumWidth: 100;
    minimumHeight: 100;
    x:Screen.width - 150
    y:50
    property int imgNum: 0

    Image{
        width: parent.width
        height: parent.height
        source: "qrc:/img/message"+ imgNum +".jpg"
    }
}
