import QtQuick
import Quickshell.Hyprland
import qs.widgets

MouseArea {
  implicitWidth: childrenRect.width
  implicitHeight: childrenRect.height
  scrollGestureEnabled: true

  onWheel: e => {
    if (Hyprland.focusedWorkspace?.id >= 9 || Hyprland.focusedWorkspace?.id <= 1)
      return;

    const sign = e.angleDelta.y > 0 ? "+1" : "-1";
    Hyprland.dispatch(`workspace ${sign}`);
  }

  Row {
    spacing: 8

    Repeater {
      model: 9

      VariantButton {
        id: button
        required property int modelData
        readonly property HyprlandWorkspace workspace: Hyprland.workspaces.values.find(w => w.id === modelData + 1) ?? null
        readonly property bool isFocused: workspace?.id === Hyprland.focusedWorkspace?.id

        width: button.isFocused ? 24 : 12
        height: 12
        cornerRadius: 9999
        variant: button.isFocused ? VariantButton.ButtonVariant.Default : VariantButton.ButtonVariant.Neutral

        onClicked: Hyprland.dispatch(`workspace ${modelData + 1}`)
      }
    }
  }
}
