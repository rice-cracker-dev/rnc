import Quickshell
import QtQuick
import QtQuick.Layouts
import "../config"
import "../widget"

PanelWindow {
  id: root

  anchors {
    top: true
    left: true
    right: true
  }

  color: Colorscheme.getColor("background")

  height: 36

  SystemClock {
    id: clock
  }

  Item {
    anchors.fill: parent

    RowLayout {
      anchors.left: parent.left
      anchors.leftMargin: 8
      implicitHeight: parent.height
    }

    BarClockWidget {
      anchors.horizontalCenter: parent.horizontalCenter
      implicitHeight: parent.height
    }

    RowLayout {
      anchors.right: parent.right
      anchors.rightMargin: 8
      implicitHeight: parent.height
    }
  }
}
