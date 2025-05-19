import QtQuick
import Quickshell
import "../components"
import ".."

Item {
  implicitWidth: childrenRect.width
  implicitHeight: childrenRect.height

  SystemClock {
    id: clock
  }

  Item {
    id: content

    implicitWidth: childrenRect.width
    implicitHeight: childrenRect.height

    Text {
      id: timeText
      anchors.right: content.right
      text: Qt.formatDateTime(clock.date, 'hh:mm')
      color: Theme.on_surface
      font {
        pixelSize: 12
        bold: true
      }
    }

    Text {
      anchors {
        top: timeText.bottom
        right: content.right
      }
      text: Qt.formatDate(clock.date, "dd/MM/yy")
      font.pixelSize: 10
      color: Theme.on_surface_variant
    }
  }

  Icon {
    anchors {
      verticalCenter: content.verticalCenter
      left: content.right
      leftMargin: 8
    }

    icon: Qt.resolvedUrl("../assets/clock-symbolic.svg")
    size: 16
    color: Theme.on_surface
  }
}
