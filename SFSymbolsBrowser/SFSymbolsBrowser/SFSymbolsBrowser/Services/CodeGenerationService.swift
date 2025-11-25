import SwiftUI
import SFSymbols

/// Service for generating SwiftUI and UIKit code from symbol configurations
struct CodeGenerationService {

    enum Framework: String, CaseIterable, Identifiable {
        case swiftUI = "SwiftUI"
        case uiKit = "UIKit"

        var id: String { rawValue }
    }

    /// Generate code for a symbol with the given configuration
    func generateCode(
        symbolName: String,
        weight: Font.Weight,
        color: Color,
        renderingMode: RenderingMode,
        size: CGFloat = 32,
        framework: Framework,
        effectConfiguration: SymbolEffectConfiguration? = nil
    ) -> String {
        switch framework {
        case .swiftUI:
            return generateSwiftUICode(
                symbolName: symbolName,
                weight: weight,
                color: color,
                renderingMode: renderingMode,
                size: size,
                effectConfiguration: effectConfiguration
            )
        case .uiKit:
            return generateUIKitCode(
                symbolName: symbolName,
                weight: weight,
                color: color,
                renderingMode: renderingMode,
                size: size,
                effectConfiguration: effectConfiguration
            )
        }
    }

    // MARK: - SwiftUI Code Generation

    private func generateSwiftUICode(
        symbolName: String,
        weight: Font.Weight,
        color: Color,
        renderingMode: RenderingMode,
        size: CGFloat,
        effectConfiguration: SymbolEffectConfiguration?
    ) -> String {
        var lines: [String] = []

        // Image declaration
        lines.append("Image(systemName: \"\(symbolName)\")")

        // Rendering mode (if not monochrome)
        if renderingMode != .monochrome {
            lines.append("    .symbolRenderingMode(.\(renderingModeName(renderingMode)))")
        }

        // Color
        let colorCode = swiftUIColorCode(color)
        lines.append("    .foregroundStyle(\(colorCode))")

        // Font with weight
        let weightName = swiftUIWeightName(weight)
        lines.append("    .font(.system(size: \(Int(size)), weight: .\(weightName)))")

        // Symbol effect (if configured)
        if let config = effectConfiguration, config.effectType != .none {
            lines.append(generateSwiftUIEffectCode(config))
        }

        return lines.joined(separator: "\n")
    }

    /// Generate SwiftUI symbol effect code
    private func generateSwiftUIEffectCode(_ config: SymbolEffectConfiguration) -> String {
        let effectCode: String
        let optionsCode = generateEffectOptionsCode(config)

        switch config.effectType {
        case .none:
            return ""

        case .bounce:
            let direction = config.direction == .down ? ".down" : ".up"
            let scope = config.scope == .byLayer ? ".byLayer" : ".wholeSymbol"
            effectCode = ".bounce\(direction)\(scope)"

        case .pulse:
            let scope = config.scope == .byLayer ? ".byLayer" : ".wholeSymbol"
            effectCode = ".pulse\(scope)"

        case .variableColor:
            var effect = ".variableColor"
            // Inactive layer style (per Apple docs)
            switch config.variableColorInactiveStyle {
            case .hideInactiveLayers:
                effect += ".hideInactiveLayers"
            case .dimInactiveLayers:
                effect += ".dimInactiveLayers"
            case .normal:
                break
            }
            // Fill style
            effect += config.variableColorStyle == .cumulative ? ".cumulative" : ".iterative"
            // Reversing
            if config.reversing {
                effect += ".reversing"
            }
            effectCode = effect

        case .breathe:
            var effect = ".breathe"
            // Breathe style (iOS 18+)
            if config.breatheStyle == .pulse {
                effect += ".pulse"
            } else {
                effect += ".plain"
            }
            // Scope
            let scope = config.scope == .byLayer ? ".byLayer" : ".wholeSymbol"
            effect += scope
            effectCode = effect

        case .wiggle:
            var effect = ".wiggle"
            // Direction (per Apple docs: up, down, left, right, forward, backward, clockwise, counterClockwise)
            switch config.direction {
            case .up: effect += ".up"
            case .down: effect += ".down"
            case .left: effect += ".left"
            case .right: effect += ".right"
            case .forward: effect += ".forward"
            case .backward: effect += ".backward"
            case .clockwise: effect += ".clockwise"
            case .counterClockwise: effect += ".counterClockwise"
            }
            // Scope
            let scope = config.scope == .byLayer ? ".byLayer" : ".wholeSymbol"
            effect += scope
            effectCode = effect

        case .rotate:
            var effect = ".rotate"
            let direction = config.direction == .counterClockwise ? ".counterClockwise" : ".clockwise"
            effect += direction
            // Scope
            let scope = config.scope == .byLayer ? ".byLayer" : ".wholeSymbol"
            effect += scope
            effectCode = effect

        case .scale:
            let direction = config.direction == .down ? ".down" : ".up"
            let scope = config.scope == .byLayer ? ".byLayer" : ".wholeSymbol"
            effectCode = ".scale\(direction)\(scope)"
        }

        // Determine if using value-based trigger or indefinite
        if config.repeatOption == .continuous {
            if optionsCode.isEmpty {
                return "    .symbolEffect(\(effectCode))"
            } else {
                return "    .symbolEffect(\(effectCode)\(optionsCode))"
            }
        } else {
            return "    .symbolEffect(\(effectCode)\(optionsCode), value: trigger)"
        }
    }

