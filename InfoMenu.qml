import QtQuick 2.8
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {
    width: 400
    height: 600

    property alias className : title.text

    Connections{
        target: infoPros
        onSendImagePath:{
            image.source = imPath;
        }
        onSendInfoText:{
            textArea.text = fullText;
        }
    }


    Rectangle {
        id: rectangle
        color: "#ffffff"
        anchors.fill: parent

        Image{
            anchors.fill: parent
            source: "images/butterfly-wallpaper.png"
            fillMode: Image.Stretch
        }

        GridLayout {
            id: gridLayout
            rows: 3
            anchors.rightMargin: 0
            anchors.leftMargin: 0
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            columns: 1
            anchors.fill: parent

            Label {
                id: title
                text: qsTr("Label")
                font.family: "Arial"
                font.bold: true
                font.pointSize: 22
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                Layout.minimumHeight: 80
                Layout.fillWidth: true

                RoundButton {
                    id: cancelBtn
                    width: cancelBtn.height

                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 0
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.right: parent.right
                    anchors.rightMargin: 0

                    Image{
                        fillMode:     Image.PreserveAspectFit
                        source:       "images/cancel.png"
                        anchors.fill: parent
                    }

                    onClicked: {
                        infoMenu.visible = false;
                        previewArea.visible = true;
                    }
                }

            }

            Image {
                id: image
                width: 100
                height: 200
                Layout.minimumWidth: 200
                Layout.minimumHeight: 200
                Layout.fillHeight: false
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter


                fillMode: Image.PreserveAspectFit
                asynchronous: true
            }

            ScrollView{
                spacing: 0

                Layout.fillHeight: true
                Layout.fillWidth: true

                TextArea {
                    id: textArea
                    text: qsTr("Text Area")
                    anchors.fill: parent
                    font.family: "Arial"
                    font.pointSize: 14

                    wrapMode: Text.Wrap // 文字自動換行
                }
            }

        }
    }
}
