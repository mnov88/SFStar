import SwiftUI

/// App-wide settings persisted in UserDefaults
struct AppSettings: Codable, Equatable, Sendable {
    var defaultExportFormat: ExportFormat = .png
    var defaultScales: Set<ExportScale> = [.x2]
    var defaultWeight: Font.Weight = .regular
    var targetIOSVersion: Double = 17.0
    var showCompatibilityBadge: Bool = true
    var gridColumns: Int = 0  // 0 = auto
    var symbolSize: SymbolSize = .medium

    static let `default` = AppSettings()

    // MARK: - Codable
    enum CodingKeys: String, CodingKey {
        case defaultExportFormat
        case defaultScales
        case defaultWeight
        case targetIOSVersion
        case showCompatibilityBadge
        case gridColumns
        case symbolSize
    }

    init() {}

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if let formatString = try container.decodeIfPresent(String.self, forKey: .defaultExportFormat) {
            defaultExportFormat = ExportFormat(rawValue: formatString) ?? .png
        }

        if let scaleInts = try container.decodeIfPresent([Int].self, forKey: .defaultScales) {
            defaultScales = Set(scaleInts.compactMap { ExportScale(rawValue: $0) })
        }

        if let weightValue = try container.decodeIfPresent(Int.self, forKey: .defaultWeight) {
            defaultWeight = Font.Weight.from(intValue: weightValue)
        }

        targetIOSVersion = try container.decodeIfPresent(Double.self, forKey: .targetIOSVersion) ?? 17.0
        showCompatibilityBadge = try container.decodeIfPresent(Bool.self, forKey: .showCompatibilityBadge) ?? true
        gridColumns = try container.decodeIfPresent(Int.self, forKey: .gridColumns) ?? 0

        if let sizeString = try container.decodeIfPresent(String.self, forKey: .symbolSize) {
            symbolSize = SymbolSize(rawValue: sizeString) ?? .medium
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(defaultExportFormat.rawValue, forKey: .defaultExportFormat)
        try container.encode(defaultScales.map { $0.rawValue }, forKey: .defaultScales)
        try container.encode(defaultWeight.intValue, forKey: .defaultWeight)
        try container.encode(targetIOSVersion, forKey: .targetIOSVersion)
        try container.encode(showCompatibilityBadge, forKey: .showCompatibilityBadge)
        try container.encode(gridColumns, forKey: .gridColumns)
        try container.encode(symbolSize.rawValue, forKey: .symbolSize)
    }
}

// MARK: - Symbol Size
enum SymbolSize: String, CaseIterable, Identifiable, Codable, Sendable {
    case small = "Small"
    case medium = "Medium"
    case large = "Large"

    var id: String { rawValue }

    var pointSize: CGFloat {
        switch self {
        case .small: return 24
        case .medium: return 32
        case .large: return 40
        }
    }

    var cellSize: CGFloat {
        switch self {
        case .small: return 56
        case .medium: return 64
        case .large: return 80
        }
    }
}

// MARK: - Font.Weight Codable Support
extension Font.Weight {
    var intValue: Int {
        switch self {
        case .ultraLight: return 100
        case .thin: return 200
        case .light: return 300
        case .regular: return 400
        case .medium: return 500
        case .semibold: return 600
        case .bold: return 700
        case .heavy: return 800
        case .black: return 900
        default: return 400
        }
    }

    static func from(intValue: Int) -> Font.Weight {
        switch intValue {
        case 100: return .ultraLight
        case 200: return .thin
        case 300: return .light
        case 400: return .regular
        case 500: return .medium
        case 600: return .semibold
        case 700: return .bold
        case 800: return .heavy
        case 900: return .black
        default: return .regular
        }
    }
}