    /// Generate effect options code
    private func generateEffectOptionsCode(_ config: SymbolEffectConfiguration) -> String {
        var options: [String] = []

        // Speed (only if not normal)
        if config.speed != .normal {
            options.append(".speed(\(config.speed.multiplier))")
        }

        // Repeat count (only for discrete behavior, not continuous)
        if let count = config.repeatOption.count {
            options.append(".repeat(\(count))")
        }
        // Note: For continuous (indefinite) behavior, no .repeating option needed per Apple docs

        if options.isEmpty {
            return ""
        }

        return ", options: " + options.joined(separator: "")
    }

    // MARK: - UIKit Code Generation

    private func generateUIKitCode(
        symbolName: String,
        weight: Font.Weight,
        color: Color,
        renderingMode: RenderingMode,
        size: CGFloat,
        effectConfiguration: SymbolEffectConfiguration?
    ) -> String {
        var lines: [String] = []

        let weightName = uiKitWeightName(weight)

        // Configuration
        lines.append("let config = UIImage.SymbolConfiguration(")
        lines.append("    pointSize: \(Int(size)),")
        lines.append("    weight: .\(weightName)")
        lines.append(")")
        lines.append("")

        // Image creation
        lines.append("let image = UIImage(")
        lines.append("    systemName: \"\(symbolName)\",")
        lines.append("    withConfiguration: config")
        lines.append(")")
        lines.append("")

        // ImageView setup
        lines.append("let imageView = UIImageView(image: image)")

        // Tint color
        let colorCode = uiKitColorCode(color)
        lines.append("imageView.tintColor = \(colorCode)")

        // Preferred symbol configuration for rendering mode
        if renderingMode != .monochrome {
            lines.append("")
            lines.append("// For \(renderingModeName(renderingMode)) rendering:")
            switch renderingMode {
            case .hierarchical:
                lines.append("imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: \(colorCode))")
            case .palette:
                lines.append("imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(paletteColors: [\(colorCode), .systemGray])")
            case .multicolor:
                lines.append("imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration.preferringMulticolor()")
            case .monochrome:
                break // Already handled above
            }
        }

        // Symbol effect (if configured)
        if let config = effectConfiguration, config.effectType != .none {
            lines.append("")
            lines.append(generateUIKitEffectCode(config))
        }

        return lines.joined(separator: "\n")
    }

