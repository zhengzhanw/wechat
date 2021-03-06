﻿import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Window 2.2
import QtWebEngine 1.4

Item {
    width: parent.width
    height: parent.height
    WebEngineView  {
        id: webView
        anchors.fill: parent
        width: 1000
        height: 732
        url: "https://wx2.qq.com/?lang=zh_CN"
        settings.pluginsEnabled:true

        onNewViewRequested: {
            console.log(request.requestedUrl.toString())
            console.log("new view request")
//            request.openIn(webView)
//            Qt.openUrlExternally(request.requestedUrl)
            var newWindow = windowComponent.createObject(mainWindow)
            if (request.requestedUrl.toString().search("file.wx2.qq.com") !== -1){
                console.log("download")
                newWindow.downloadFile = true
                newWindow.visible = false
                request.openIn(newWindow.webView)

            }
            else{
                console.log("open view")
                newWindow.width = 800
                newWindow.height = 600
                newWindow.flags = Qt.MSWindowsFixedSizeDialogHint
                request.openIn(newWindow.webView)
            }
        }

        onLoadingChanged:{
            console.log(loadRequest.url)
            if(loadRequest.status == 0 && loadRequest.url != 'https://wx2.qq.com/?lang=zh_CN'){
                var newWindow = windowComponent.createObject(mainWindow)
                profile.downloadRequested.connect(newWindow.onDownloadRequested)
                profile.downloadFinished.connect(newWindow.onDownloadFinished)
            }


        }

        Timer {
               //interval属性用来设置时间间隔，单位是毫秒，默认值是1000毫秒；
               //repeat属性设置是否重复触发，如果为false，值触发一次，并将running自动设为false
               //running属性为true时开启定时器，否则停止定时器
               //定时器触发执行onTriggered()信号处理函数，可以定义一些操作
               //Timer还提供了一些函数，如restart()、start()和stop()等
               interval: 1000; running:true; repeat:true
               onTriggered: {
//                   webView.findText("div", WebEngineView.FindCaseSensitively, function(success){
//                       console.log('web view ' + success)
//                   })

                   webView.runJavaScript("document.getElementsByClassName('web_wechat_reddot_middle').length > 0",function(result){
                        if (result){
                            if (needShowWindowPanel.visible == false){
                                needShowWindowPanel.visible = true
                                needShowWindowPanel.imgNum = (needShowWindowPanel.imgNum + 1)%18
                                needShowWindowPanel.active = false
                            }
                            else{
                                needShowWindowPanel.visible = false
                                needShowWindowPanel.active = false
                            }
                        }else{
                            needShowWindowPanel.visible = false
                            needShowWindowPanel.active = false
                        }
                   })
               }
         }
    }

/*    Dialog {
        id: popup
        x: 100
        y: 100
        width: 200
        height: 300
        modal: false
        focus: true
        visible: true
        MouseArea {
            anchors.fill: parent
            onClicked: {
                popup.visible = false


//                if(!quickFrm)
//                {
//                      quickFrm=Qt.createComponent("QuickTime.qml").createObject(mainRect)

//                }
//                    quickFrm.z = 1
//                    quickFrm.minuteInt = 1            //子页面的一些参数。
//                    quickFrm.secondInt = 0
            }
        }

    }
*/
    property QtObject quickFrm: null
    ShowWindow{
        id: needShowWindowPanel
    }

    property Component windowComponent: Window {
        // Destroy on close to release the Window's QML resources.
        // Because it was created with a parent, it won't be garbage-collected.
        id: wnd
        onClosing: destroy();

        visible: true

        width: 300
        height: 65

        property int _width: width
        property int  _height: height
        property bool downloadFile: false

        flags: Qt.FramelessWindowHint

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
//            onNewViewRequested: {
//                var newWindow = windowComponent.createObject(mainWindow)
//                request.openIn(newWindow.webView)

//                if (mainWindow.isInit) {
//                    profile.downloadRequested.connect(newWindow.onDownloadRequested)
//                    profile.downloadFinished.connect(newWindow.onDownloadFinished)
//                    mainWindow.isInit = false;
//                }
//            }

            onLoadingChanged:{
                console.log(loadRequest.url)
                console.log(wnd.downloadFile)
                if(loadRequest.status == 0 && wnd.downloadFile === true){
                    var newWindow = windowComponent.createObject(mainWindow)
                    profile.downloadRequested.connect(newWindow.onDownloadRequested)
                    profile.downloadFinished.connect(newWindow.onDownloadFinished)
                    profile.downloadFinished.connect(wnd.close)
//                    wnd.close()
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
            console.log("onDownloadRequested")
            downloadView.visible = true
            downloadView.progress_val = download.receivedBytes / download.totalBytes
            var arr = download.path.split('/');
            var name = arr[arr.length-1];
            download.path = "/home/data/Qt_file/"+name;
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
            if(reloadTimer.running){
                reloadTimer.stop();
                reloadTimer.running = false;
            }
            if (download.state === 2)
            {
                downloadView.progress_val = 1.0;
            }
            downloadView.visible = false;
            wnd.close();
        }
    }
}

