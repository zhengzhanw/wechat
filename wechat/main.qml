import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 1003
    height: 732
    title: qsTr("wechat")
    Rectangle {
        width: parent.width
        height: parent.height
        WechatFrame {
            width: parent.width
            height: parent.height
        }
    }
}
