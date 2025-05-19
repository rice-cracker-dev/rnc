import QtQuick
import QtQuick.Layouts
import Quickshell
import ".."
import "../widgets"

PanelWindow {
  anchors {
    top: true
    left: true
    right: true
  }

  height: 42

  color: Theme.surface

  Item {
    id: main
    anchors.fill: parent

    RowLayout {
      anchors {
        verticalCenter: main.verticalCenter
        right: main.right
        rightMargin: 8
      }

      spacing: 8

      SystemWidget {}

      ClockWidget {
        Layout.alignment: Qt.AlignVCenter
      }
    }
  }
}
