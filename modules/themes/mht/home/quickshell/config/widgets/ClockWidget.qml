import QtQuick.Layouts 6.8
import Quickshell
import "../components"

RowLayout {
  spacing: 8

  SystemClock {
    id: clock
    precision: SystemClock.Seconds
  }

  RowLayout {
    QsIcon { Layout.alignment: Qt.AlignVCenter; code: 0xe8b5 }
    QsLabel { Layout.alignment: Qt.AlignVCenter; text: Qt.formatTime(clock.date, "hh:mm") }
  }
}
