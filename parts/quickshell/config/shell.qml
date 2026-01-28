import Quickshell // for PanelWindow
import QtQuick // for Text
import qs.singletons
import qs.widgets as Widgets
import qs.widgets.components as Components

PanelWindow {
  id: window

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

      Components.HyprlandWorkspaces {
        id: workspaces
      }
    }

    Row {
      anchors {
        right: main.right
        verticalCenter: main.verticalCenter
        rightMargin: 8
      }

      Widgets.Label {
        id: testLabel
        text: "Test"
      }
    }
  }

  PopupWindow {
    id: popup

    anchor {
      window: window

      onAnchoring: {
        const pos = main.mapFromItem(workspaces, 0, 0);
        anchor.rect.x = pos.x;
        anchor.rect.width = workspaces.width;
        anchor.rect.height = workspaces.height;
      }
    }

    implicitWidth: 200
    implicitHeight: 200
    color: Qt.rgba(255, 0, 0, 0.1)
    visible: true
  }
}
