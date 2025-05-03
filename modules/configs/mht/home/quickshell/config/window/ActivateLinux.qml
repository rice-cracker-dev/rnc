import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../component"

PanelWindow {
  anchors {
    right: true
    bottom: true
  }

  margins {
    right: 200
    bottom: 150
  }

  WlrLayershell.layer: WlrLayer.Overlay
  exclusionMode: ExclusionMode.Ignore

  color: "transparent"

  height: content.height
  width: content.width
  mask: Region {}

  ColumnLayout {
    id: content

    spacing: 0

    QsLabel {
      Layout.fillHeight: true
      text: "Activate NixOS"
      font.pixelSize: 16
      opacity: 0.75
    }
    QsLabel {
      Layout.fillHeight: true
      text: "This copy of NixOS is not activated"
      font.pixelSize: 16
      opacity: 0.5
    }
  }
}
