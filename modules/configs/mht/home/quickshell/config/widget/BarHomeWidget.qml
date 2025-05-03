import Quickshell
import QtQuick
import "../component"

QsIconButton {
  id: root

  variant: "surface"
  square: true
  radius: 9999

  icon {
    source: Qt.resolvedUrl("../assets/nixos-symbolic.svg")
  }
}
