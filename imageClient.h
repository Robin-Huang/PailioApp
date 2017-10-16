#ifndef IMAGECLIENT_H
#define IMAGECLIENT_H

#include <QObject>
#include <QHostAddress>
#include <QTcpSocket>
#include <QImage>
#include <QFile>
#include <iostream>

class imageClient : public QObject
{
    Q_OBJECT
public:
    explicit imageClient(QObject *parent = nullptr);
    void setHostAddressAndPort(QString hostAddress, quint16 port);
    void closeConnection();


signals:
    void sendStateInfo(QString info);
    void sendMaxFileSize(qint64 fsize);
    void sendProgressValue(int value);
    void sendWarning(QString warn);
    void sendResult(QString result);

public slots:
    Q_INVOKABLE void start(QString path);
    Q_INVOKABLE void startTransfer();
    Q_INVOKABLE void updateProgress(qint64 numBytes);
    Q_INVOKABLE void displayError(QAbstractSocket::SocketError socketError);
    Q_INVOKABLE void recieveResult();

private:
    // Tcp Socket
    QTcpSocket   client;
    QString      address;
    QHostAddress hostAddress;
    quint16      hostPort;

    // Image File
    QFile       *file;
    QImage       image;
    QString      imPath;
    qint64       fileSize;
    int          sendSize;

    QString      stateInfo;
    QString      prosResult;
};

#endif // IMAGECLIENT_H
