import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.singletons
import qs.widgets as Widgets

Row {
  spacing: 4

  Repeater {
    model: Hyprland.workspaces

    Widgets.VariantButton {
      id: button
      required property HyprlandWorkspace modelData

      contentItem: Widgets.Label {
        text: button.modelData.toplevels.values[0].title
        color: button.foregroundColor
      }
    }
  }
}
