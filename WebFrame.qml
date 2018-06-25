import QtQuick 2.0
import QtQuick.Controls 2.0
import QtWebView 1.1

Item {
    id: webFrame
    width: parent.width
    height: parent.width
    Rectangle {
        id: webBack
        width: parent.width
        height: parent.height

        WebView {
            id: webView
            url: "https://www.baidu.com"
        }
    }
}
