import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("WeChat")

    Rectangle{
        width: parent.width
        height: parent.height
//        WebFrame{
//            width: parent.width
//            height: parent.height
//        }
        Rectangle{
            width: parent.width/2
            height: parent.height*0.8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter:  parent.verticalCenter
        }
        Component.onCompleted: {
            console.debug("sssss")
        }
    }
}
