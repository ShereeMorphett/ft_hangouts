#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QSqlDatabase>
#include <QtSensors>

#include "someclass.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QAccelerometer *accelerometer = new QAccelerometer();

    QObject::connect(accelerometer, &QAccelerometer::readingChanged, [&](){
        QAccelerometerReading *reading = accelerometer->reading();
        if (reading) {
            // qDebug() << "Accelerometer: x=" << reading->x() << "y=" << reading->y() << "z=" << reading->z();
        }
    });

    accelerometer->start();
    /*will leave scope if using multiple QML files, ie if main.QML finished and using another QML, this leaves scope*/
    qmlRegisterType<SomeClass>("someclass", 1, 0, "SomeClass");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    qDebug() << QSqlDatabase::drivers();
    engine.loadFromModule("ft_hangouts", "Main");

    return app.exec();
}
