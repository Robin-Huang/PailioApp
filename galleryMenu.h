#ifndef GALLERYMENU_H
#define GALLERYMENU_H

#include <QObject>
#include <QFileInfoList>

class galleryMenu : public QObject
{
    Q_OBJECT
public:
    explicit galleryMenu(QObject *parent = nullptr);
    void displayImage();

signals:
    void sendImagePath(int index, QString imPath, bool enab);
    void sendPageNum(QString pageNum);
    void sendBtnContrl(int indBtn, bool enab); // inBtn: 0 is prevBtn, 1 is nextBtn

public slots:
    Q_INVOKABLE void findImages();
    Q_INVOKABLE void prevBtnPush();
    Q_INVOKABLE void nextBtnPush();

private:
    QFileInfoList fileList;
    QFileInfoList tmpList;
    QFileInfo     fileInfo;

    int curPage;
    int maxPage;
    int numImBtn;

    QString imPathInfo;
};

#endif // GALLERYMENU_H
