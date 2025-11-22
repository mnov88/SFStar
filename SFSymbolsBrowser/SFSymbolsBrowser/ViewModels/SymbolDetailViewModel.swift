import SwiftUI

/// ViewModel for the symbol detail view
@Observable
final class SymbolDetailViewModel {
    // MARK: - Properties
    let symbol: SymbolItem

    var selectedWeight: Font.Weight = .regular
    var selectedColor: Color = .primary
    var selectedRenderingMode: SymbolRenderingMode = .monochrome

    var isExporting: Bool = false
    var exportError: ExportError? = nil
    var showExportSuccess: Bool = false
    var exportedFileURL: URL? = nil

    var showCopiedToast: Bool = false

    private let exportService = ExportService()

    // MARK: - Computed Properties
    var symbolName: String {
        symbol.name
    }

    var configuration: SymbolConfiguration {
        SymbolConfiguration(
            weight: selectedWeight,
            color: selectedColor,
            renderingMode: selectedRenderingMode
        )
    }

    // MARK: - Initialization
    init(symbol: SymbolItem) {
        self.symbol = symbol
    }

    // MARK: - Actions

    /// Copies the symbol name to clipboard
    @MainActor
    func copyName() {
        UIPasteboard.general.string = symbolName
        provideFeedback(.success)
        showCopiedToast = true

        // Hide toast after delay
        Task {
            try? await Task.sleep(nanoseconds: 1_500_000_000)  // 1.5 seconds
            showCopiedToast = false
        }
    }

    /// Exports the symbol as PNG
    @MainActor
    func exportPNG(scale: ExportScale = .x2) async {
        isExporting = true
        exportError = nil

        do {
            let result = try await exportService.exportPNG(
                symbolName: symbolName,
                weight: selectedWeight,
                color: selectedColor,
                renderingMode: selectedRenderingMode,
                scale: scale
            )

            exportedFileURL = result.fileURL
            showExportSuccess = true
            provideFeedback(.success)

            // Hide success after delay
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)  // 2 seconds
                showExportSuccess = false
            }
        } catch let error as ExportService.ExportError {
            exportError = ExportError(from: error)
            provideFeedback(.error)
        } catch {
            exportError = .unknown(error.localizedDescription)
            provideFeedback(.error)
        }

        isExporting = false
    }

    /// Provides haptic feedback
    @MainActor
    private func provideFeedback(_ type: FeedbackType) {
        switch type {
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        case .impact:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }

    /// Resets the configuration to defaults
    func resetConfiguration() {
        selectedWeight = .regular
        selectedColor = .primary
        selectedRenderingMode = .monochrome
    }
}

// MARK: - Supporting Types
extension SymbolDetailViewModel {
    enum ExportError: LocalizedError, Identifiable {
        case renderingFailed
        case saveFailed(String)
        case unknown(String)

        var id: String {
            switch self {
            case .renderingFailed: return "rendering"
            case .saveFailed: return "save"
            case .unknown: return "unknown"
            }
        }

        var errorDescription: String? {
            switch self {
            case .renderingFailed:
                return "Failed to render the symbol"
            case .saveFailed(let message):
                return "Failed to save: \(message)"
            case .unknown(let message):
                return message
            }
        }

        init(from serviceError: ExportService.ExportError) {
            switch serviceError {
            case .renderingFailed:
                self = .renderingFailed
            case .saveFailed(let error):
                self = .saveFailed(error.localizedDescription)
            case .invalidConfiguration:
                self = .unknown("Invalid configuration")
            case .fileCreationFailed:
                self = .saveFailed("Could not create file")
            }
        }
    }

    enum FeedbackType {
        case success
        case error
        case selection
        case impact
    }
}
