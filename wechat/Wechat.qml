import QtQuick 2.4
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtWebEngine 1.3

QtObject {
    id: windowParent
    property bool isInit: true
    // Create the initial browsing windows and open the startup page.
    Component.onCompleted: {
        var firstWindow = windowComponent.createObject(windowParent)
        firstWindow.webView.url = "https://www.baidu.com"
    }

    property Component windowComponent: Window {
        // Destroy on close to release the Window's QML resources.
        // Because it was created with a parent, it won't be garbage-collected.
        id: wnd
        onClosing: destroy();
        visible: true

        width: 800
        height: 600

        property var downloads;
        property QtObject defaultProfile: WebEngineProfile {
            storageName: "Default"
        }

        property WebEngineView webView: webView_
        WebEngineView {
            id: webView_
            anchors.fill: parent

            // Handle the signal. Dynamically create the window and
            // use its WebEngineView as the destination of our request.
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

        Rectangle {
            id: downloadView
            visible: false
            width: parent.width - 100
            height: 20
            color: "green"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            property real progress_val;
            Rectangle {
                id: progress_complete
                color: "red"
                anchors.left: parent.left
                width: parent.width*downloadView.progress_val
                height: parent.height
            }
            Label {
                anchors.left: progress_complete.right
                anchors.leftMargin: 10
                anchors.verticalCenter: progress_complete.verticalCenter
                text:parseInt(downloadView.progress_val*100) + "%"
                font.bold: true
                color: "red"
            }
        }
        Timer {
            id: reloadTimer
            interval: 10
            running: false
            repeat: true
            onTriggered: {
                downloadView.progress_val = downloads.receivedBytes / downloads.totalBytes
            }
        }
        function onDownloadRequested(download) {
            downloadView.visible = true
            downloadView.progress_val = download.receivedBytes / download.totalBytes
            var arr = download.path.split('/');
            var name = arr[arr.length-1];
            download.path = "E:/Qt_Test/"+name;
            downloads = download;
            console.log("download->path=", download.path);
            reloadTimer.start();
            reloadTimer.running = true;
            wnd.width = 300;
            wnd.height = 130;
            download.accept();
        }
        function onDownloadFinished(download){
            console.log("onDownloadFinished")
            reloadTimer.stop();
            reloadTimer.running = false;
            if (download.state === 2)
            {
                downloadView.progress_val = 1.0;
            }
            downloadView.visible = false;
            wnd.close();
        }
    }
}
