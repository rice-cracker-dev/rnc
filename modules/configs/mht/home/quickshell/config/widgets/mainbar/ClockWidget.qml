import QtQuick
import Quickshell
import "root:/components"

Column {
  spacing: 8

  SystemClock {
    id: clock
  }

  Text {
    text: Qt.formatTime(clock.date, "HH")
  }

  Text {
    text: Qt.formatTime(clock.date, "mm")
  }
}
