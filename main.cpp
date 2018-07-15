#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtWebEngine>

int main(int argc, char *argv[])
{
    QGuiApplication::setAttribute(Qt::AA_DisableHighDpiScaling);
    QGuiApplication app(argc, argv);

    QtWebEngine::initialize();

//    QQmlApplicationEngine engine;
//    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    QQuickView viewer;
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);
    viewer.setSource(QUrl("qrc:/main.qml"));

    viewer.rootContext()->setContextProperty("mainwindow",&viewer);

    viewer.show();

    return app.exec();
}
