#ifndef LOADPAILIOINFO_H
#define LOADPAILIOINFO_H

#include <QObject>

class loadPailioInfo : public QObject
{
    Q_OBJECT
public:
    explicit loadPailioInfo(QObject *parent = nullptr);
    void readText(QString name);

signals:
    void sendImagePath(QString imPath);
    void sendInfoText(QString fullText);

public slots:
    Q_INVOKABLE void readInfo(QString infoText);
};

#endif // LOADPAILIOINFO_H
