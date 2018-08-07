#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngine/QtWebEngine>
#include <QWebEngineSettings>
#include "screenshottool.h"
#include <QApplication>
#include <QTranslator>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);

    QApplication app(argc, argv);
    QtWebEngine::initialize();
    QWebEngineSettings* settings = QWebEngineSettings::globalSettings();
    settings->setAttribute(QWebEngineSettings::PluginsEnabled, true);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    app.setQuitOnLastWindowClosed(false);         //防止窗体全部掩藏后意外退出
    ScreenShotTool w;

    w.hide();
//    app.setWindowIcon(QIcon("myico.ico"));

    return app.exec();
}
