//@ pragma UseQApplication
//@ pragma Env QT_QUICK_CONTROLS_STYLE=Basic

import Quickshell
import QtQuick
import "./widgets"
import "./widgets/mainbar" as Mainbar
import "./widgets/launcher" as Launcher

ShellRoot {
  Wallpaper {}
  Mainbar.Component {}
  Launcher.Component {}
}
