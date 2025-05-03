import QtQuick
import Quickshell
import "../config"
import "../component"

Item {
  id: clockComponent

  implicitWidth: childrenRect.width
  implicitHeight: childrenRect.height

  SystemClock {
    id: clock
  }

  QsIcon {
    id: clockIcon
    source: Qt.resolvedUrl("../assets/clock-symbolic.svg")
    color: clockText.color
    size: clockText.font.pixelSize

    anchors.verticalCenter: parent.verticalCenter
  }

  QsLabel {
    id: clockText
    text: Qt.formatDateTime(clock.date, "hh:mm")
    color: Colorscheme.getColor("on_background")
    font.bold: true

    anchors {
      left: clockIcon.right
      leftMargin: 8
      verticalCenter: parent.verticalCenter
    }
  }
}
