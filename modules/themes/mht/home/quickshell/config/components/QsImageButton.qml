import QtQuick 6.8

QsBaseButton {
  required property string source
  property int imageWidth
  property int imageHeight

  id: control

  contentItem: Image {
    source: control.source

    sourceSize.width: control.imageWidth
    sourceSize.height: control.imageHeight
  }
}
