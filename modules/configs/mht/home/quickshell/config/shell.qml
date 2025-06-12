//@ pragma UseQApplication
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import Quickshell
import QtQuick
import "./widgets"
import "./widgets/launcher" as Launcher

ShellRoot {
  Wallpaper {}
  Launcher.Component {}
}
