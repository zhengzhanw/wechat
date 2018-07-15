import QtQuick 2.0
import QtQuick.Controls 2.0
import QtWebEngine 1.2

Item {
    id: webFrame
    width: parent.width
    height: parent.width

    WebEngineView {
        id: webView
        width: parent.width
        height: parent.width
        url: "https://wx.qq.com/"

        onLoadingChanged: {
            console.log(loadRequest.status);
//            console.log(this.userScripts)
//            console.log(this.webChannelWorld)
//            findText('web_wechat_reddot_middle')
            if (this.loadProgress === 100){
                findText("web_wechat_reddot_middle", WebEngineView.FindCaseSensitively, function(success){
                    console.log(success);
                });
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
                   webView.findText("div", WebEngineView.FindCaseSensitively, function(success){
                       console.log('web view ' + success)
                   })

                   webView.runJavaScript("document.getElementsByClassName('qrcode').length > 0",function(result){
                        console.log(result)
                   })
               }
         }

    }
}

