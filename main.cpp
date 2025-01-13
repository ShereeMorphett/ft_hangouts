#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtSensors>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QAccelerometer *accelerometer = new QAccelerometer();

    QObject::connect(accelerometer, &QAccelerometer::readingChanged, [&](){
        QAccelerometerReading *reading = accelerometer->reading();
        if (reading) {
            qDebug() << "Accelerometer: x=" << reading->x() << "y=" << reading->y() << "z=" << reading->z();
        }
    });

    // Start the sensors
    accelerometer->start();


    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("ft_hangouts", "Main");
    return app.exec();
}
