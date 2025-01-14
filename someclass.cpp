#include "someclass.h"
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>

//getter
QString SomeClass::someVar()
{
    return m_someVar;
}

void SomeClass::setSomeVar(QString newVar)
{
    if (m_someVar != newVar) {
        m_someVar = newVar;
        emit someVarChanged();
    }
}

void SomeClass::handleLogin(QString user, QString pass)
{
    QSqlDatabase sqldb = QSqlDatabase::addDatabase("QSQLITE");
    sqldb.setDatabaseName("contact.db");
    qDebug() << "I got your user:   " << user << "   Pass" << pass;
    if (sqldb.open()) {
        qDebug() << "DATABASE FOUND";
        QSqlQuery query(sqldb);
        query.prepare("SELECT * FROM users WHERE username = :username AND password = :password");
        query.bindValue(":username", user);
        query.bindValue(":password", pass);
        if (query.exec()) {
            qDebug() << "Query executed successfully.";
        } else {
            qDebug() << "Query was unsuccessful.";
        }
    } else {
        qDebug() << "DATABASE CONNECTION FAILED";
    }
}

void SomeClass::callMe()
{
    qDebug() << "I am being called";
}

void SomeClass::anotherFunction()
{
    qDebug() << "Called another function";
}

SomeClass::SomeClass(QObject *parent)
    : QObject{parent}
    , m_someVar("123")
{
    qDebug() << "Some class was created";
}
