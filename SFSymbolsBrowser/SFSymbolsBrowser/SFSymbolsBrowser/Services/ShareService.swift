import SwiftUI
import UIKit

/// Service for sharing symbol content via iOS share sheet
struct ShareService {
    /// Shares the symbol name as text
    static func shareSymbolName(_ name: String) {
        let text = name
        share(items: [text])
    }

    /// Shares the symbol as an image with its name
    static func shareSymbolImage(
        name: String,
        weight: Font.Weight = .regular,
        color: Color = .primary,
        renderingMode: SymbolRenderingMode = .monochrome,
        size: CGFloat = 100
    ) {
        guard let image = renderSymbolImage(
            name: name,
            weight: weight,
            color: color,
            renderingMode: renderingMode,
            size: size
        ) else {
            // Fallback to just sharing the name
            shareSymbolName(name)
            return
        }

        let text = "SF Symbol: \(name)"
        share(items: [image, text])
    }

    /// Shares generated code snippet
    static func shareCode(_ code: String, symbolName: String) {
        let text = "// SF Symbol: \(symbolName)\n\(code)"
        share(items: [text])
    }

    /// Presents the share sheet with given items
    private static func share(items: [Any]) {
        let activityVC = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )

        // Get the root view controller
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else {
            return
        }

        // Find the topmost presented view controller
        var topVC = rootVC
        while let presented = topVC.presentedViewController {
            topVC = presented
        }

        // Configure for iPad
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = topVC.view
            popover.sourceRect = CGRect(
                x: topVC.view.bounds.midX,
                y: topVC.view.bounds.midY,
                width: 0,
                height: 0
            )
            popover.permittedArrowDirections = []
        }

        topVC.present(activityVC, animated: true)
    }

    /// Renders a symbol as a UIImage
    private static func renderSymbolImage(
        name: String,
        weight: Font.Weight,
        color: Color,
        renderingMode: SymbolRenderingMode,
        size: CGFloat
    ) -> UIImage? {
        let baseConfig = UIImage.SymbolConfiguration(pointSize: size, weight: weight.uiKitWeight)
        let uiColor = UIColor(color)

        switch renderingMode {
        case .monochrome:
            guard let image = UIImage(systemName: name, withConfiguration: baseConfig) else {
                return nil
            }
            return image.withTintColor(uiColor, renderingMode: UIImage.RenderingMode.alwaysOriginal)
        case .hierarchical:
            let hierarchicalConfig = baseConfig.applying(UIImage.SymbolConfiguration(hierarchicalColor: uiColor))
            return UIImage(systemName: name, withConfiguration: hierarchicalConfig)
        case .palette:
            let paletteConfig = baseConfig.applying(UIImage.SymbolConfiguration(paletteColors: [uiColor]))
            return UIImage(systemName: name, withConfiguration: paletteConfig)
        case .multicolor:
            return UIImage(systemName: name, withConfiguration: baseConfig)
        }
    }
}

// MARK: - Font.Weight Extension
private extension Font.Weight {
    var uiKitWeight: UIImage.SymbolWeight {
        switch self {
        case .ultraLight: return .ultraLight
        case .thin: return .thin
        case .light: return .light
        case .regular: return .regular
        case .medium: return .medium
        case .semibold: return .semibold
        case .bold: return .bold
        case .heavy: return .heavy
        case .black: return .black
        default: return .regular
        }
    }
}

// MARK: - Share Button View
struct ShareButton: View {
    let symbolName: String
    let weight: Font.Weight
    let color: Color
    let renderingMode: SymbolRenderingMode

    var body: some View {
        Button {
            ShareService.shareSymbolImage(
                name: symbolName,
                weight: weight,
                color: color,
                renderingMode: renderingMode
            )
            HapticManager.shared.lightTap()
        } label: {
            Label("Share", systemImage: "square.and.arrow.up")
        }
    }
}

/// Premium share button with gradient styling
struct PremiumShareButton: View {
    let symbolName: String
    let weight: Font.Weight
    let color: Color
    let renderingMode: SymbolRenderingMode

    var body: some View {
        Menu {
            Button {
                ShareService.shareSymbolName(symbolName)
                HapticManager.shared.lightTap()
            } label: {
                Label("Share Name", systemImage: "textformat")
            }

            Button {
                ShareService.shareSymbolImage(
                    name: symbolName,
                    weight: weight,
                    color: color,
                    renderingMode: renderingMode
                )
                HapticManager.shared.lightTap()
            } label: {
                Label("Share Image", systemImage: "photo")
            }
        } label: {
            Label("Share", systemImage: "square.and.arrow.up")
        }
    }
}
