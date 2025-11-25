## Topics
### Symbol effects
`static var appear: AppearSymbolEffect`
An animation that makes the layers of a symbol-based image appear separately or as a whole.
`static var bounce: BounceSymbolEffect`
An animation that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`static var disappear: DisappearSymbolEffect`
An animation that makes the layers of a symbol-based image disappear separately or as a whole.
`static var pulse: PulseSymbolEffect`
An animation that fades the opacity of some or all layers in a symbol-based image.
`static var scale: ScaleSymbolEffect`
An animation that scales the layers in a symbol-based image separately or as a whole.
`static var variableColor: VariableColorSymbolEffect`
An animation that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
### Symbol content transitions
`static var replace: ReplaceSymbolEffect`
An animation that replaces the layers of one symbol-based image with those of another.
`static var automatic: AutomaticSymbolEffect`
A transition that applies the default animation to a symbol-based image in a context-sensitive manner.
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct BreatheSymbolEffect`
`struct RotateSymbolEffect`
`struct WiggleSymbolEffect`
### Symbol effect options
`struct SymbolEffectOptions`
Options that configure how effects apply to symbol-based images.
### Symbol effect protocols
`protocol SymbolEffect`
A presentation effect that you apply to a symbol-based image.
`protocol DiscreteSymbolEffect`
An effect that performs a transient animation.
`protocol IndefiniteSymbolEffect`
An animation that continually affects a symbol until it’s disabled or removed.
`protocol ContentTransitionSymbolEffect`
An effect that animates between symbols or different configurations of the same symbol.
`protocol TransitionSymbolEffect`
An effect that animates a symbol in or out.
### Structures
`struct DrawOffSymbolEffect`
A symbol effect that applies the DrawOff animation to symbol images.
`struct DrawOnSymbolEffect`
A symbol effect that applies the DrawOn animation to symbol images.
---
# https://developer.apple.com/documentation/symbols/symboleffect/appear
- Symbols
- SymbolEffect
- appear
Type Property
# appear
An animation that makes the layers of a symbol-based image appear separately or as a whole.
Mac Catalyst
static var appear: AppearSymbolEffect { get }
Available when `Self` is `AppearSymbolEffect`.
## See Also
### Symbol effects
`static var bounce: BounceSymbolEffect`
An animation that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`static var disappear: DisappearSymbolEffect`
An animation that makes the layers of a symbol-based image disappear separately or as a whole.
`static var pulse: PulseSymbolEffect`
An animation that fades the opacity of some or all layers in a symbol-based image.
`static var scale: ScaleSymbolEffect`
An animation that scales the layers in a symbol-based image separately or as a whole.
`static var variableColor: VariableColorSymbolEffect`
An animation that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
---
# https://developer.apple.com/documentation/symbols/symboleffect/bounce
- Symbols
- SymbolEffect
- bounce
Type Property
# bounce
An animation that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
Mac Catalyst
static var bounce: BounceSymbolEffect { get }
Available when `Self` is `BounceSymbolEffect`.
## See Also
### Symbol effects
`static var appear: AppearSymbolEffect`
An animation that makes the layers of a symbol-based image appear separately or as a whole.
`static var disappear: DisappearSymbolEffect`
An animation that makes the layers of a symbol-based image disappear separately or as a whole.
`static var pulse: PulseSymbolEffect`
An animation that fades the opacity of some or all layers in a symbol-based image.
`static var scale: ScaleSymbolEffect`
An animation that scales the layers in a symbol-based image separately or as a whole.
`static var variableColor: VariableColorSymbolEffect`
An animation that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
---
# https://developer.apple.com/documentation/symbols/symboleffect/disappear
- Symbols
- SymbolEffect
- disappear
Type Property
# disappear
An animation that makes the layers of a symbol-based image disappear separately or as a whole.
Mac Catalyst
static var disappear: DisappearSymbolEffect { get }
Available when `Self` is `DisappearSymbolEffect`.
## See Also
### Symbol effects
`static var appear: AppearSymbolEffect`
An animation that makes the layers of a symbol-based image appear separately or as a whole.
`static var bounce: BounceSymbolEffect`
An animation that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`static var pulse: PulseSymbolEffect`
An animation that fades the opacity of some or all layers in a symbol-based image.
`static var scale: ScaleSymbolEffect`
An animation that scales the layers in a symbol-based image separately or as a whole.
`static var variableColor: VariableColorSymbolEffect`
An animation that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
---
# https://developer.apple.com/documentation/symbols/symboleffect/pulse
- Symbols
- SymbolEffect
- pulse
Type Property
# pulse
An animation that fades the opacity of some or all layers in a symbol-based image.
Mac Catalyst
static var pulse: PulseSymbolEffect { get }
Available when `Self` is `PulseSymbolEffect`.
## See Also
### Symbol effects
`static var appear: AppearSymbolEffect`
An animation that makes the layers of a symbol-based image appear separately or as a whole.
`static var bounce: BounceSymbolEffect`
An animation that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`static var disappear: DisappearSymbolEffect`
An animation that makes the layers of a symbol-based image disappear separately or as a whole.
`static var scale: ScaleSymbolEffect`
An animation that scales the layers in a symbol-based image separately or as a whole.
`static var variableColor: VariableColorSymbolEffect`
An animation that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
---
# https://developer.apple.com/documentation/symbols/symboleffect/scale
- Symbols
- SymbolEffect
- scale
Type Property
# scale
An animation that scales the layers in a symbol-based image separately or as a whole.
Mac Catalyst
static var scale: ScaleSymbolEffect { get }
Available when `Self` is `ScaleSymbolEffect`.
## See Also
### Symbol effects
`static var appear: AppearSymbolEffect`
An animation that makes the layers of a symbol-based image appear separately or as a whole.
`static var bounce: BounceSymbolEffect`
An animation that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`static var disappear: DisappearSymbolEffect`
An animation that makes the layers of a symbol-based image disappear separately or as a whole.
`static var pulse: PulseSymbolEffect`
An animation that fades the opacity of some or all layers in a symbol-based image.
`static var variableColor: VariableColorSymbolEffect`
An animation that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
---
# https://developer.apple.com/documentation/symbols/symboleffect/variablecolor
- Symbols
- SymbolEffect
- variableColor
Type Property
# variableColor
An animation that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
Mac Catalyst
static var variableColor: VariableColorSymbolEffect { get }
Available when `Self` is `VariableColorSymbolEffect`.
## See Also
### Symbol effects
`static var appear: AppearSymbolEffect`
An animation that makes the layers of a symbol-based image appear separately or as a whole.
`static var bounce: BounceSymbolEffect`
An animation that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`static var disappear: DisappearSymbolEffect`
An animation that makes the layers of a symbol-based image disappear separately or as a whole.
`static var pulse: PulseSymbolEffect`
An animation that fades the opacity of some or all layers in a symbol-based image.
`static var scale: ScaleSymbolEffect`
An animation that scales the layers in a symbol-based image separately or as a whole.
---
# https://developer.apple.com/documentation/symbols/symboleffect/replace
- Symbols
- SymbolEffect
- replace
Type Property
# replace
An animation that replaces the layers of one symbol-based image with those of another.
Mac Catalyst
static var replace: ReplaceSymbolEffect { get }
Available when `Self` is `ReplaceSymbolEffect`.
## See Also
### Symbol content transitions
`static var automatic: AutomaticSymbolEffect`
A transition that applies the default animation to a symbol-based image in a context-sensitive manner.
---
# https://developer.apple.com/documentation/symbols/symboleffect/automatic
- Symbols
- SymbolEffect
- automatic
Type Property
# automatic
A transition that applies the default animation to a symbol-based image in a context-sensitive manner.
Mac Catalyst
static var automatic: AutomaticSymbolEffect { get }
Available when `Self` is `AutomaticSymbolEffect`.
## See Also
### Symbol content transitions
`static var replace: ReplaceSymbolEffect`
An animation that replaces the layers of one symbol-based image with those of another.
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect
- Symbols
- AppearSymbolEffect
Structure
# AppearSymbolEffect
A type that makes the layers of a symbol-based image appear separately or as a whole.
Mac Catalyst
struct AppearSymbolEffect
## Overview
An appear transition causes a symbol to become visible using a scaling animation. You can choose to scale the image up or down and to animate the symbol by individual layers or as a whole.
## Topics
### Accessing symbol effects
`var down: AppearSymbolEffect`
An effect that makes the symbol scale down as it appears.
`var up: AppearSymbolEffect`
An effect that makes the symbol scale up as it appears.
### Determining effect scope
`var byLayer: AppearSymbolEffect`
An effect that makes each layer appear separately.
`var wholeSymbol: AppearSymbolEffect`
An effect that makes all layers appear simultaneously.
### Accessing the configuration
`var configuration: SymbolEffectConfiguration`
The configuration for the effect.
## Relationships
### Conforms To
- `Copyable`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
- `TransitionSymbolEffect`
## See Also
### Symbol effect types
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct BreatheSymbolEffect`
`struct RotateSymbolEffect`
`struct WiggleSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/automaticsymboleffect
- Symbols
- AutomaticSymbolEffect
Structure
# AutomaticSymbolEffect
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
Mac Catalyst
struct AutomaticSymbolEffect
## Topics
### Accessing the configuration
`var configuration: SymbolEffectConfiguration`
The configuration for the effect.
## Relationships
### Conforms To
- `ContentTransitionSymbolEffect`
- `Copyable`
- `Equatable`
- `Hashable`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
- `TransitionSymbolEffect`
## See Also
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct BreatheSymbolEffect`
`struct RotateSymbolEffect`
`struct WiggleSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/bouncesymboleffect
- Symbols
- BounceSymbolEffect
Structure
# BounceSymbolEffect
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
Mac Catalyst
struct BounceSymbolEffect
## Overview
A bounce animation draws attention to a symbol by applying a brief scaling operation to the symbol’s layers. You can choose to scale the symbol up or down as it bounces.
// Add an effect in SwiftUI.
@State private var value1 = 0
@State private var value2 = 0
var body: some View {
HStack {
Image(systemName: "arrow.up.circle")
// Bounce with a scale-up animation.
.symbolEffect(.bounce.up, value: value1)
.onTapGesture {
value1 += 1
}
Image(systemName: "arrow.down.circle")
// Bounce three times with a scale-down animation.
.symbolEffect(.bounce.down, options: .repeat(3), value: value2)
.onTapGesture {
value2 += 1
}
}
}
// Add an effect in AppKit and UIKit.
// Bounce with a scale-up animation.
imageView1.addSymbolEffect(.bounce.up)
// Bounce three times with a scale-down animation.
imageView2.addSymbolEffect(.bounce.down, options: .repeat(3))
## Topics
### Accessing symbol effects
`var down: BounceSymbolEffect`
An effect that bounces the symbol downward.
`var up: BounceSymbolEffect`
An effect that bounces the symbol upward.
### Determining effect scope
`var byLayer: BounceSymbolEffect`
An effect that bounces each layer separately.
`var wholeSymbol: BounceSymbolEffect`
An effect that bounces all layers simultaneously.
### Accessing the configuration
`var configuration: SymbolEffectConfiguration`
The configuration for the effect.
## Relationships
### Conforms To
- `Copyable`
- `DiscreteSymbolEffect`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
## See Also
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct BreatheSymbolEffect`
`struct RotateSymbolEffect`
`struct WiggleSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect
- Symbols
- DisappearSymbolEffect
Structure
# DisappearSymbolEffect
A type that makes the layers of a symbol-based image disappear separately or as a whole.
Mac Catalyst
struct DisappearSymbolEffect
## Overview
A disappear transition causes a symbol to become invisible using a scaling animation. You can choose to scale the image up or down and to animate the symbol by individual layers or as a whole.
## Topics
### Accessing symbol effects
`var down: DisappearSymbolEffect`
An effect that scales the symbol down as it disappears.
`var up: DisappearSymbolEffect`
An effect that scales the symbol up as it disappears.
### Determining effect scope
`var byLayer: DisappearSymbolEffect`
An effect that makes each layer disappear separately.
`var wholeSymbol: DisappearSymbolEffect`
An effect that makes all layers disappear simultaneously.
### Accessing the configuration
`var configuration: SymbolEffectConfiguration`
The configuration for the effect.
## Relationships
### Conforms To
- `Copyable`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
- `TransitionSymbolEffect`
## See Also
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct BreatheSymbolEffect`
`struct RotateSymbolEffect`
`struct WiggleSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/pulsesymboleffect
- Symbols
- PulseSymbolEffect
Structure
# PulseSymbolEffect
A type that fades the opacity of some or all layers in a symbol-based image.
Mac Catalyst
struct PulseSymbolEffect
## Overview
A pulse animation applies an opacity ramp to the layers in a symbol. You can choose to animate only layers marked as “always-pulses” or all layers simultaneously. Participating layers reduce their opacity to a minimum value before returning to fully opaque.
// Add an effect in SwiftUI.
@State private var value1 = 0
@State private var value2 = 0
var body: some View {
HStack {
Image(systemName: "person.text.rectangle")
// Pulse only layers marked as "always-pulse."
.symbolEffect(.pulse, value: value1)
.onTapGesture {
value1 += 1
}
Image(systemName: "person.text.rectangle")
// Pulse all layers three times simultaneously.
.symbolEffect(.pulse.wholeSymbol, options: .repeat(3), value: value2)
.onTapGesture {
value2 += 1
}
}
}
// Add an effect in AppKit and UIKit.
// Pulse only layers marked as "always-pulse."
imageView1.addSymbolEffect(.pulse.byLayer, options: .nonRepeating)
// Pulse all layers three times simultaneously.
imageView2.addSymbolEffect(.pulse.wholeSymbol, options: .repeat(3))
## Topics
### Determining effect scope
`var byLayer: PulseSymbolEffect`
An effect requesting an animation that pulses only the layers marked to always pulse.
`var wholeSymbol: PulseSymbolEffect`
An effect requesting an animation that pulses all layers simultaneously.
### Accessing the configuration
`var configuration: SymbolEffectConfiguration`
The configuration for the effect.
## Relationships
### Conforms To
- `Copyable`
- `DiscreteSymbolEffect`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
## See Also
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct BreatheSymbolEffect`
`struct RotateSymbolEffect`
`struct WiggleSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/replacesymboleffect
- Symbols
- ReplaceSymbolEffect
Structure
# ReplaceSymbolEffect
A type that replaces the layers of one symbol-based image with those of another.
Mac Catalyst
struct ReplaceSymbolEffect
## Overview
A replace transition animates the change from one symbol image to another. You choose from one of the predefined scaling animations: Down-Up, Off-Up, and Up-Up.
Down-Up
The initial symbol scales down as it’s removed, and the new symbol scales up as it’s added.
Off-Up
The initial symbol is removed with no animation, and the new symbol scales up as it’s added.
Up-Up
The initial symbol scales up as it’s removed, and the new symbol scales up as it’s added.
## Topics
### Accessing symbol effects
`var downUp: ReplaceSymbolEffect`
An effect that replaces a symbol by scaling it down, and scaling a different symbol up.
`var offUp: ReplaceSymbolEffect`
An effect that replaces a symbol by removing it, and scaling a different symbol up.
`var upUp: ReplaceSymbolEffect`
An effect that replaces a symbol by scaling it up, and scaling a different symbol up.
### Determining effect scope
`var byLayer: ReplaceSymbolEffect`
An effect that replaces each layer separately.
`var wholeSymbol: ReplaceSymbolEffect`
An effect that replaces all layers simultaneously.
### Accessing the configuration
`var configuration: SymbolEffectConfiguration`
The configuration for the effect.
### Structures
`struct MagicReplace`
### Type Properties
`static var downUp: ReplaceSymbolEffect`
`static var offUp: ReplaceSymbolEffect`
`static var upUp: ReplaceSymbolEffect`
## Relationships
### Conforms To
- `ContentTransitionSymbolEffect`
- `Copyable`
- `Equatable`
- `Hashable`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
## See Also
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct BreatheSymbolEffect`
`struct RotateSymbolEffect`
`struct WiggleSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect
- Symbols
- ScaleSymbolEffect
Structure
# ScaleSymbolEffect
A type that scales the layers in a symbol-based image separately or as a whole.
Mac Catalyst
struct ScaleSymbolEffect
## Overview
A scale animation draws attention to a symbol by changing the symbol’s scale indefinitely. You can choose to scale the symbol up or down.
## Topics
### Accessing symbol effects
`var down: ScaleSymbolEffect`
An effect that scales the symbol down.
`var up: ScaleSymbolEffect`
An effect that scales the symbol up.
### Determining effect scope
`var byLayer: ScaleSymbolEffect`
An effect that scales each layer separately.
`var wholeSymbol: ScaleSymbolEffect`
An effect that scales all layers simultaneously.
### Accessing the configuration
`var configuration: SymbolEffectConfiguration`
The configuration for the effect.
## Relationships
### Conforms To
- `Copyable`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
## See Also
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct BreatheSymbolEffect`
`struct RotateSymbolEffect`
`struct WiggleSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/variablecolorsymboleffect
- Symbols
- VariableColorSymbolEffect
Structure
# VariableColorSymbolEffect
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
Mac Catalyst
struct VariableColorSymbolEffect
## Overview
A variable color animation draws attention to a symbol by changing the opacity of the symbol’s layers. You can choose to apply the effect to layers either cumulatively or iteratively. For cumulative animations, each layer’s opacity remains changed until the end of the animation cycle. For iterative animations, each layer’s opacity changes briefly before returning to its original state.
// Add an effect in SwiftUI.
@State private var value1 = 0
@State private var value2 = 0
var body: some View {
HStack {
Image(systemName: "cellularbars")
// Iteratively activates layers.
.symbolEffect(.variableColor.iterative, value: value1)
.onTapGesture {
value1 += 1
}
Image(systemName: "cellularbars")
// Cumulatively activates layers reversing and repeating three times.
.symbolEffect(.variableColor.hideInactiveLayers.reversing, options: .repeat(3), value: value2)
.onTapGesture {
value2 += 1
}
}
}
// Add an effect in AppKit and UIKit.
// Iteratively activates layers.
imageView1.addSymbolEffect(.variableColor.iterative, options: .nonRepeating)
// Cumulatively activates layers reversing and repeating three times.
imageView2.addSymbolEffect(.variableColor.hideInactiveLayers.cumulative, options: .repeat(3))
## Topics
### Controlling fill style
`var cumulative: VariableColorSymbolEffect`
An effect that enables each layer of a symbol-based image in sequence.
`var iterative: VariableColorSymbolEffect`
An effect that momentarily enables each layer of a symbol-based image in sequence.
### Changing playback style
`var nonReversing: VariableColorSymbolEffect`
An effect that doesn’t reverse each time it repeats.
`var reversing: VariableColorSymbolEffect`
An effect that reverses each time it repeats.
### Affecting inactive layers
`var dimInactiveLayers: VariableColorSymbolEffect`
An effect that dims inactive layers in a symbol-based image.
`var hideInactiveLayers: VariableColorSymbolEffect`
An effect that hides inactive layers in a symbol-based image.
### Accessing the configuration
`var configuration: SymbolEffectConfiguration`
The configuration for the effect.
## Relationships
### Conforms To
- `Copyable`
- `DiscreteSymbolEffect`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
## See Also
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct BreatheSymbolEffect`
`struct RotateSymbolEffect`
`struct WiggleSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect
- Symbols
- BreatheSymbolEffect
Structure
# BreatheSymbolEffect
Mac Catalyst
struct BreatheSymbolEffect
## Topics
### Instance Properties
`var byLayer: BreatheSymbolEffect`
`var configuration: SymbolEffectConfiguration`
`var plain: BreatheSymbolEffect`
`var pulse: BreatheSymbolEffect`
`var wholeSymbol: BreatheSymbolEffect`
## Relationships
### Conforms To
- `Copyable`
- `DiscreteSymbolEffect`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
## See Also
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct RotateSymbolEffect`
`struct WiggleSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect
- Symbols
- RotateSymbolEffect
Structure
# RotateSymbolEffect
Mac Catalyst
struct RotateSymbolEffect
## Topics
### Instance Properties
`var byLayer: RotateSymbolEffect`
`var clockwise: RotateSymbolEffect`
`var configuration: SymbolEffectConfiguration`
`var counterClockwise: RotateSymbolEffect`
`var wholeSymbol: RotateSymbolEffect`
## Relationships
### Conforms To
- `Copyable`
- `DiscreteSymbolEffect`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
## See Also
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct BreatheSymbolEffect`
`struct WiggleSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect
- Symbols
- WiggleSymbolEffect
Structure
# WiggleSymbolEffect
Mac Catalyst
struct WiggleSymbolEffect
## Topics
### Instance Properties
`var backward: WiggleSymbolEffect`
`var byLayer: WiggleSymbolEffect`
`var clockwise: WiggleSymbolEffect`
`var configuration: SymbolEffectConfiguration`
`var counterClockwise: WiggleSymbolEffect`
`var down: WiggleSymbolEffect`
`var forward: WiggleSymbolEffect`
`var left: WiggleSymbolEffect`
`var right: WiggleSymbolEffect`
`var up: WiggleSymbolEffect`
`var wholeSymbol: WiggleSymbolEffect`
## Relationships
### Conforms To
- `Copyable`
- `DiscreteSymbolEffect`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
## See Also
### Symbol effect types
`struct AppearSymbolEffect`
A type that makes the layers of a symbol-based image appear separately or as a whole.
`struct AutomaticSymbolEffect`
A type that applies the default animation to a symbol-based image in a context-sensitive manner.
`struct BounceSymbolEffect`
A type that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`struct DisappearSymbolEffect`
A type that makes the layers of a symbol-based image disappear separately or as a whole.
`struct PulseSymbolEffect`
A type that fades the opacity of some or all layers in a symbol-based image.
`struct ReplaceSymbolEffect`
A type that replaces the layers of one symbol-based image with those of another.
`struct ScaleSymbolEffect`
A type that scales the layers in a symbol-based image separately or as a whole.
`struct VariableColorSymbolEffect`
A type that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`struct BreatheSymbolEffect`
`struct RotateSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions
- Symbols
- SymbolEffectOptions
Structure
# SymbolEffectOptions
Options that configure how effects apply to symbol-based images.
Mac Catalyst
struct SymbolEffectOptions
## Topics
### Accessing effect options
``static var `default`: SymbolEffectOptions``
The default set of effect options.
### Configuring repeating effects
`var repeating: SymbolEffectOptions`
A set of effect options that prefers to repeat indefinitely.
`static var repeating: SymbolEffectOptions`
A default set of effect options that prefers to repeat indefinitely.
`var nonRepeating: SymbolEffectOptions`
A set of effect options that prefers to not repeat.
`static var nonRepeating: SymbolEffectOptions`
A default set of effect options that prefers to not repeat.
Creates a set of effect options with a preferred repeat count.
A default set of effect options with a preferred repeat count.
### Configuring effect speed
Creates a set of effect options with a preferred speed multiplier.
A default set of effect options with a preferred speed multiplier.
### Structures
`struct RepeatBehavior`
## Relationships
### Conforms To
- `Equatable`
- `Hashable`
- `Sendable`
- `SendableMetatype`
---
# https://developer.apple.com/documentation/symbols/symboleffect
- Symbols
- SymbolEffect
Protocol
# SymbolEffect
A presentation effect that you apply to a symbol-based image.
Mac Catalyst
protocol SymbolEffect : Hashable, Sendable
## Topics
### Effects
`static var appear: AppearSymbolEffect`
An animation that makes the layers of a symbol-based image appear separately or as a whole.
`static var bounce: BounceSymbolEffect`
An animation that applies a transitory scaling effect, or bounce, to the layers in a symbol-based image separately or as a whole.
`static var disappear: DisappearSymbolEffect`
An animation that makes the layers of a symbol-based image disappear separately or as a whole.
`static var pulse: PulseSymbolEffect`
An animation that fades the opacity of some or all layers in a symbol-based image.
`static var scale: ScaleSymbolEffect`
An animation that scales the layers in a symbol-based image separately or as a whole.
`static var variableColor: VariableColorSymbolEffect`
An animation that replaces the opacity of variable layers in a symbol-based image in a repeatable sequence.
`static var breathe: BreatheSymbolEffect`
`static var rotate: RotateSymbolEffect`
`static var wiggle: WiggleSymbolEffect`
### Accessing the configuration
`var configuration: SymbolEffectConfiguration`
A configuration for a symbol effect.
**Required**
`struct SymbolEffectConfiguration`
A type that specifies the configuration of a symbol effect.
### Type Properties
`static var automatic: AutomaticSymbolEffect`
A transition that applies the default animation to a symbol-based image in a context-sensitive manner.
`static var drawOff: DrawOffSymbolEffect`
A symbol effect that applies the DrawOff animation to symbol images.
`static var drawOn: DrawOnSymbolEffect`
A symbol effect that applies the DrawOn animation to symbol images.
`static var replace: ReplaceSymbolEffect`
An animation that replaces the layers of one symbol-based image with those of another.
## Relationships
### Inherits From
- `Equatable`
- `Hashable`
- `Sendable`
- `SendableMetatype`
### Conforming Types
- `AppearSymbolEffect`
- `AutomaticSymbolEffect`
- `BounceSymbolEffect`
- `BreatheSymbolEffect`
- `DisappearSymbolEffect`
- `DrawOffSymbolEffect`
- `DrawOnSymbolEffect`
- `PulseSymbolEffect`
- `ReplaceSymbolEffect`
- `ReplaceSymbolEffect.MagicReplace`
- `RotateSymbolEffect`
- `ScaleSymbolEffect`
- `VariableColorSymbolEffect`
- `WiggleSymbolEffect`
## See Also
### Symbol effect protocols
`protocol DiscreteSymbolEffect`
An effect that performs a transient animation.
`protocol IndefiniteSymbolEffect`
An animation that continually affects a symbol until it’s disabled or removed.
`protocol ContentTransitionSymbolEffect`
An effect that animates between symbols or different configurations of the same symbol.
`protocol TransitionSymbolEffect`
An effect that animates a symbol in or out.
---
# https://developer.apple.com/documentation/symbols/discretesymboleffect
- Symbols
- DiscreteSymbolEffect
Protocol
# DiscreteSymbolEffect
An effect that performs a transient animation.
Mac Catalyst
protocol DiscreteSymbolEffect
## Relationships
### Conforming Types
- `BounceSymbolEffect`
- `BreatheSymbolEffect`
- `PulseSymbolEffect`
- `RotateSymbolEffect`
- `VariableColorSymbolEffect`
- `WiggleSymbolEffect`
## See Also
### Symbol effect protocols
`protocol SymbolEffect`
A presentation effect that you apply to a symbol-based image.
`protocol IndefiniteSymbolEffect`
An animation that continually affects a symbol until it’s disabled or removed.
`protocol ContentTransitionSymbolEffect`
An effect that animates between symbols or different configurations of the same symbol.
`protocol TransitionSymbolEffect`
An effect that animates a symbol in or out.
---
# https://developer.apple.com/documentation/symbols/indefinitesymboleffect
- Symbols
- IndefiniteSymbolEffect
Protocol
# IndefiniteSymbolEffect
An animation that continually affects a symbol until it’s disabled or removed.
Mac Catalyst
protocol IndefiniteSymbolEffect
## Relationships
### Conforming Types
- `AppearSymbolEffect`
- `BounceSymbolEffect`
- `BreatheSymbolEffect`
- `DisappearSymbolEffect`
- `DrawOffSymbolEffect`
- `DrawOnSymbolEffect`
- `PulseSymbolEffect`
- `RotateSymbolEffect`
- `ScaleSymbolEffect`
- `VariableColorSymbolEffect`
- `WiggleSymbolEffect`
## See Also
### Symbol effect protocols
`protocol SymbolEffect`
A presentation effect that you apply to a symbol-based image.
`protocol DiscreteSymbolEffect`
An effect that performs a transient animation.
`protocol ContentTransitionSymbolEffect`
An effect that animates between symbols or different configurations of the same symbol.
`protocol TransitionSymbolEffect`
An effect that animates a symbol in or out.
---
# https://developer.apple.com/documentation/symbols/contenttransitionsymboleffect
- Symbols
- ContentTransitionSymbolEffect
Protocol
# ContentTransitionSymbolEffect
An effect that animates between symbols or different configurations of the same symbol.
Mac Catalyst
protocol ContentTransitionSymbolEffect
## Relationships
### Conforming Types
- `AutomaticSymbolEffect`
- `ReplaceSymbolEffect`
- `ReplaceSymbolEffect.MagicReplace`
## See Also
### Symbol effect protocols
`protocol SymbolEffect`
A presentation effect that you apply to a symbol-based image.
`protocol DiscreteSymbolEffect`
An effect that performs a transient animation.
`protocol IndefiniteSymbolEffect`
An animation that continually affects a symbol until it’s disabled or removed.
`protocol TransitionSymbolEffect`
An effect that animates a symbol in or out.
---
# https://developer.apple.com/documentation/symbols/transitionsymboleffect
- Symbols
- TransitionSymbolEffect
Protocol
# TransitionSymbolEffect
An effect that animates a symbol in or out.
Mac Catalyst
protocol TransitionSymbolEffect
## Relationships
### Conforming Types
- `AppearSymbolEffect`
- `AutomaticSymbolEffect`
- `DisappearSymbolEffect`
- `DrawOffSymbolEffect`
- `DrawOnSymbolEffect`
## See Also
### Symbol effect protocols
`protocol SymbolEffect`
A presentation effect that you apply to a symbol-based image.
`protocol DiscreteSymbolEffect`
An effect that performs a transient animation.
`protocol IndefiniteSymbolEffect`
An animation that continually affects a symbol until it’s disabled or removed.
`protocol ContentTransitionSymbolEffect`
An effect that animates between symbols or different configurations of the same symbol.
---
# https://developer.apple.com/documentation/symbols/drawoffsymboleffect
- Symbols
- DrawOffSymbolEffect
Structure
# DrawOffSymbolEffect
A symbol effect that applies the DrawOff animation to symbol images.
Mac Catalyst
struct DrawOffSymbolEffect
## Overview
The DrawOff animation makes the symbol hidden either as a whole, or one motion group at a time, animating parts of the symbol with draw data.
## Topics
### Instance Properties
`var byLayer: DrawOffSymbolEffect`
Returns a copy of the effect requesting an animation that applies separately to each motion group.
`var configuration: SymbolEffectConfiguration`
The configuration for the effect.
`var individually: DrawOffSymbolEffect`
Returns a copy of the effect requesting an animation that applies separately to each motion group, where only one motion group is active at a time.
`var nonReversed: DrawOffSymbolEffect`
Returns a copy of the effect requesting an animation that draws off following the draw metadata forwards.
`var reversed: DrawOffSymbolEffect`
Returns a copy of the effect requesting an animation that draws off following the draw metadata in reverse.
`var wholeSymbol: DrawOffSymbolEffect`
Returns a copy of the effect requesting an animation that applies to all motion groups simultaneously.
## Relationships
### Conforms To
- `Copyable`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
- `TransitionSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/drawonsymboleffect
- Symbols
- DrawOnSymbolEffect
Structure
# DrawOnSymbolEffect
A symbol effect that applies the DrawOn animation to symbol images.
Mac Catalyst
struct DrawOnSymbolEffect
## Overview
The DrawOn animation makes the symbol visible either as a whole, or one motion group at a time, animating parts of the symbol with draw data.
## Topics
### Instance Properties
`var byLayer: DrawOnSymbolEffect`
Returns a copy of the effect requesting an animation that applies separately to each motion group.
`var configuration: SymbolEffectConfiguration`
The configuration for the effect.
`var individually: DrawOnSymbolEffect`
Returns a copy of the effect requesting an animation that applies separately to each motion group, where only one motion group is active at a time.
`var wholeSymbol: DrawOnSymbolEffect`
Returns a copy of the effect requesting an animation that applies to all motion groups simultaneously.
## Relationships
### Conforms To
- `Copyable`
- `Equatable`
- `Hashable`
- `IndefiniteSymbolEffect`
- `Sendable`
- `SendableMetatype`
- `SymbolEffect`
- `TransitionSymbolEffect`
---
# https://developer.apple.com/documentation/symbols/symboleffect/appear)
---
# https://developer.apple.com/documentation/symbols/symboleffect/bounce)
---
# https://developer.apple.com/documentation/symbols/symboleffect/disappear)
---
# https://developer.apple.com/documentation/symbols/symboleffect/pulse)
---
# https://developer.apple.com/documentation/symbols/symboleffect/scale)
---
# https://developer.apple.com/documentation/symbols/symboleffect/variablecolor)
---
# https://developer.apple.com/documentation/symbols/symboleffect/replace)
---
# https://developer.apple.com/documentation/symbols/symboleffect/automatic)
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect)
---
# https://developer.apple.com/documentation/symbols/automaticsymboleffect)
---
# https://developer.apple.com/documentation/symbols/bouncesymboleffect)
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect)
---
# https://developer.apple.com/documentation/symbols/pulsesymboleffect)
---
# https://developer.apple.com/documentation/symbols/replacesymboleffect)
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect)
---
# https://developer.apple.com/documentation/symbols/variablecolorsymboleffect)
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect)
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect)
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions)
---
# https://developer.apple.com/documentation/symbols/symboleffect)
---
# https://developer.apple.com/documentation/symbols/discretesymboleffect)
---
# https://developer.apple.com/documentation/symbols/indefinitesymboleffect)
---
# https://developer.apple.com/documentation/symbols/contenttransitionsymboleffect)
---
# https://developer.apple.com/documentation/symbols/transitionsymboleffect)
---
# https://developer.apple.com/documentation/symbols/drawoffsymboleffect)
---
# https://developer.apple.com/documentation/symbols/drawonsymboleffect)
---
# https://developer.apple.com/documentation/symbols
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
