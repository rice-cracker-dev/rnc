import QtQuick
import qs.singletons

NumberAnimation {
  duration: Theme.easingDuration
  easing.type: Easing.BezierSpline
  easing.bezierCurve: Theme.easingCurve
}
