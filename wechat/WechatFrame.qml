import QtQuick 2.0
import QtWebView 1.1
import QtWebEngine 1.0

Item {
    width: parent.width
    height: parent.height
    WebEngineView  {
        anchors.fill: parent
        width: 1000
        height: 732
        url: "https://wx2.qq.com/?lang=zh_CN"

        onNewViewRequested: {
            var newWindow = windowComponent.createObject(windowParent)
            request.openIn(newWindow.webView)

            if (windowParent.isInit) {
                profile.downloadRequested.connect(newWindow.onDownloadRequested)
                profile.downloadFinished.connect(newWindow.onDownloadFinished)
                windowParent.isInit = false;
            }
        }
    }
}
