import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    visible: true
    width: 1000
    height: 732
    title: qsTr("wechat")

    Rectangle {
        width: parent.width
        height: parent.height
        Wechat {
//            width: parent.width
//            height: parent.height
        }
    }
}
