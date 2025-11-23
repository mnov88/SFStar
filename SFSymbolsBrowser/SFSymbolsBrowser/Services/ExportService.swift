import SwiftUI
import UIKit

/// Service for exporting symbols as images
actor ExportService {
    // MARK: - Errors
    enum ExportError: LocalizedError {
        case renderingFailed
        case saveFailed(underlying: Error)
        case invalidConfiguration
        case fileCreationFailed

        var errorDescription: String? {
            switch self {
            case .renderingFailed:
                return "Failed to render the symbol image"
            case .saveFailed(let error):
                return "Failed to save file: \(error.localizedDescription)"
            case .invalidConfiguration:
                return "Invalid export configuration"
            case .fileCreationFailed:
                return "Failed to create the export file"
            }
        }
    }

    // MARK: - Properties
    private let fileManager = FileManager.default

    // MARK: - Export Methods

    /// Exports a single symbol as PNG
    func exportPNG(
        symbolName: String,
        weight: Font.Weight,
        color: Color,
        renderingMode: SymbolRenderingMode,
        scale: ExportScale,
        baseSize: CGFloat = 64
    ) async throws -> ExportResult {
        let pixelSize = CGFloat(scale.pixelSize(for: baseSize))

        guard let image = await renderSymbol(
            name: symbolName,
            weight: weight,
            color: color,
            renderingMode: renderingMode,
            size: pixelSize
        ) else {
            throw ExportError.renderingFailed
        }

        guard let pngData = image.pngData() else {
            throw ExportError.renderingFailed
        }

        let sanitizedName = symbolName.replacingOccurrences(of: ".", with: "-")
        let fileName = "\(sanitizedName)\(scale.label)"
        let fileURL = try saveToDocuments(data: pngData, fileName: fileName, extension: "png")

        return ExportResult(
            fileName: sanitizedName,
            fileURL: fileURL,
            scale: scale,
            format: .png
        )
    }

    /// Exports a symbol at multiple scales
    func exportMultiScale(
        symbolName: String,
        weight: Font.Weight,
        color: Color,
        renderingMode: SymbolRenderingMode,
        scales: Set<ExportScale>,
        baseSize: CGFloat = 64
    ) async throws -> [ExportResult] {
        var results: [ExportResult] = []

        for scale in scales.sorted() {
            let result = try await exportPNG(
                symbolName: symbolName,
                weight: weight,
                color: color,
                renderingMode: renderingMode,
                scale: scale,
                baseSize: baseSize
            )
            results.append(result)
        }

        return results
    }

    // MARK: - Rendering

    @MainActor
    private func renderSymbol(
        name: String,
        weight: Font.Weight,
        color: Color,
        renderingMode: SymbolRenderingMode,
        size: CGFloat
    ) -> UIImage? {
        let uiWeight = weight.toUIFontWeight()
        let configuration = UIImage.SymbolConfiguration(
            pointSize: size * 0.6,  // Symbol is ~60% of container
            weight: uiWeight
        )

        guard let symbolImage = UIImage(systemName: name, withConfiguration: configuration) else {
            return nil
        }

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: size, height: size))

        return renderer.image { context in
            // Clear background (transparent)
            UIColor.clear.setFill()
            context.fill(CGRect(origin: .zero, size: CGSize(width: size, height: size)))

            // Apply color
            let uiColor = UIColor(color)
            let coloredImage = symbolImage.withTintColor(uiColor, renderingMode: .alwaysOriginal)

            // Center the symbol
            let symbolSize = coloredImage.size
            let x = (size - symbolSize.width) / 2
            let y = (size - symbolSize.height) / 2

            coloredImage.draw(at: CGPoint(x: x, y: y))
        }
    }

    // MARK: - File Operations

    private func saveToDocuments(data: Data, fileName: String, extension ext: String) throws -> URL {
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let exportFolder = documentsURL.appendingPathComponent("SF Symbols Export", isDirectory: true)

        // Create export folder if needed
        if !fileManager.fileExists(atPath: exportFolder.path) {
            try fileManager.createDirectory(at: exportFolder, withIntermediateDirectories: true)
        }

        let fileURL = exportFolder.appendingPathComponent("\(fileName).\(ext)")

        // Remove existing file if present
        if fileManager.fileExists(atPath: fileURL.path) {
            try fileManager.removeItem(at: fileURL)
        }

        do {
            try data.write(to: fileURL)
            return fileURL
        } catch {
            throw ExportError.saveFailed(underlying: error)
        }
    }

    /// Returns the URL of the export folder
    func exportFolderURL() -> URL {
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documentsURL.appendingPathComponent("SF Symbols Export", isDirectory: true)
    }
}

// MARK: - Font.Weight to UIFont.Weight
extension Font.Weight {
    func toUIFontWeight() -> UIFont.Weight {
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
