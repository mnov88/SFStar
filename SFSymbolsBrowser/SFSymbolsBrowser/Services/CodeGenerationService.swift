import SwiftUI
import SFSafeSymbols

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
        renderingMode: SymbolRenderingMode,
        size: CGFloat = 32,
        framework: Framework
    ) -> String {
        switch framework {
        case .swiftUI:
            return generateSwiftUICode(
                symbolName: symbolName,
                weight: weight,
                color: color,
                renderingMode: renderingMode,
                size: size
            )
        case .uiKit:
            return generateUIKitCode(
                symbolName: symbolName,
                weight: weight,
                color: color,
                renderingMode: renderingMode,
                size: size
            )
        }
    }

    // MARK: - SwiftUI Code Generation

    private func generateSwiftUICode(
        symbolName: String,
        weight: Font.Weight,
        color: Color,
        renderingMode: SymbolRenderingMode,
        size: CGFloat
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

        return lines.joined(separator: "\n")
    }

    // MARK: - UIKit Code Generation

    private func generateUIKitCode(
        symbolName: String,
        weight: Font.Weight,
        color: Color,
        renderingMode: SymbolRenderingMode,
        size: CGFloat
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
            default:
                break
            }
        }

        return lines.joined(separator: "\n")
    }

    // MARK: - Helper Methods

    private func renderingModeName(_ mode: SymbolRenderingMode) -> String {
        switch mode {
        case .monochrome: return "monochrome"
        case .hierarchical: return "hierarchical"
        case .palette: return "palette"
        case .multicolor: return "multicolor"
        @unknown default: return "monochrome"
        }
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

// MARK: - Symbol Rendering Mode Extension
extension SymbolRenderingMode: CaseIterable, Identifiable {
    public static var allCases: [SymbolRenderingMode] {
        [.monochrome, .hierarchical, .palette, .multicolor]
    }

    public var id: String { displayName }

    var displayName: String {
        switch self {
        case .monochrome: return "Mono"
        case .hierarchical: return "Hierarchical"
        case .palette: return "Palette"
        case .multicolor: return "Multicolor"
        @unknown default: return "Unknown"
        }
    }

    var description: String {
        switch self {
        case .monochrome: return "Single color"
        case .hierarchical: return "Depth via opacity"
        case .palette: return "Up to 3 colors"
        case .multicolor: return "Original colors"
        @unknown default: return ""
        }
    }
}
