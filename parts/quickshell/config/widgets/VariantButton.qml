import QtQuick
import QtQuick.Controls
import qs.singletons

Button {
  id: button

  enum ButtonVariant {
    Default,
    Neutral
  }

  enum ButtonSize {
    Default,
    Small,
    Icon,
    IconSmall
  }

  property int variant: VariantButton.ButtonVariant.Default
  property int size: VariantButton.ButtonSize.Default
  property color backgroundColor: Colors.primary
  property color foregroundColor: Colors.primaryForeground
  property double cornerRadius: 4

  readonly property color hoveredBackgroundColor: Colors.opacity(button.backgroundColor, 0.9)

  hoverEnabled: true
  leftPadding: 8
  rightPadding: 8
  topPadding: 4
  bottomPadding: 4

  background: Rectangle {
    id: rect
    color: button.backgroundColor
    radius: button.cornerRadius
  }

  states: [
    State {
      when: button.hovered
      PropertyChanges {
        rect.color: button.hoveredBackgroundColor
      }
    },
    State {
      when: button.variant === VariantButton.ButtonVariant.Neutral
      PropertyChanges {
        button.backgroundColor: Colors.neutral
        button.foregroundColor: Colors.neutralForeground
      }
    },
    State {
      when: button.size === VariantButton.ButtonSize.Small
      PropertyChanges {
        button.leftPadding: 4
        button.rightPadding: 4
        button.topPadding: 2
        button.bottomPadding: 2
      }
    },
    State {
      when: button.size === VariantButton.ButtonSize.Icon
      PropertyChanges {
        button.leftPadding: 4
        button.rightPadding: 4
        button.topPadding: 4
        button.bottomPadding: 4
      }
    },
    State {
      when: button.size === VariantButton.ButtonSize.IconSmall
      PropertyChanges {
        button.leftPadding: 2
        button.rightPadding: 2
        button.topPadding: 2
        button.bottomPadding: 2
      }
    }
  ]
}
