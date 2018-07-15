import QtQuick 2.6
import QtQuick.Window 2.2

Item {
    id: mainwindow
    visible: true
    width: 1000
    height: 733

//    title: qsTr("WeChat")
//    flags:Qt.FramelessWindowHint|Qt.MSWindowsOwnDC
    Rectangle{
        width: parent.width
        height: parent.height
        WebFrame{
            width: parent.width
            height: parent.width
        }
        Component.onCompleted: {
            console.debug("sssss")
        }
    }
}
