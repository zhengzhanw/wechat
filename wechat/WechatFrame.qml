import QtQuick 2.0
import QtWebView 1.1
import QtWebEngine 1.0

Item {
    width: parent.width
    height: parent.height
    WebEngineView  {
        anchors.fill: parent
        url: "https://wx2.qq.com/?lang=zh_CN"
    }
}
