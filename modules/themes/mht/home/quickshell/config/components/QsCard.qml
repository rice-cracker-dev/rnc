import QtQuick 6.8
import QtQuick.Controls 6.8
import ".."

Frame {
  property var backgroundColor: Style.base100
  property var borderRadius: Style.baseRadius

  id: main

  leftPadding: 8
  rightPadding: 8
  topPadding: 0
  bottomPadding: 0

  background: Rectangle {
    id: backgroundRect
    color: main.backgroundColor
    radius: main.borderRadius
  }

  transitions: Transition {
    ColorAnimation { properties: "backgroundColor"; easing.type: Easing.InOutQuad }
  }
}
