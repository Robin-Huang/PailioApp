import QtQuick 2.8
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.9

Item{
    width: 400
    height: 600

    Rectangle {
        id : cameraUI

        color: "black"
        anchors.fill: parent
        state: "PhotoCapture"

        states: [
            State {
                name: "PhotoCapture"
                StateChangeScript {
                    script: {
                        camera.captureMode = Camera.CaptureStillImage
                        camera.start()
                    }
                }
            },
            State {
                name: "PhotoPreview"
            }
        ]

        GridLayout {
            id: gridLayout1
            anchors.rightMargin: 10
            anchors.leftMargin: 10
            anchors.bottomMargin: 10
            anchors.topMargin: 10
            rows: 2
            columns: 1
            anchors.fill: parent

            VideoOutput {
                id: viewfinder
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                visible: cameraUI.state == "PhotoCapture"
                source: camera
                autoOrientation: true
            }

            RoundButton {
                id: captureBtn
                Layout.minimumHeight: 100
                Layout.minimumWidth: 100
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: false
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 10
                visible: true

                Image {
                    fillMode: Image.PreserveAspectFit
                    source: "images/capture.png"
                    anchors.fill: parent
                }

                onClicked: {
                    camera.imageCapture.capture();
                }
            }
        }

        Camera {
            id: camera
            captureMode: Camera.CaptureStillImage
            imageCapture {
                onImageCaptured: {
                    photoPreview.source = preview
                    photoPreview.visible = true
                    cameraUI.visible     = false
                }
            }
        }
    }

    PhotoPreview {
        id : photoPreview

        anchors.rightMargin: 0
        anchors.bottomMargin: 0
        anchors.leftMargin: 0
        anchors.topMargin: 0
        anchors.fill: parent

        visible: false
        focus: visible
    }
}
