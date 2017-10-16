#include "galleryMenu.h"
#include <QDebug>
#include <QDir>

galleryMenu::galleryMenu(QObject *parent) : QObject(parent)
{

}

void galleryMenu::findImages()
{
    QString path = "/sdcard/DCIM"; // android picture path
//    path = "D:/Robin/Picture/Papilionidae/Byasa polyeuctes termessus";

    curPage = 0;
    maxPage = 0;
    numImBtn = 4;

    QDir dir(path);
    dir.setFilter(QDir::AllDirs|QDir::Files|QDir::Readable|QDir::NoDotAndDotDot);
    dir.setSorting(QDir::Time);

    // ********** Set File Extension ------->>
    QStringList nameFilters("*.jpg");
    nameFilters << "*.png" << "*.bmp" << "*.tif";

    // ********** Find Image Files --------->>
    fileList = dir.entryInfoList(nameFilters);

    // ********** Check Direction ---------->>
    int i = 0;
    while(i < fileList.size()){
        if(fileList.at(i).isDir()){
            dir.setPath(fileList.at(i).filePath());
            QFileInfoList tmpList = dir.entryInfoList(nameFilters);

            // Add new images info to list
            for(int j = 0; j < tmpList.size(); j++)
                fileList.append(tmpList.at(j));

            // Remove dir
            fileList.removeAt(i);
            continue;
        }
        i++;
    }

    // No Image
    if(fileList.size() != 0)
        maxPage = (fileList.size()-1) / numImBtn;

    // Only One Page
    if(maxPage == 0)
        sendBtnContrl(1, false);

    displayImage();
}

void galleryMenu::displayImage()
{
    int maxNumIcons = numImBtn;                 // maximum icon number in one page
    int startIndex  = curPage * maxNumIcons;    // first icon index in current page
    if(fileList.size() - startIndex < maxNumIcons)
        maxNumIcons = fileList.size() - startIndex;

    for(int i = 0; i < maxNumIcons; i++){
        // Image Path
        fileInfo = fileList.at(startIndex + i);

        emit sendImagePath(i, fileInfo.filePath(), true);
    }
    emit sendPageNum("< " + QString::number(curPage+1) + "/" + QString::number(maxPage+1) + " >");
}

void galleryMenu::prevBtnPush()
{
    curPage--;

    if(curPage == 0)
        sendBtnContrl(0, false);

    sendBtnContrl(1, true);

    for(int i = 0; i < numImBtn; i++){
        emit sendImagePath(i, "", false);
    }

    displayImage();
}

void galleryMenu::nextBtnPush()
{
    curPage++;

    if(curPage == maxPage)
        sendBtnContrl(1, false);

    sendBtnContrl(0, true);

    for(int i = 0; i < numImBtn; i++){
        emit sendImagePath(i, "", false);
    }

    displayImage();
}
