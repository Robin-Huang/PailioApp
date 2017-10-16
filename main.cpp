#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "imageClient.h"
#include "galleryMenu.h"
#include "loadPailioInfo.h"
#include <iostream>


int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QScopedPointer<imageClient> client(new imageClient);
    QScopedPointer<galleryMenu> gallery(new galleryMenu);
    QScopedPointer<loadPailioInfo> infoPros(new loadPailioInfo);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    engine.rootContext()->setContextProperty("client",  client.data());
    engine.rootContext()->setContextProperty("gallery", gallery.data());
    engine.rootContext()->setContextProperty("infoPros", infoPros.data());

    return app.exec();
}
