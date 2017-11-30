import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    width: 400
    height: 600

    function closeMouseArea(){
        mouseArea_1.enabled = false;
        mouseArea_2.enabled = false;
        mouseArea_3.enabled = false;
        mouseArea_4.enabled = false;
    }

    Connections{
        target: gallery
        onSendImagePath:{
            switch(index){
            case 0:
                image_1.source = "file:///" + imPath;
                mouseArea_1.enabled = enab;
                break;
            case 1:
                image_2.source = "file:///" + imPath;
                mouseArea_2.enabled = enab;
                break;
            case 2:
                image_3.source = "file:///" + imPath;
                mouseArea_3.enabled = enab;
                break;
            case 3:
                image_4.source = "file:///" + imPath;
                mouseArea_4.enabled = enab;
                break;
            }
        }
        onSendPageNum:{
            page.text = pageNum;
        }
        onSendBtnContrl:{
            switch(indBtn){
            case 0:
                if(enab){
                    prevPage.enabled = true
                    prevPageIm.source = "images/arrow-left.png"
                }
                else{
                    prevPage.enabled = false
                    prevPageIm.source = "images/arrow-left-false.png"
                }
                break;
            case 1:
                if(enab){
                    nextPage.enabled = true
                    nextPageIm.source = "images/arrow-right.png"
                }
                else{
                    nextPage.enabled = false
                    nextPageIm.source = "images/arrow-right-false.png"
                }
                break;
            }
        }
    }

    Rectangle {
        id: galleryUI
        color: "#ededed"
        anchors.fill: parent

        Image{
            anchors.fill: parent
            source: "images/butterfly-wallpaper.png"
            fillMode: Image.Stretch
        }

        GridLayout {
            id: gridLayout
            flow: GridLayout.LeftToRight

            rows: 0
            columns: 1

            anchors.rightMargin:  10
            anchors.leftMargin:   10
            anchors.bottomMargin: 10
            anchors.topMargin:    10
            anchors.fill: parent

            Label {
                id: title

                text:           qsTr("Choose Image")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.pointSize: 24
                Layout.minimumHeight: 80
                font.family:    "Arial"
                font.bold:      true

                Layout.fillWidth: true
                verticalAlignment:   Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                background: Rectangle{
                    anchors.fill: parent
                    color: "#ffffff"
                }

                RoundButton {
                    id: closeBtn
                    width: closeBtn.height

                    anchors.right:        parent.right
                    anchors.rightMargin:  5
                    anchors.top:          parent.top
                    anchors.topMargin:    5
                    anchors.bottom:       parent.bottom
                    anchors.bottomMargin: 5

                    Image{
                        fillMode:     Image.PreserveAspectFit
                        source:       "images/cancel.png"
                        anchors.fill: parent
                    }

                    onClicked: {
                        galleryMenu.visible = false;
                        mainMenu.visible    = true;
                    }
                }
            }

            GridLayout {
                id: gridLayout1

                rows:    2
                columns: 2

                Layout.fillHeight: true
                Layout.alignment:  Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth:  true

                Rectangle {
                    id: imRect_1
                    width: 200
                    height: 200
                    color: "#ffffff"
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Image {
                        id: image_1
                        anchors.fill: parent
                        Layout.fillHeight: true
                        Layout.fillWidth:  true
                        asynchronous: true
                        sourceSize: Qt.size(imRect_1.width,imRect_1.height)

                        MouseArea {
                            id: mouseArea_1
                            anchors.fill: parent
                            enabled: false
                            onClicked: {
                                photoPreview.source = image_1.source;
                                photoPreview.sourceFrom = 'gallery';
                                photoPreview.visible = true;
                                galleryUI.visible    = false;
                            }
                        }
                    }
                }

                Rectangle {
                    id: imRect_2
                    width: 200
                    height: 200
                    color: "#ffffff"
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Image {
                        id: image_2
                        anchors.fill: parent
                        Layout.fillHeight: true
                        Layout.fillWidth:  true
                        asynchronous: true
                        sourceSize: Qt.size(imRect_2.width, imRect_2.height)

                        MouseArea {
                            id: mouseArea_2
                            anchors.fill: parent
                            enabled: false
                            onClicked: {
                                photoPreview.source = image_2.source;
                                photoPreview.sourceFrom = 'gallery';
                                photoPreview.visible = true;
                                galleryUI.visible    = false;
                            }
                        }
                    }
                }

                Rectangle {
                    id: imRect_3
                    width: 200
                    height: 200
                    color: "#ffffff"
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Image {
                        id: image_3
                        anchors.fill: parent
                        Layout.fillHeight: true
                        Layout.fillWidth:  true
                        asynchronous: true
                        sourceSize: Qt.size(imRect_3.width, imRect_3.height)

                        MouseArea {
                            id: mouseArea_3
                            anchors.fill: parent
                            enabled: false
                            onClicked: {
                                photoPreview.source = image_3.source;
                                photoPreview.sourceFrom = 'gallery';
                                photoPreview.visible = true;
                                galleryUI.visible    = false;
                            }
                        }
                    }
                }

                Rectangle {
                    id: imRect_4
                    width: 200
                    height: 200
                    color: "#ffffff"
                    Layout.fillHeight: true
                    Layout.fillWidth: true

                    Image {
                        id: image_4
                        anchors.fill: parent
                        Layout.fillHeight: true
                        Layout.fillWidth:  true
                        asynchronous: true
                        sourceSize: Qt.size(imRect_4.width, imRect_4.height)

                        MouseArea {
                            id: mouseArea_4
                            anchors.fill: parent
                            enabled: false
                            onClicked: {
                                photoPreview.source = image_4.source;
                                photoPreview.sourceFrom = 'gallery';
                                photoPreview.visible = true;
                                galleryUI.visible    = false;
                            }
                        }
                    }
                }
            }

            RowLayout {
                id: rowLayout
                Layout.fillWidth: true

                RoundButton {
                    id: prevPage
                    Layout.minimumHeight: 80
                    Layout.minimumWidth: 80
                    enabled: false

                    Image{
                        id: prevPageIm
                        fillMode:     Image.PreserveAspectFit
                        source:       "images/arrow-left-false.png"
                        anchors.fill: parent
                    }

                    onClicked: gallery.prevBtnPush();
                }

                Label {
                    id: page

                    text: qsTr("<1/1>")
                    font.bold: true
                    font.family: "Arial"
                    font.pointSize: 22

                    verticalAlignment:   Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    Layout.alignment:    Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillWidth:    true
                }

                RoundButton {
                    id: nextPage
                    Layout.minimumHeight: 80
                    Layout.minimumWidth: 80

                    Image{
                        id: nextPageIm
                        fillMode:     Image.PreserveAspectFit
                        source:       "images/arrow-right.png"
                        anchors.fill: parent
                    }

                    onClicked: gallery.nextBtnPush();
                }
            }
        }
    }

    PhotoPreview{
        id: photoPreview
        visible: false
        anchors.fill: parent
    }
}
