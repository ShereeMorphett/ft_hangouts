#ifndef SOMECLASS_H
#define SOMECLASS_H

#include <QObject>
#include <QString>

class SomeClass : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString someVar READ someVar WRITE setSomeVar NOTIFY someVarChanged FINAL)

public:
    explicit SomeClass(QObject *parent = nullptr);
    Q_INVOKABLE void anotherFunction();
    QString someVar();

signals:
    void someVarChanged();

public slots:
    void callMe();
    void handleLogin(QString user, QString pass);
    void setSomeVar(QString newVar);

private:
    QString m_someVar;
};

#endif // SOMECLASS_H
