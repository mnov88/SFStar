import SwiftUI
import SFSafeSymbols

/// Represents a single SF Symbol with its metadata
struct SymbolItem: Identifiable, Hashable, Sendable {
    let id: String
    let name: String
    let symbol: SFSymbol
    let category: SymbolCategory

    init(symbol: SFSymbol, category: SymbolCategory = .all) {
        self.id = symbol.rawValue
        self.name = symbol.rawValue
        self.symbol = symbol
        self.category = category
    }

    // MARK: - Hashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: SymbolItem, rhs: SymbolItem) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Symbol Configuration
struct SymbolConfiguration: Sendable {
    var weight: Font.Weight = .regular
    var color: Color = .primary
    var renderingMode: SymbolRenderingMode = .monochrome

    static let `default` = SymbolConfiguration()
}

extension SymbolConfiguration: Equatable {
    static func == (lhs: SymbolConfiguration, rhs: SymbolConfiguration) -> Bool {
        lhs.weight == rhs.weight &&
        lhs.renderingMode == rhs.renderingMode
        // Note: Color comparison is intentionally omitted as Color doesn't conform to Equatable
    }
}

// MARK: - Font.Weight Extension for Display
extension Font.Weight {
    var displayName: String {
        switch self {
        case .ultraLight: return "Ultralight"
        case .thin: return "Thin"
        case .light: return "Light"
        case .regular: return "Regular"
        case .medium: return "Medium"
        case .semibold: return "Semibold"
        case .bold: return "Bold"
        case .heavy: return "Heavy"
        case .black: return "Black"
        default: return "Regular"
        }
    }

    var shortName: String {
        switch self {
        case .ultraLight: return "UL"
        case .thin: return "Th"
        case .light: return "Lt"
        case .regular: return "Rg"
        case .medium: return "Md"
        case .semibold: return "Sm"
        case .bold: return "Bd"
        case .heavy: return "Hv"
        case .black: return "Bl"
        default: return "Rg"
        }
    }

    static let allWeights: [Font.Weight] = [
        .ultraLight, .thin, .light, .regular, .medium,
        .semibold, .bold, .heavy, .black
    ]
}
