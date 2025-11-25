import SwiftUI

/// Custom domain model for symbol rendering modes
enum RenderingMode: String, CaseIterable, Identifiable, Hashable, Sendable {
    case monochrome
    case hierarchical
    case palette
    case multicolor
    
    var id: String { rawValue }
    
    var displayName: String {
        switch self {
        case .monochrome: return "Mono"
        case .hierarchical: return "Hierarchical"
        case .palette: return "Palette"
        case .multicolor: return "Multicolor"
        }
    }
    
    var description: String {
        switch self {
        case .monochrome: return "Single color"
        case .hierarchical: return "Depth via opacity"
        case .palette: return "Up to 3 colors"
        case .multicolor: return "Original colors"
        }
    }
    
    /// Convert to SwiftUI's SymbolRenderingMode only when needed for view modifiers
    var swiftUIMode: SymbolRenderingMode {
        switch self {
        case .monochrome: return .monochrome
        case .hierarchical: return .hierarchical
        case .palette: return .palette
        case .multicolor: return .multicolor
        }
    }
}

