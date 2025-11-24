import Foundation

/// Categories for organizing SF Symbols
enum SymbolCategory: String, CaseIterable, Identifiable, Sendable {
    case all = "All Symbols"
    case communication = "Communication"
    case weather = "Weather"
    case objectsTools = "Objects & Tools"
    case devices = "Devices"
    case connectivity = "Connectivity"
    case transportation = "Transportation"
    case nature = "Nature"
    case human = "Human"
    case gaming = "Gaming"
    case health = "Health"
    case commerce = "Commerce"
    case textFormatting = "Text Formatting"
    case media = "Media"
    case arrows = "Arrows"
    case shapes = "Shapes"

    var id: String { rawValue }

    var systemImage: String {
        switch self {
        case .all: return "square.grid.2x2"
        case .communication: return "message"
        case .weather: return "cloud.sun"
        case .objectsTools: return "wrench.and.screwdriver"
        case .devices: return "desktopcomputer"
        case .connectivity: return "wifi"
        case .transportation: return "car"
        case .nature: return "leaf"
        case .human: return "person"
        case .gaming: return "gamecontroller"
        case .health: return "heart"
        case .commerce: return "cart"
        case .textFormatting: return "textformat"
        case .media: return "play.rectangle"
        case .arrows: return "arrow.right"
        case .shapes: return "square.on.circle"
        }
    }
}

// MARK: - Category Keywords for Symbol Classification
extension SymbolCategory {
    /// Keywords used to automatically categorize symbols
    var keywords: [String] {
        switch self {
        case .all:
            return []
        case .communication:
            return ["message", "phone", "video", "mail", "envelope", "bubble", "chat", "mic", "speaker", "bell"]
        case .weather:
            return ["cloud", "sun", "moon", "wind", "snow", "rain", "bolt", "thermometer", "humidity", "tornado"]
        case .objectsTools:
            return ["wrench", "hammer", "screwdriver", "scissors", "pencil", "paintbrush", "ruler", "folder", "doc", "trash", "key", "lock", "pin", "paperclip", "link"]
        case .devices:
            return ["iphone", "ipad", "mac", "watch", "tv", "display", "keyboard", "mouse", "printer", "camera", "desktop", "laptop", "airpod", "homepod"]
        case .connectivity:
            return ["wifi", "antenna", "network", "bluetooth", "airplay", "dot.radiowaves"]
        case .transportation:
            return ["car", "bus", "tram", "train", "airplane", "bicycle", "ferry", "scooter"]
        case .nature:
            return ["leaf", "tree", "flower", "flame", "drop", "sparkle", "star", "globe", "mountain", "water"]
        case .human:
            return ["person", "figure", "hand", "eye", "ear", "nose", "mouth", "brain", "face", "body"]
        case .gaming:
            return ["gamecontroller", "arcade", "dice", "puzzle", "target"]
        case .health:
            return ["heart", "cross", "pill", "bandage", "stethoscope", "waveform", "activity"]
        case .commerce:
            return ["cart", "bag", "creditcard", "dollarsign", "giftcard", "barcode", "tag"]
        case .textFormatting:
            return ["textformat", "bold", "italic", "underline", "strikethrough", "list", "paragraph", "text", "character", "abc"]
        case .media:
            return ["play", "pause", "stop", "forward", "backward", "repeat", "shuffle", "music", "film", "photo"]
        case .arrows:
            return ["arrow", "chevron", "arrowtriangle"]
        case .shapes:
            return ["circle", "square", "rectangle", "triangle", "diamond", "hexagon", "octagon", "capsule", "seal", "shield", "star"]
        }
    }

    /// Determines the category for a symbol based on its name
    static func categorize(symbolName: String) -> SymbolCategory {
        let lowercasedName = symbolName.lowercased()

        for category in SymbolCategory.allCases where category != .all {
            for keyword in category.keywords {
                if lowercasedName.contains(keyword) {
                    return category
                }
            }
        }

        return .all
    }
}
