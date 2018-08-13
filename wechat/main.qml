import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    id:mainWindow
    visible: true
    width: 1000
    height: 732
    title: qsTr("wechat")

    property int sWidth: Screen.desktopAvailableWidth
    property int sHeight: Screen.desktopAvailableHeight

    onClosing: {
        Qt.quit()
    }

    Rectangle {
        width: parent.width
        height: parent.height
        WechatFrame {

        }
    }
    Component.onCompleted: {

        console.log(sWidth)
        console.log(sHeight)
    }
}
