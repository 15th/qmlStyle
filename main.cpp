#include <QApplication>
#include <QQmlApplicationEngine>
#include <QtQml>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterSingletonType(QUrl("qrc:/Base/Config.qml"), "Ths", 1, 0, "Config");
    qmlRegisterSingletonType(QUrl("qrc:/Base/TextStandard.qml"), "Ths", 1, 0, "TextStandard");
    qmlRegisterSingletonType(QUrl("qrc:/ColorPalette/ColorPalette.qml"), "Ths", 1, 0, "ColorPalette");

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
