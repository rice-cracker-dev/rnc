pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
  FileView {
    id: colorJsonFile
    path: Qt.resolvedUrl("./color.json")
    blockLoading: true
  }

  readonly property var colorJson: JSON.parse(colorJsonFile.text())
  property string scheme: 'dark'

  function getColor(name: string): color {
    return Qt.color(colorJson.colors[scheme][name]);
  }
}
