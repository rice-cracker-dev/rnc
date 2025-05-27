import QtQuick
import QtQuick.Effects

Item {
  id: main
  required property url source
  property url borderSource
  property int borderSize: 6
  property double colorization: 1
  property color color: "#ffffff"
  property color borderColor: "#ffffff"

  BorderImage {
    id: image

    source: main.source
    smooth: false

    anchors.fill: parent

    border {
      top: main.borderSize
      bottom: main.borderSize
      left: main.borderSize
      right: main.borderSize
    }

    visible: false
  }

  BorderImage {
    id: border

    source: main.borderSource
    smooth: false

    anchors.fill: parent

    border {
      top: main.borderSize
      bottom: main.borderSize
      left: main.borderSize
      right: main.borderSize
    }

    visible: false
  }

  MultiEffect {
    source: image
    anchors.fill: image

    colorization: main.colorization
    colorizationColor: main.color
    visible: main.colorization
  }

  MultiEffect {
    source: border
    anchors.fill: border

    colorization: main.colorization
    colorizationColor: main.borderColor
    visible: !!main.borderSource && main.colorization
  }
}
