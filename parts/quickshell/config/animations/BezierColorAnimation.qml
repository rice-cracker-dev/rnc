import QtQuick
import qs.singletons

ColorAnimation {
  duration: Theme.easingDuration
  easing.type: Easing.BezierSpline
  easing.bezierCurve: Theme.easingCurve
}
