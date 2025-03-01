pragma Singleton

import QtQuick 6.8
import Quickshell

Singleton {
  function opacify(color: color, opacity: real): color {
    return Qt.hsla(color.hslHue, color.hslSaturation, color.hslLightness, opacity)
  }
}

