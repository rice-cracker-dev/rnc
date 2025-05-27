import QtQuick

BorderImage {
  property int borderSize: 6

  source: Qt.resolvedUrl("../../assets/tiles/frame_x2.png")
  smooth: false

  border {
    top: borderSize
    bottom: borderSize
    left: borderSize
    right: borderSize
  }
}
