import SwiftUI
import UIKit

/// Configuration for exporting symbols
struct ExportConfiguration: Equatable, Sendable {
    var format: ExportFormat = .png
    var scales: Set<ExportScale> = [.x2]
    var weight: Font.Weight = .regular
    var color: Color = .primary
    var renderingMode: RenderingMode = .monochrome
    var size: CGFloat = 64

    static let `default` = ExportConfiguration()

    static func == (lhs: ExportConfiguration, rhs: ExportConfiguration) -> Bool {
        lhs.format == rhs.format &&
        lhs.scales == rhs.scales &&
        lhs.weight == rhs.weight &&
        lhs.color.isEqual(to: rhs.color) &&
        lhs.renderingMode == rhs.renderingMode &&
        lhs.size == rhs.size
    }
}

private extension Color {
    func isEqual(to other: Color) -> Bool {
        UIColor(self) == UIColor(other)
    }
}

// MARK: - Export Format
enum ExportFormat: String, CaseIterable, Identifiable, Sendable {
    case png = "PNG"
    case svg = "SVG"

    var id: String { rawValue }

    var fileExtension: String {
        switch self {
        case .png: return "png"
        case .svg: return "svg"
        }
    }

    var mimeType: String {
        switch self {
        case .png: return "image/png"
        case .svg: return "image/svg+xml"
        }
    }
}

// MARK: - Export Scale
enum ExportScale: Int, CaseIterable, Identifiable, Comparable, Sendable {
    case x1 = 1
    case x2 = 2
    case x3 = 3

    var id: Int { rawValue }

    var label: String {
        "@\(rawValue)x"
    }

    var multiplier: CGFloat {
        CGFloat(rawValue)
    }

    func pixelSize(for baseSize: CGFloat) -> Int {
        Int(baseSize * multiplier)
    }

    static func < (lhs: ExportScale, rhs: ExportScale) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

// MARK: - Export Result
struct ExportResult: Sendable {
    let fileName: String
    let fileURL: URL
    let scale: ExportScale?
    let format: ExportFormat

    var displayName: String {
        if let scale = scale {
            return "\(fileName)\(scale.label).\(format.fileExtension)"
        }
        return "\(fileName).\(format.fileExtension)"
    }
}
