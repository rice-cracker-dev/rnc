import Quickshell
import Quickshell.Widgets
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "../config"
import "../component"

PanelWindow {
  width: main.width
  height: main.height

  anchors {
    top: true
    right: true
  }

  margins {
    top: 8
  }

  ColumnLayout {
    id: main

    spacing: 8
    implicitWidth: 300

    Frame {
      padding: 8

      implicitWidth: parent.width

      background: Rectangle {
        color: Colorscheme.getColor("surface")
      }

      contentItem: RowLayout {

        Image {
          id: contentImage

          source: Qt.resolvedUrl("../assets/headphones-symbolic.svg")

          sourceSize {
            width: 32
            height: 32
          }
        }

        ColumnLayout {
          id: content

          Text {
            Layout.alignment: Qt.AlignLeft
            text: "lol"
          }
        }
      }
    }
  }
}
