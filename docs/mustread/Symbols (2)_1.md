<!--
Downloaded via https://llm.codes by @steipete on November 21, 2025 at 07:38 PM
Source URL: https://developer.apple.com/documentation/Symbols
Total pages processed: 172
URLs filtered: Yes
Content de-duplicated: Yes
Availability strings filtered: Yes
Code blocks only: No
-->
# https://developer.apple.com/documentation/Symbols
Framework
# Symbols
Apply universal animations to symbol-based images.
## Overview
The Symbols framework provides access to symbol effects you can use to animate SF Symbols in your AppKit, UIKit, and SwiftUI apps. These animations exhibit different behaviors:
Discrete
An effect that runs from start to finish.
Indefinite
An effect that lasts until you remove or disable it.
Transition
An effect that animates a symbol in or out of visibility.
Content Transition
An effect that replaces one symbol with another symbol, or with a different configuration of itself.
A symbol effect can exhibit multiple types of behavior. For instance, you can add a pulse effect with an option to occur a finite number of times — a discrete behavior. You can also add a pulse effect with an option to loop forever — an indefinite behavior.
// Add an effect in SwiftUI.
Image(systemName: "globe")
// Add effect with discrete behavior to image view.
.symbolEffect(.pulse, options: .repeat(3))
Image(systemName: "globe")
// Add effect with indefinite behavior to image view.
.symbolEffect(.pulse)
You can apply universal animation effects to symbol-based images that you display in image views. The Symbols framework provides a consistent set of effects to use regardless of your UI framework or langauge choices.
Consider a SwiftUI app that displays a variable color effect on a Wi-Fi symbol while the system searches for Wi-Fi networks.
// Add an effect in SwiftUI.
Image(systemName: "wifi")
.symbolEffect(.variableColor.reversing)
Now consider an AppKit or UIKit version of the app. You can apply the same effect to animate the search for Wi-Fi networks.
// Add an effect in AppKit and UIKit.
imageView.addSymbolEffect(.variableColor.reversing)
// Add an effect in AppKit and UIKit.
[self.imageView\
addSymbolEffect:[[NSSymbolVariableColorEffect effect] effectWithReversing]];
