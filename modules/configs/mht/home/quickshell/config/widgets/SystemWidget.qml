import Quickshell
import QtQuick
import QtQuick.Layouts
import ".."
import "../components"

Button {
  id: main
  backgroundColor: Theme.surface
  color: Theme.on_surface

  padding: 8

  states: [
    State {
      when: main.pressed
      PropertyChanges {
        main.backgroundColor: Qt.lighter(Theme.surface_variant)
      }
    },
    State {
      when: main.hovered
      PropertyChanges {
        main.backgroundColor: Theme.surface_variant
      }
    }
  ]

  contentItem: RowLayout {
    spacing: 8
  }
}
