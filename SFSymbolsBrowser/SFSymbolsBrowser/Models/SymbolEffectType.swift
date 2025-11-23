import SwiftUI

/// Represents the available SF Symbol effects from Apple's Symbols framework (iOS 17+)
/// Based on Apple's official Symbols framework documentation
enum SymbolEffectType: String, CaseIterable, Identifiable {
    // MARK: - Discrete Effects (run from start to finish)
    case none = "None"
    case bounce = "Bounce"
    case pulse = "Pulse"
    case variableColor = "Variable Color"
    case breathe = "Breathe"
    case wiggle = "Wiggle"
    case rotate = "Rotate"

    // MARK: - Scale Effect (can be indefinite)
    case scale = "Scale"

    var id: String { rawValue }

    /// Icon representing the effect
    var iconName: String {
        switch self {
        case .none: return "circle.slash"
        case .bounce: return "arrow.up.arrow.down"
        case .pulse: return "waveform.path"
        case .variableColor: return "paintpalette"
        case .breathe: return "lungs"
        case .wiggle: return "arrow.left.arrow.right"
        case .rotate: return "arrow.clockwise"
        case .scale: return "arrow.up.left.and.arrow.down.right"
        }
    }

    /// Human-readable description
    var description: String {
        switch self {
        case .none:
            return "No animation effect"
        case .bounce:
            return "Applies a transitory scaling effect"
        case .pulse:
            return "Fades the opacity of layers"
        case .variableColor:
            return "Animates variable layers sequentially"
        case .breathe:
            return "Smooth pulsating scale effect"
        case .wiggle:
            return "Side-to-side or rotational shake"
        case .rotate:
            return "Continuous rotation animation"
        case .scale:
            return "Scales the symbol up or down"
        }
    }

    /// Minimum iOS version required
    var minimumVersion: String {
        switch self {
        case .none: return "15.0"
        case .bounce, .pulse, .variableColor, .scale: return "17.0"
        case .breathe, .wiggle, .rotate: return "18.0"
        }
    }

    /// Whether this effect is available on current iOS version
    var isAvailable: Bool {
        if #available(iOS 18.0, *) {
            return true
        } else if #available(iOS 17.0, *) {
            switch self {
            case .breathe, .wiggle, .rotate:
                return false
            default:
                return true
            }
        } else {
            return self == .none
        }
    }

    /// Available cases for current iOS version
    static var availableCases: [SymbolEffectType] {
        allCases.filter { $0.isAvailable }
    }
}

// MARK: - Effect Options

/// Options for customizing symbol effects
enum SymbolEffectScope: String, CaseIterable, Identifiable {
    case wholeSymbol = "Whole Symbol"
    case byLayer = "By Layer"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .wholeSymbol: return "square.fill"
        case .byLayer: return "square.stack.3d.up"
        }
    }
}

/// Direction options for bounce and wiggle effects
enum SymbolEffectDirection: String, CaseIterable, Identifiable {
    case up = "Up"
    case down = "Down"
    case left = "Left"
    case right = "Right"
    case clockwise = "Clockwise"
    case counterClockwise = "Counter-Clockwise"

    var id: String { rawValue }

    var iconName: String {
        switch self {
        case .up: return "arrow.up"
        case .down: return "arrow.down"
        case .left: return "arrow.left"
        case .right: return "arrow.right"
        case .clockwise: return "arrow.clockwise"
        case .counterClockwise: return "arrow.counterclockwise"
        }
    }

    /// Directions available for bounce effect
    static var bounceDirections: [SymbolEffectDirection] {
        [.up, .down]
    }

    /// Directions available for wiggle effect
    static var wiggleDirections: [SymbolEffectDirection] {
        [.up, .down, .left, .right, .clockwise, .counterClockwise]
    }

    /// Directions available for rotate effect
    static var rotateDirections: [SymbolEffectDirection] {
        [.clockwise, .counterClockwise]
    }
}

/// Variable color animation style
enum VariableColorStyle: String, CaseIterable, Identifiable {
    case iterative = "Iterative"
    case cumulative = "Cumulative"

    var id: String { rawValue }

    var description: String {
        switch self {
        case .iterative: return "One layer at a time"
        case .cumulative: return "Layers accumulate"
        }
    }
}

/// Speed options for effects
enum SymbolEffectSpeed: String, CaseIterable, Identifiable {
    case slow = "Slow"
    case normal = "Normal"
    case fast = "Fast"

    var id: String { rawValue }

    var multiplier: Double {
        switch self {
        case .slow: return 0.5
        case .normal: return 1.0
        case .fast: return 2.0
        }
    }
}

/// Repeat options for effects
enum SymbolEffectRepeat: String, CaseIterable, Identifiable {
    case once = "Once"
    case twice = "2x"
    case thrice = "3x"
    case continuous = "Continuous"

    var id: String { rawValue }

    var count: Int? {
        switch self {
        case .once: return 1
        case .twice: return 2
        case .thrice: return 3
        case .continuous: return nil
        }
    }
}

// MARK: - Complete Effect Configuration

/// Complete configuration for a symbol effect
struct SymbolEffectConfiguration: Equatable {
    var effectType: SymbolEffectType = .none
    var scope: SymbolEffectScope = .wholeSymbol
    var direction: SymbolEffectDirection = .up
    var variableColorStyle: VariableColorStyle = .iterative
    var reversing: Bool = false
    var speed: SymbolEffectSpeed = .normal
    var repeatOption: SymbolEffectRepeat = .continuous

    /// Whether to show direction picker for current effect
    var showsDirectionPicker: Bool {
        switch effectType {
        case .bounce, .wiggle, .rotate:
            return true
        default:
            return false
        }
    }

    /// Available directions for current effect
    var availableDirections: [SymbolEffectDirection] {
        switch effectType {
        case .bounce:
            return SymbolEffectDirection.bounceDirections
        case .wiggle:
            return SymbolEffectDirection.wiggleDirections
        case .rotate:
            return SymbolEffectDirection.rotateDirections
        default:
            return []
        }
    }

    /// Whether this effect supports reversing
    var supportsReversing: Bool {
        effectType == .variableColor
    }

    /// Whether this effect supports scope selection
    var supportsScope: Bool {
        switch effectType {
        case .bounce, .pulse, .scale:
            return true
        default:
            return false
        }
    }
}
