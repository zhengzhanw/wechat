#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngine/QtWebEngine>
#include <QWebEngineSettings>

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QCoreApplication::setAttribute(Qt::AA_UseOpenGLES);

    QGuiApplication app(argc, argv);
    QtWebEngine::initialize();
    QWebEngineSettings* settings = QWebEngineSettings::globalSettings();
    settings->setAttribute(QWebEngineSettings::PluginsEnabled, true);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

//    app.setWindowIcon(QIcon("myico.ico"));

    return app.exec();
}