    /// Generate UIKit symbol effect code
    private func generateUIKitEffectCode(_ config: SymbolEffectConfiguration) -> String {
        var lines: [String] = []
        lines.append("// Symbol Effect (iOS 17+)")

        let effectCode: String
        switch config.effectType {
        case .none:
            return ""

        case .bounce:
            let direction = config.direction == .down ? " effectWithDown]" : "]"
            let scope = config.scope == .byLayer ? " effectWithByLayer]" : " effectWithWholeSymbol]"
            effectCode = "[[[NSSymbolBounceEffect effect\(direction)\(scope)"

        case .pulse:
            let scope = config.scope == .byLayer ? " effectWithByLayer]" : " effectWithWholeSymbol]"
            effectCode = "[[NSSymbolPulseEffect effect]\(scope)"

        case .variableColor:
            var effect = "[NSSymbolVariableColorEffect effect]"
            // Inactive layer style
            switch config.variableColorInactiveStyle {
            case .hideInactiveLayers:
                effect = "[\(effect) effectWithHideInactiveLayers]"
            case .dimInactiveLayers:
                effect = "[\(effect) effectWithDimInactiveLayers]"
            case .normal:
                break
            }
            // Fill style
            if config.variableColorStyle == .cumulative {
                effect = "[\(effect) effectWithCumulative]"
            } else {
                effect = "[\(effect) effectWithIterative]"
            }
            // Reversing
            if config.reversing {
                effect = "[\(effect) effectWithReversing]"
            }
            effectCode = effect

        case .breathe:
            var effect = "[NSSymbolBreatheEffect effect]"
            // Style
            if config.breatheStyle == .pulse {
                effect = "[\(effect) effectWithPulse]"
            } else {
                effect = "[\(effect) effectWithPlain]"
            }
            // Scope
            let scope = config.scope == .byLayer ? " effectWithByLayer]" : " effectWithWholeSymbol]"
            effectCode = "[\(effect)\(scope)"

        case .wiggle:
            var effect = "[NSSymbolWiggleEffect effect]"
            // Direction
            switch config.direction {
            case .up: effect = "[\(effect) effectWithUp]"
            case .down: effect = "[\(effect) effectWithDown]"
            case .left: effect = "[\(effect) effectWithLeft]"
            case .right: effect = "[\(effect) effectWithRight]"
            case .forward: effect = "[\(effect) effectWithForward]"
            case .backward: effect = "[\(effect) effectWithBackward]"
            case .clockwise: effect = "[\(effect) effectWithClockwise]"
            case .counterClockwise: effect = "[\(effect) effectWithCounterClockwise]"
            }
            // Scope
            let scope = config.scope == .byLayer ? " effectWithByLayer]" : " effectWithWholeSymbol]"
            effectCode = "[\(effect)\(scope)"

        case .rotate:
            var effect = "[NSSymbolRotateEffect effect]"
            let direction = config.direction == .counterClockwise ? " effectWithCounterClockwise]" : " effectWithClockwise]"
            effect = "[\(effect)\(direction)"
            // Scope
            let scope = config.scope == .byLayer ? " effectWithByLayer]" : " effectWithWholeSymbol]"
            effectCode = "[\(effect)\(scope)"

        case .scale:
            let direction = config.direction == .down ? " effectWithDown]" : " effectWithUp]"
            let scope = config.scope == .byLayer ? " effectWithByLayer]" : " effectWithWholeSymbol]"
            effectCode = "[[[NSSymbolScaleEffect effect]\(direction)\(scope)"
        }

        lines.append("imageView.addSymbolEffect(\(effectCode))")

        return lines.joined(separator: "\n")
    }

    // MARK: - Helper Methods

    private func renderingModeName(_ mode: RenderingMode) -> String {
        return mode.rawValue
    }

    private func swiftUIWeightName(_ weight: Font.Weight) -> String {
        switch weight {
        case .ultraLight: return "ultraLight"
        case .thin: return "thin"
        case .light: return "light"
        case .regular: return "regular"
        case .medium: return "medium"
        case .semibold: return "semibold"
        case .bold: return "bold"
        case .heavy: return "heavy"
        case .black: return "black"
        default: return "regular"
        }
    }

    private func uiKitWeightName(_ weight: Font.Weight) -> String {
        switch weight {
        case .ultraLight: return "ultraLight"
        case .thin: return "thin"
        case .light: return "light"
        case .regular: return "regular"
        case .medium: return "medium"
        case .semibold: return "semibold"
        case .bold: return "bold"
        case .heavy: return "heavy"
        case .black: return "black"
        default: return "regular"
        }
    }

    private func swiftUIColorCode(_ color: Color) -> String {
        // Map common system colors to their SwiftUI names
        switch color {
        case .red: return ".red"
        case .orange: return ".orange"
        case .yellow: return ".yellow"
        case .green: return ".green"
        case .mint: return ".mint"
        case .teal: return ".teal"
        case .cyan: return ".cyan"
        case .blue: return ".blue"
        case .indigo: return ".indigo"
        case .purple: return ".purple"
        case .pink: return ".pink"
        case .brown: return ".brown"
        case .primary: return ".primary"
        case .secondary: return ".secondary"
        default:
            // For custom colors, output the Color initializer
            return ".accentColor"
        }
    }

    private func uiKitColorCode(_ color: Color) -> String {
        switch color {
        case .red: return ".systemRed"
        case .orange: return ".systemOrange"
        case .yellow: return ".systemYellow"
        case .green: return ".systemGreen"
        case .mint: return ".systemMint"
        case .teal: return ".systemTeal"
        case .cyan: return ".systemCyan"
        case .blue: return ".systemBlue"
        case .indigo: return ".systemIndigo"
        case .purple: return ".systemPurple"
        case .pink: return ".systemPink"
        case .brown: return ".systemBrown"
        case .primary: return ".label"
        case .secondary: return ".secondaryLabel"
        default:
            return ".tintColor"
        }
    }
}

