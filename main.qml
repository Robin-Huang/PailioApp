import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Layouts 1.3
import QtMultimedia 5.9

ApplicationWindow {
    width: 400
    height: 600
    visible: true
    title: qsTr("Hello World")

    Item{
        id: mainMenu
        anchors.fill: parent

        GridLayout {
            id: gridLayout

            columnSpacing: 5
            rowSpacing: 5

            anchors.rightMargin:  10
            anchors.leftMargin:   10
            anchors.bottomMargin: 10
            anchors.topMargin:    10
            anchors.fill: parent

            columns: 1
            rows: 2

            RoundButton {
                id: camerBtn

                radius: 200

                Layout.minimumHeight: 200
                Layout.minimumWidth:  200
                Layout.fillHeight:    false
                Layout.fillWidth:     false
                Layout.alignment:     Qt.AlignHCenter | Qt.AlignVCenter

                Image{
                    fillMode:     Image.PreserveAspectFit
                    source:       "images/camera.png"
                    anchors.fill: parent
                }

                onClicked: {
                    mainMenu.visible   = false;
                    cameraMenu.visible = true;
                }
            }

            RoundButton {
                id: galleryBtn

                width:  621
                radius: 200

                Layout.minimumHeight: 200
                Layout.minimumWidth:  200
                Layout.alignment:     Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight:    false
                Layout.fillWidth:     false

                Image{
                    fillMode:     Image.PreserveAspectFit
                    source:       "images/gallery.png"
                    anchors.fill: parent
                }

                onClicked: {
                    mainMenu.visible    = false;
                    galleryMenu.visible = true;
                    gallery.findImages();
                }
            }
        }
    }

    CameraMenu{
        id: cameraMenu
        visible: false
        anchors.fill: parent
    }

    GalleryMenu{
        id: galleryMenu
        visible: false
        anchors.fill: parent
    }
}
