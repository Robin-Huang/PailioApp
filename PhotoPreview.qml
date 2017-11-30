import QtQuick 2.7
import QtMultimedia 5.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.4


Item {
    property alias source : preview.source
    property string sourceFrom: ''
    signal closed
    width: 400
    height: 600

    Connections{
        target: client
        onSendStateInfo: {
            stateInfo.text = info;
        }
        onSendMaxFileSize: {
            sendProgress.to = fsize;
        }
        onSendProgressValue: {
            sendProgress.value = value;
        }
        onSendWarning: {
            stateInfo.text = warn;
            cancelBtn.enabled = true;
            sendBtn.enabled = true;
        }
        onSendResult: {
            stateInfo.text = result;
            cancelBtn.enabled = true;
            sendBtn.enabled = true;

            // Open Information Menu
            previewArea.visible = false;
            infoMenu.visible = true;
            infoMenu.className = result;
            infoPros.readInfo(result);
        }
    }

    Rectangle{
        id: previewArea
        color: "#e6e6e6"
        anchors.fill: parent

        Image{
            anchors.fill: parent
            source: "images/butterfly-wallpaper.png"
            fillMode: Image.Stretch
        }

        GridLayout {
            id: gridLayout
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            rowSpacing: 10
            anchors.fill: parent
            rows: 6
            columns: 1

            Label {
                id: title

                text: qsTr("Photo Preview")
                font.pointSize: 24
                font.bold: true
                font.family: "Arial"

                Layout.minimumHeight: 80
                Layout.fillWidth: true

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                background: Rectangle{
                    anchors.fill: parent
                    color: "#ffffff"
                }

                RoundButton {
                    id: cancelBtn
                    width: cancelBtn.height

                    anchors.right: parent.right
                    anchors.rightMargin: 5
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 5
                    anchors.top: parent.top
                    anchors.topMargin: 5
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.minimumWidth: 100
                    spacing: 0
                    Layout.minimumHeight: 100
                    Layout.fillWidth: false

                    Image {
                        fillMode: Image.PreserveAspectFit
                        source: "images/cancel.png"
                        anchors.fill: parent
                    }

                    onClicked: {
                        stateInfo.text = "Waitting...";
                        previewArea.parent.visible = false;

                        if(photoPreview.sourceFrom == 'camera')
                            cameraUI.visible = true;
                        else
                            galleryUI.visible = true;
                    }
                }
            }

            Rectangle {
                id: viewRect
                width: 200
                height: 200
                color: "#ffffff"
                Layout.fillHeight: true
                Layout.fillWidth: true

                Image {
                    id: preview
                    anchors.fill: parent

                    Layout.fillHeight: true
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillWidth: true

                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    asynchronous: true
                }
            }

            Label {
                id: stateInfo

                text: qsTr("Waitting...")
                renderType: Text.NativeRendering
                font.pointSize: 22
                font.bold: true
                font.family: "Arial"

                Layout.minimumHeight: 20
                Layout.fillWidth: true

                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter

                background: Rectangle{
                    anchors.fill: parent
                    radius: 10
                    border.color: "#000000"
                }
            }

            ProgressBar {
                id: sendProgress

                height: 22
                spacing: 0

                font.pointSize: 22
                font.capitalization: Font.MixedCase

                Layout.minimumHeight: 20
                Layout.fillWidth: true

                indeterminate: false

                to: 1
                value: 0
            }

            RoundButton {
                id: sendBtn
                x: 185
                y: 360
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.minimumWidth: 100
                Layout.minimumHeight: 100
                spacing: -3
                Layout.fillWidth: false

                Image {
                    fillMode: Image.PreserveAspectFit
                    source: "images/send.png"
                    anchors.fill: parent
                }

                onClicked: {
                    sendBtn.enabled = false
                    cancelBtn.enabled = false
                    if(photoPreview.sourceFrom == 'camera')
                        client.start(camera.imageCapture.capturedImagePath);
                    else
                        client.start(source.toLocaleString());
                }
            }
        }
    }

    InfoMenu{
        id: infoMenu
        anchors.fill: parent
        visible: false
    }
}
