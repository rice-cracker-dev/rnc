import Quickshell // for PanelWindow
import QtQuick // for Text
import qs.singletons
import qs.widgets as Widgets
import qs.widgets.components as Components

PanelWindow {
  anchors {
    bottom: true
    left: true
    right: true
  }

  color: Colors.opacity(Colors.background, 0.75)

  implicitHeight: 36

  Item {
    id: main
    anchors.fill: parent

    Row {
      spacing: 8

      anchors {
        left: main.left
        leftMargin: 8
        verticalCenter: main.verticalCenter
      }

      Components.HyprlandWorkspaces {}
    }
  }
}
