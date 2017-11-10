#include "imageClient.h"

imageClient::imageClient(QObject *parent) : QObject(parent)
{
    // ********** Connect Signal & Slot ------>>
    connect(&client      , SIGNAL(connected())                        , this, SLOT(startTransfer()));
    connect(&client      , SIGNAL(bytesWritten(qint64))               , this, SLOT(updateProgress(qint64)));
    connect(&client      , SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(displayError(QAbstractSocket::SocketError)));
    connect(&client      , SIGNAL(readyRead())                        , this, SLOT(recieveResult()));
}

void imageClient::setHostAddressAndPort(QString address, quint16 port)
{
    hostAddress.setAddress(address);
    this->hostPort = port;
}

void imageClient::start(QString path)
{
    // ********** Set server address --------->>
    address = "163.20.133.59"; // School
    //address = "172.20.10.3";
    setHostAddressAndPort(address, 37);

    imPath = path;
    if(imPath.contains("file:///"))
        imPath = imPath.split("file:///").at(1);

    // ********** Check File Path ------------>>
    if(imPath == NULL) {
        emit sendWarning("檔案不存在");
        return;
    }

    emit sendStateInfo("連結伺服器...");

    file = new QFile(imPath);
    client.connectToHost(hostAddress, hostPort);
    client.waitForConnected();

//    QApplication::setOverrideCursor(Qt::WaitCursor);
}

void imageClient::startTransfer()
{
    // ********** Check File ----------------->>
    if (!file->open(QIODevice::ReadOnly)) {
        qDebug() << "無法讀取檔案!";
        emit sendWarning("無法讀取檔案!");
        delete file;
        file = 0;
        return;
    }

    // ********** Write File Information ----->>
    QByteArray fileInfo;
    QDataStream sendOut(&fileInfo, QIODevice::WriteOnly);

    fileSize = file->size() + sizeof(qint64); // totatl send size
    emit sendMaxFileSize(fileSize);           // assign maximum progress bar value

    sendOut << (qint64)fileSize;              // write file size
    fileInfo.append(file->readAll());         // write file data
    // sendOut << file->readAll();            // can't use this (have extra bytes)

    // ********** Send File Information ------>>
    sendSize = 0;
    client.write(fileInfo);                   // send file information
}

void imageClient::updateProgress(qint64 numBytes)
{
    // ********** Update Progress Value ------>>
    sendSize = sendSize + (int)numBytes;
    emit sendProgressValue(sendSize);

    // ********** Finish Sending ------------->>
    if(sendSize == fileSize) {
        emit sendStateInfo("圖片傳送完成!");
    }
}

void imageClient::closeConnection()
{
    // Client
    client.close();

    // File
    file->close();
    delete file;

    emit sendProgressValue(0); // reset progress bar

//    QApplication::restoreOverrideCursor();
}

void imageClient::displayError(QAbstractSocket::SocketError socketError)
{
    emit sendWarning("網路錯誤!");
    closeConnection();
}

void imageClient::recieveResult()
{
    emit sendStateInfo("接收辨識結果!");
    if(client.bytesAvailable() > 0){
        // for *char data
        //prosResult = client.readAll();

        // for byteArray
        prosResult = QString::fromUtf8(client.readAll());

        emit sendResult(prosResult);
        closeConnection();
    }
}
