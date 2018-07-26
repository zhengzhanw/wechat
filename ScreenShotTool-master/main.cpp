#include "screenshottool.h"
#include <QApplication>
#include <QGuiApplication>
#include <QTranslator>


/*
 * Author:qiuzhiqian
 * Email:xia_mengliang@163.com
 * Github:https://github.com/qiuzhiqian
 * Date:2017.07.23
 **/

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

    a.setQuitOnLastWindowClosed(false);         //防止窗体全部掩藏后意外退出
    ScreenShotTool w;
//    w.hide();

    return a.exec();
}
