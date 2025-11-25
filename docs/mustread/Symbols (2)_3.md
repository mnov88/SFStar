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
# https://developer.apple.com/documentation/symbols/appearsymboleffect/down
- Symbols
- AppearSymbolEffect
- down
Instance Property
# down
An effect that makes the symbol scale down as it appears.
Mac Catalyst
var down: AppearSymbolEffect { get }
## See Also
### Accessing symbol effects
`var up: AppearSymbolEffect`
An effect that makes the symbol scale up as it appears.
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect/up
- Symbols
- AppearSymbolEffect
- up
Instance Property
# up
An effect that makes the symbol scale up as it appears.
Mac Catalyst
var up: AppearSymbolEffect { get }
## See Also
### Accessing symbol effects
`var down: AppearSymbolEffect`
An effect that makes the symbol scale down as it appears.
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect/bylayer
- Symbols
- AppearSymbolEffect
- byLayer
Instance Property
# byLayer
An effect that makes each layer appear separately.
Mac Catalyst
var byLayer: AppearSymbolEffect { get }
## See Also
### Determining effect scope
`var wholeSymbol: AppearSymbolEffect`
An effect that makes all layers appear simultaneously.
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect/wholesymbol
- Symbols
- AppearSymbolEffect
- wholeSymbol
Instance Property
# wholeSymbol
An effect that makes all layers appear simultaneously.
Mac Catalyst
var wholeSymbol: AppearSymbolEffect { get }
## See Also
### Determining effect scope
`var byLayer: AppearSymbolEffect`
An effect that makes each layer appear separately.
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect/configuration
- Symbols
- AppearSymbolEffect
- configuration
Instance Property
# configuration
The configuration for the effect.
Mac Catalyst
var configuration: SymbolEffectConfiguration { get }
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect/down)
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect/up)
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect/bylayer)
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect/wholesymbol)
---
# https://developer.apple.com/documentation/symbols/appearsymboleffect/configuration)
---
# https://developer.apple.com/documentation/symbols/automaticsymboleffect/configuration
- Symbols
- AutomaticSymbolEffect
- configuration
Instance Property
# configuration
The configuration for the effect.
Mac Catalyst
var configuration: SymbolEffectConfiguration { get }
---
# https://developer.apple.com/documentation/symbols/automaticsymboleffect/configuration)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect/bylayer
- Symbols
- RotateSymbolEffect
- byLayer
Instance Property
# byLayer
Mac Catalyst
var byLayer: RotateSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect/clockwise
- Symbols
- RotateSymbolEffect
- clockwise
Instance Property
# clockwise
Mac Catalyst
var clockwise: RotateSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect/configuration
- Symbols
- RotateSymbolEffect
- configuration
Instance Property
# configuration
Mac Catalyst
var configuration: SymbolEffectConfiguration { get }
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect/counterclockwise
- Symbols
- RotateSymbolEffect
- counterClockwise
Instance Property
# counterClockwise
Mac Catalyst
var counterClockwise: RotateSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect/wholesymbol
- Symbols
- RotateSymbolEffect
- wholeSymbol
Instance Property
# wholeSymbol
Mac Catalyst
var wholeSymbol: RotateSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect/bylayer)
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect/clockwise)
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect/configuration)
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect/counterclockwise)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/rotatesymboleffect/wholesymbol)
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/default
- Symbols
- SymbolEffectOptions
- default
Type Property
# default
The default set of effect options.
Mac Catalyst
static var `default`: SymbolEffectOptions { get }
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeating-swift.property
- Symbols
- SymbolEffectOptions
- repeating
Instance Property
# repeating
A set of effect options that prefers to repeat indefinitely.
iOS 17.0–26.2DeprecatediPadOS 17.0–26.2DeprecatedMac CatalystmacOS 14.0–26.2DeprecatedtvOS 17.0–26.2DeprecatedvisionOS 1.0–26.2DeprecatedwatchOS 10.0–26.2Deprecated
var repeating: SymbolEffectOptions { get }
## See Also
### Configuring repeating effects
`static var repeating: SymbolEffectOptions`
A default set of effect options that prefers to repeat indefinitely.
`var nonRepeating: SymbolEffectOptions`
A set of effect options that prefers to not repeat.
`static var nonRepeating: SymbolEffectOptions`
A default set of effect options that prefers to not repeat.
Creates a set of effect options with a preferred repeat count.
A default set of effect options with a preferred repeat count.
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeating-swift.type.property
- Symbols
- SymbolEffectOptions
- repeating
Type Property
# repeating
A default set of effect options that prefers to repeat indefinitely.
iOS 17.0–26.2DeprecatediPadOS 17.0–26.2DeprecatedMac CatalystmacOS 14.0–26.2DeprecatedtvOS 17.0–26.2DeprecatedvisionOS 1.0–26.2DeprecatedwatchOS 10.0–26.2Deprecated
static var repeating: SymbolEffectOptions { get }
## See Also
### Configuring repeating effects
`var repeating: SymbolEffectOptions`
A set of effect options that prefers to repeat indefinitely.
`var nonRepeating: SymbolEffectOptions`
A set of effect options that prefers to not repeat.
`static var nonRepeating: SymbolEffectOptions`
A default set of effect options that prefers to not repeat.
Creates a set of effect options with a preferred repeat count.
A default set of effect options with a preferred repeat count.
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/nonrepeating-swift.property
- Symbols
- SymbolEffectOptions
- nonRepeating
Instance Property
# nonRepeating
A set of effect options that prefers to not repeat.
Mac Catalyst
var nonRepeating: SymbolEffectOptions { get }
## See Also
### Configuring repeating effects
`var repeating: SymbolEffectOptions`
A set of effect options that prefers to repeat indefinitely.
`static var repeating: SymbolEffectOptions`
A default set of effect options that prefers to repeat indefinitely.
`static var nonRepeating: SymbolEffectOptions`
A default set of effect options that prefers to not repeat.
Creates a set of effect options with a preferred repeat count.
A default set of effect options with a preferred repeat count.
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/nonrepeating-swift.type.property
- Symbols
- SymbolEffectOptions
- nonRepeating
Type Property
# nonRepeating
A default set of effect options that prefers to not repeat.
Mac Catalyst
static var nonRepeating: SymbolEffectOptions { get }
## See Also
### Configuring repeating effects
`var repeating: SymbolEffectOptions`
A set of effect options that prefers to repeat indefinitely.
`static var repeating: SymbolEffectOptions`
A default set of effect options that prefers to repeat indefinitely.
`var nonRepeating: SymbolEffectOptions`
A set of effect options that prefers to not repeat.
Creates a set of effect options with a preferred repeat count.
A default set of effect options with a preferred repeat count.
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeat(_:)-314sv
-314sv#app-main)
- Symbols
- SymbolEffectOptions
- repeat(\_:)
Instance Method
# repeat(\_:)
Creates a set of effect options with a preferred repeat count.
iOS 17.0–26.2DeprecatediPadOS 17.0–26.2DeprecatedMac CatalystmacOS 14.0–26.2DeprecatedtvOS 17.0–26.2DeprecatedvisionOS 1.0–26.2DeprecatedwatchOS 10.0–26.2Deprecated
## Parameters
`count`
The preferred number of times to play the effect, or `nil` to request the default number of repeats. The function may clamp very large or small values.
## Return Value
A new set of effect options with the preferred repeat count.
## See Also
### Configuring repeating effects
`var repeating: SymbolEffectOptions`
A set of effect options that prefers to repeat indefinitely.
`static var repeating: SymbolEffectOptions`
A default set of effect options that prefers to repeat indefinitely.
`var nonRepeating: SymbolEffectOptions`
A set of effect options that prefers to not repeat.
`static var nonRepeating: SymbolEffectOptions`
A default set of effect options that prefers to not repeat.
A default set of effect options with a preferred repeat count.
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeat(_:)-33816
-33816#app-main)
- Symbols
- SymbolEffectOptions
- repeat(\_:)
Type Method
# repeat(\_:)
A default set of effect options with a preferred repeat count.
iOS 17.0–26.2DeprecatediPadOS 17.0–26.2DeprecatedMac CatalystmacOS 14.0–26.2DeprecatedtvOS 17.0–26.2DeprecatedvisionOS 1.0–26.2DeprecatedwatchOS 10.0–26.2Deprecated
## Parameters
`count`
The preferred number of times to play the effect, or `nil` to request the default number of times. The function may clamp very large or small values.
## Return Value
A new set of effect options with the preferred repeat count.
## See Also
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
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/speed(_:)-swift.method
-swift.method#app-main)
- Symbols
- SymbolEffectOptions
- speed(\_:)
Instance Method
# speed(\_:)
Creates a set of effect options with a preferred speed multiplier.
Mac Catalyst
## Parameters
`speed`
The preferred speed multiplier to play the effect with. The default multiplier is `1.0`. The function may clamp very large or small values.
## Return Value
A new set of effect options with the preferred speed multiplier.
## See Also
### Configuring effect speed
A default set of effect options with a preferred speed multiplier.
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/speed(_:)-swift.type.method
-swift.type.method#app-main)
- Symbols
- SymbolEffectOptions
- speed(\_:)
Type Method
# speed(\_:)
A default set of effect options with a preferred speed multiplier.
Mac Catalyst
## Parameters
`speed`
The preferred speed multiplier to play the effect with. The default multiplier is `1.0`. The function may clamp very large or small values.
## Return Value
A new set of effect options with the preferred speed multiplier.
## See Also
### Configuring effect speed
Creates a set of effect options with a preferred speed multiplier.
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeatbehavior
- Symbols
- SymbolEffectOptions
- SymbolEffectOptions.RepeatBehavior
Structure
# SymbolEffectOptions.RepeatBehavior
Mac Catalyst
struct RepeatBehavior
## Topics
### Type Properties
`static var continuous: SymbolEffectOptions.RepeatBehavior`
`static var periodic: SymbolEffectOptions.RepeatBehavior`
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeat(_:)-316cr
-316cr#app-main)
- Symbols
- SymbolEffectOptions
- repeat(\_:)
Instance Method
# repeat(\_:)
Mac Catalyst
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeat(_:)-3klm2
-3klm2#app-main)
- Symbols
- SymbolEffectOptions
- repeat(\_:)
Type Method
# repeat(\_:)
Mac Catalyst
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/default)
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeating-swift.property)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeating-swift.type.property)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/nonrepeating-swift.property)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/nonrepeating-swift.type.property)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeat(_:)-314sv)
-314sv)#app-main)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeat(_:)-33816)
-33816)#app-main)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/speed(_:)-swift.method)
-swift.method)#app-main)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/speed(_:)-swift.type.method)
-swift.type.method)#app-main)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeatbehavior)
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeat(_:)-316cr)
-316cr)#app-main)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeat(_:)-3klm2)
-3klm2)#app-main)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect/down
- Symbols
- DisappearSymbolEffect
- down
Instance Property
# down
An effect that scales the symbol down as it disappears.
Mac Catalyst
var down: DisappearSymbolEffect { get }
## See Also
### Accessing symbol effects
`var up: DisappearSymbolEffect`
An effect that scales the symbol up as it disappears.
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect/up
- Symbols
- DisappearSymbolEffect
- up
Instance Property
# up
An effect that scales the symbol up as it disappears.
Mac Catalyst
var up: DisappearSymbolEffect { get }
## See Also
### Accessing symbol effects
`var down: DisappearSymbolEffect`
An effect that scales the symbol down as it disappears.
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect/bylayer
- Symbols
- DisappearSymbolEffect
- byLayer
Instance Property
# byLayer
An effect that makes each layer disappear separately.
Mac Catalyst
var byLayer: DisappearSymbolEffect { get }
## See Also
### Determining effect scope
`var wholeSymbol: DisappearSymbolEffect`
An effect that makes all layers disappear simultaneously.
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect/wholesymbol
- Symbols
- DisappearSymbolEffect
- wholeSymbol
Instance Property
# wholeSymbol
An effect that makes all layers disappear simultaneously.
Mac Catalyst
var wholeSymbol: DisappearSymbolEffect { get }
## See Also
### Determining effect scope
`var byLayer: DisappearSymbolEffect`
An effect that makes each layer disappear separately.
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect/configuration
- Symbols
- DisappearSymbolEffect
- configuration
Instance Property
# configuration
The configuration for the effect.
Mac Catalyst
var configuration: SymbolEffectConfiguration { get }
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect/down)
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect/up)
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect/bylayer)
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect/wholesymbol)
---
# https://developer.apple.com/documentation/symbols/disappearsymboleffect/configuration)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect/down
- Symbols
- ScaleSymbolEffect
- down
Instance Property
# down
An effect that scales the symbol down.
Mac Catalyst
var down: ScaleSymbolEffect { get }
## See Also
### Accessing symbol effects
`var up: ScaleSymbolEffect`
An effect that scales the symbol up.
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect/up
- Symbols
- ScaleSymbolEffect
- up
Instance Property
# up
An effect that scales the symbol up.
Mac Catalyst
var up: ScaleSymbolEffect { get }
## See Also
### Accessing symbol effects
`var down: ScaleSymbolEffect`
An effect that scales the symbol down.
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect/bylayer
- Symbols
- ScaleSymbolEffect
- byLayer
Instance Property
# byLayer
An effect that scales each layer separately.
Mac Catalyst
var byLayer: ScaleSymbolEffect { get }
## See Also
### Determining effect scope
`var wholeSymbol: ScaleSymbolEffect`
An effect that scales all layers simultaneously.
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect/wholesymbol
- Symbols
- ScaleSymbolEffect
- wholeSymbol
Instance Property
# wholeSymbol
An effect that scales all layers simultaneously.
Mac Catalyst
var wholeSymbol: ScaleSymbolEffect { get }
## See Also
### Determining effect scope
`var byLayer: ScaleSymbolEffect`
An effect that scales each layer separately.
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect/configuration
- Symbols
- ScaleSymbolEffect
- configuration
Instance Property
# configuration
The configuration for the effect.
Mac Catalyst
var configuration: SymbolEffectConfiguration { get }
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect/down)
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect/up)
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect/bylayer)
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect/wholesymbol)
---
# https://developer.apple.com/documentation/symbols/scalesymboleffect/configuration)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/backward
- Symbols
- WiggleSymbolEffect
- backward
Instance Property
# backward
Mac Catalyst
var backward: WiggleSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/bylayer
- Symbols
- WiggleSymbolEffect
- byLayer
Instance Property
# byLayer
Mac Catalyst
var byLayer: WiggleSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/clockwise
- Symbols
- WiggleSymbolEffect
- clockwise
Instance Property
# clockwise
Mac Catalyst
var clockwise: WiggleSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/configuration
- Symbols
- WiggleSymbolEffect
- configuration
Instance Property
# configuration
Mac Catalyst
var configuration: SymbolEffectConfiguration { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/counterclockwise
- Symbols
- WiggleSymbolEffect
- counterClockwise
Instance Property
# counterClockwise
Mac Catalyst
var counterClockwise: WiggleSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/down
- Symbols
- WiggleSymbolEffect
- down
Instance Property
# down
Mac Catalyst
var down: WiggleSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/forward
- Symbols
- WiggleSymbolEffect
- forward
Instance Property
# forward
Mac Catalyst
var forward: WiggleSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/left
- Symbols
- WiggleSymbolEffect
- left
Instance Property
# left
Mac Catalyst
var left: WiggleSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/right
- Symbols
- WiggleSymbolEffect
- right
Instance Property
# right
Mac Catalyst
var right: WiggleSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/up
- Symbols
- WiggleSymbolEffect
- up
Instance Property
# up
Mac Catalyst
var up: WiggleSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/wholesymbol
- Symbols
- WiggleSymbolEffect
- wholeSymbol
Instance Property
# wholeSymbol
Mac Catalyst
var wholeSymbol: WiggleSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/custom(angle:)-1f09q
-1f09q#app-main)
- Symbols
- WiggleSymbolEffect
- custom(angle:)
Instance Method
# custom(angle:)
Mac Catalyst
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/custom(angle:)-cqpf
-cqpf#app-main)
- Symbols
- WiggleSymbolEffect
- custom(angle:)
Instance Method
# custom(angle:)
Mac Catalyst
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/backward)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/bylayer)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/clockwise)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/configuration)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/counterclockwise)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/down)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/forward)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/left)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/right)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/up)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/wholesymbol)
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/custom(angle:)-1f09q)
-1f09q)#app-main)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/wigglesymboleffect/custom(angle:)-cqpf)
-cqpf)#app-main)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect/bylayer
- Symbols
- BreatheSymbolEffect
- byLayer
Instance Property
# byLayer
Mac Catalyst
var byLayer: BreatheSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect/configuration
- Symbols
- BreatheSymbolEffect
- configuration
Instance Property
# configuration
Mac Catalyst
var configuration: SymbolEffectConfiguration { get }
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect/plain
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect/pulse
- Symbols
- BreatheSymbolEffect
- pulse
Instance Property
# pulse
Mac Catalyst
var pulse: BreatheSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect/wholesymbol
- Symbols
- BreatheSymbolEffect
- wholeSymbol
Instance Property
# wholeSymbol
Mac Catalyst
var wholeSymbol: BreatheSymbolEffect { get }
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect/bylayer)
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect/configuration)
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect/plain)
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect/pulse)
---
# https://developer.apple.com/documentation/symbols/breathesymboleffect/wholesymbol)
---
# https://developer.apple.com/documentation/symbols/bouncesymboleffect/down
- Symbols
- BounceSymbolEffect
- down
Instance Property
# down
An effect that bounces the symbol downward.
Mac Catalyst
var down: BounceSymbolEffect { get }
## See Also
### Accessing symbol effects
`var up: BounceSymbolEffect`
An effect that bounces the symbol upward.
---
# https://developer.apple.com/documentation/symbols/bouncesymboleffect/up
- Symbols
- BounceSymbolEffect
- up
Instance Property
# up
An effect that bounces the symbol upward.
Mac Catalyst
var up: BounceSymbolEffect { get }
## See Also
### Accessing symbol effects
`var down: BounceSymbolEffect`
An effect that bounces the symbol downward.
---
# https://developer.apple.com/documentation/symbols/bouncesymboleffect/bylayer
- Symbols
- BounceSymbolEffect
- byLayer
Instance Property
# byLayer
An effect that bounces each layer separately.
Mac Catalyst
var byLayer: BounceSymbolEffect { get }
## See Also
### Determining effect scope
`var wholeSymbol: BounceSymbolEffect`
An effect that bounces all layers simultaneously.
---
# https://developer.apple.com/documentation/symbols/bouncesymboleffect/wholesymbol
- Symbols
- BounceSymbolEffect
- wholeSymbol
Instance Property
# wholeSymbol
An effect that bounces all layers simultaneously.
Mac Catalyst
var wholeSymbol: BounceSymbolEffect { get }
## See Also
### Determining effect scope
`var byLayer: BounceSymbolEffect`
An effect that bounces each layer separately.
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeatbehavior/continuous
- Symbols
- SymbolEffectOptions
- SymbolEffectOptions.RepeatBehavior
- continuous
Type Property
# continuous
Mac Catalyst
static var continuous: SymbolEffectOptions.RepeatBehavior { get }
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeatbehavior/periodic
- Symbols
- SymbolEffectOptions
- SymbolEffectOptions.RepeatBehavior
- periodic
Type Property
# periodic
Mac Catalyst
static var periodic: SymbolEffectOptions.RepeatBehavior { get }
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeatbehavior/periodic(_:delay:)
#app-main)
- Symbols
- SymbolEffectOptions
- SymbolEffectOptions.RepeatBehavior
- periodic(\_:delay:)
Type Method
# periodic(\_:delay:)
Mac Catalyst
static func periodic(
_ count: Int? = nil,
delay: Double? = nil
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeatbehavior/continuous)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeatbehavior/periodic)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/symboleffectoptions/repeatbehavior/periodic(_:delay:))
)#app-main)
# The page you're looking for can't be found.
Search developer.apple.comSearch Icon
---
# https://developer.apple.com/documentation/symbols/bouncesymboleffect/bylayer)
---
# https://developer.apple.com/documentation/symbols/bouncesymboleffect/down)
---
# https://developer.apple.com/documentation/symbols/bouncesymboleffect/wholesymbol)
---
# https://developer.apple.com/documentation/symbols/bouncesymboleffect/up)
---
