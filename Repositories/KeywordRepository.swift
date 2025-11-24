import Foundation

/// Repository for semantic keyword-to-symbol mappings
@Observable
final class KeywordRepository {
    /// Mapping of keywords to symbol names
    private var keywordToSymbols: [String: Set<String>] = [:]

    /// Reverse mapping: symbol name to associated keywords
    private var symbolToKeywords: [String: Set<String>] = [:]

    init() {
        loadKeywords()
    }

    // MARK: - Public API

    /// Get symbol names that match a semantic keyword
    func symbols(forKeyword keyword: String) -> Set<String> {
        let lowercased = keyword.lowercased().trimmingCharacters(in: .whitespaces)

        // Exact match
        if let symbols = keywordToSymbols[lowercased] {
            return symbols
        }

        // Partial match - find keywords containing the search term
        var results: Set<String> = []
        for (key, symbols) in keywordToSymbols {
            if key.contains(lowercased) || lowercased.contains(key) {
                results.formUnion(symbols)
            }
        }

        return results
    }

    /// Get keywords associated with a symbol name
    func keywords(forSymbol symbolName: String) -> Set<String> {
        symbolToKeywords[symbolName] ?? []
    }

    /// Check if a search query matches any semantic keywords
    func hasSemanticMatch(for query: String) -> Bool {
        let lowercased = query.lowercased().trimmingCharacters(in: .whitespaces)
        return keywordToSymbols.keys.contains { $0.contains(lowercased) || lowercased.contains($0) }
    }

    /// Get all available keywords
    var allKeywords: [String] {
        Array(keywordToSymbols.keys).sorted()
    }

    // MARK: - Data Loading

    private func loadKeywords() {
        // Built-in semantic keyword mappings
        // This covers common use cases and developer terminology
        let mappings: [String: [String]] = [
            // Actions
            "add": ["plus", "plus.circle", "plus.square", "plus.rectangle", "plus.app"],
            "remove": ["minus", "minus.circle", "minus.square", "trash", "xmark"],
            "delete": ["trash", "trash.fill", "trash.circle", "xmark.bin", "minus.circle"],
            "edit": ["pencil", "square.and.pencil", "pencil.circle", "highlighter"],
            "save": ["square.and.arrow.down", "arrow.down.doc", "checkmark"],
            "upload": ["arrow.up", "square.and.arrow.up", "icloud.and.arrow.up", "arrow.up.circle"],
            "download": ["arrow.down", "square.and.arrow.down", "icloud.and.arrow.down", "arrow.down.circle"],
            "share": ["square.and.arrow.up", "arrowshape.turn.up.right", "paperplane"],
            "send": ["paperplane", "paperplane.fill", "arrow.up.message"],
            "search": ["magnifyingglass", "magnifyingglass.circle", "doc.text.magnifyingglass"],
            "filter": ["line.3.horizontal.decrease", "line.3.horizontal.decrease.circle", "slider.horizontal.3"],
            "sort": ["arrow.up.arrow.down", "arrow.up.arrow.down.circle", "line.3.horizontal.decrease"],
            "refresh": ["arrow.clockwise", "arrow.triangle.2.circlepath", "arrow.counterclockwise"],
            "sync": ["arrow.triangle.2.circlepath", "arrow.2.squarepath", "icloud.and.arrow.down"],
            "close": ["xmark", "xmark.circle", "xmark.square"],
            "cancel": ["xmark", "xmark.circle", "multiply.circle"],
            "confirm": ["checkmark", "checkmark.circle", "checkmark.square"],
            "done": ["checkmark", "checkmark.circle.fill", "checkmark.seal"],
            "copy": ["doc.on.doc", "doc.on.clipboard", "clipboard"],
            "paste": ["doc.on.clipboard", "clipboard", "arrow.down.doc"],
            "cut": ["scissors", "scissors.badge.ellipsis"],
            "undo": ["arrow.uturn.backward", "arrow.uturn.left"],
            "redo": ["arrow.uturn.forward", "arrow.uturn.right"],
            "play": ["play", "play.fill", "play.circle", "play.rectangle"],
            "pause": ["pause", "pause.fill", "pause.circle"],
            "stop": ["stop", "stop.fill", "stop.circle"],
            "record": ["record.circle", "circle.fill"],
            "forward": ["forward", "forward.fill", "goforward"],
            "backward": ["backward", "backward.fill", "gobackward"],
            "skip": ["forward.end", "backward.end"],
            "mute": ["speaker.slash", "speaker.slash.fill"],
            "volume": ["speaker.wave.2", "speaker.wave.3", "speaker.plus"],
            "zoom": ["plus.magnifyingglass", "minus.magnifyingglass", "1.magnifyingglass"],
            "expand": ["arrow.up.left.and.arrow.down.right", "rectangle.expand.vertical"],
            "collapse": ["arrow.down.right.and.arrow.up.left", "rectangle.compress.vertical"],
            "lock": ["lock", "lock.fill", "lock.circle"],
            "unlock": ["lock.open", "lock.open.fill"],
            "hide": ["eye.slash", "eye.slash.fill"],
            "show": ["eye", "eye.fill"],
            "pin": ["pin", "pin.fill", "pin.circle"],
            "bookmark": ["bookmark", "bookmark.fill", "book.closed"],
            "flag": ["flag", "flag.fill", "flag.circle"],
            "star": ["star", "star.fill", "star.circle"],
            "like": ["hand.thumbsup", "hand.thumbsup.fill", "heart"],
            "dislike": ["hand.thumbsdown", "hand.thumbsdown.fill"],
            "comment": ["bubble.left", "bubble.right", "text.bubble"],
            "reply": ["arrowshape.turn.up.left", "bubble.left.and.bubble.right"],
            "forward": ["arrowshape.turn.up.right", "arrow.turn.up.forward.iphone"],

            // Objects & Concepts
            "home": ["house", "house.fill", "house.circle"],
            "settings": ["gear", "gearshape", "gearshape.fill", "slider.horizontal.3"],
            "profile": ["person", "person.fill", "person.circle", "person.crop.circle"],
            "user": ["person", "person.fill", "figure.stand"],
            "users": ["person.2", "person.3", "person.2.fill"],
            "group": ["person.3", "person.3.fill", "rectangle.3.group"],
            "team": ["person.3", "person.3.fill"],
            "message": ["message", "message.fill", "bubble.left", "envelope"],
            "email": ["envelope", "envelope.fill", "envelope.circle"],
            "mail": ["envelope", "envelope.fill", "tray"],
            "notification": ["bell", "bell.fill", "bell.badge"],
            "alert": ["exclamationmark.triangle", "exclamationmark.circle", "bell.badge"],
            "warning": ["exclamationmark.triangle", "exclamationmark.triangle.fill"],
            "error": ["xmark.circle", "xmark.octagon", "exclamationmark.circle"],
            "success": ["checkmark.circle", "checkmark.seal", "hand.thumbsup"],
            "info": ["info.circle", "info.circle.fill", "questionmark.circle"],
            "help": ["questionmark.circle", "questionmark", "book"],
            "photo": ["photo", "photo.fill", "camera", "photo.on.rectangle"],
            "image": ["photo", "photo.fill", "rectangle.on.rectangle"],
            "camera": ["camera", "camera.fill", "camera.circle"],
            "video": ["video", "video.fill", "play.rectangle"],
            "music": ["music.note", "music.note.list", "music.mic"],
            "audio": ["speaker.wave.2", "waveform", "music.note"],
            "file": ["doc", "doc.fill", "folder"],
            "document": ["doc", "doc.fill", "doc.text"],
            "folder": ["folder", "folder.fill", "folder.circle"],
            "calendar": ["calendar", "calendar.circle", "calendar.badge.plus"],
            "date": ["calendar", "clock"],
            "time": ["clock", "clock.fill", "timer"],
            "location": ["location", "location.fill", "mappin", "map"],
            "map": ["map", "map.fill", "globe"],
            "phone": ["phone", "phone.fill", "iphone"],
            "call": ["phone", "phone.fill", "phone.arrow.up.right"],
            "wifi": ["wifi", "wifi.circle"],
            "bluetooth": ["wave.3.right", "dot.radiowaves.left.and.right"],
            "battery": ["battery.100", "battery.75", "battery.50", "battery.25"],
            "power": ["power", "bolt", "bolt.fill"],
            "money": ["dollarsign", "dollarsign.circle", "creditcard", "banknote"],
            "payment": ["creditcard", "creditcard.fill", "dollarsign.circle"],
            "cart": ["cart", "cart.fill", "bag"],
            "bag": ["bag", "bag.fill", "handbag"],
            "shop": ["cart", "bag", "storefront"],
            "store": ["storefront", "building.2", "bag"],
            "heart": ["heart", "heart.fill", "heart.circle"],
            "love": ["heart", "heart.fill", "suit.heart"],
            "favorite": ["heart", "heart.fill", "star", "star.fill"],

            // UI Elements
            "menu": ["line.3.horizontal", "list.bullet", "sidebar.left"],
            "list": ["list.bullet", "list.dash", "list.number"],
            "grid": ["square.grid.2x2", "square.grid.3x3", "rectangle.grid.2x2"],
            "table": ["tablecells", "rectangle.split.3x3"],
            "tab": ["rectangle.stack", "square.stack"],
            "sidebar": ["sidebar.left", "sidebar.right"],
            "panel": ["rectangle.portrait", "rectangle"],
            "window": ["macwindow", "rectangle.on.rectangle"],
            "modal": ["rectangle.portrait.on.rectangle.portrait"],
            "popup": ["rectangle.bottomhalf.filled"],
            "button": ["capsule", "rectangle.fill"],
            "toggle": ["switch.2", "togglepower"],
            "slider": ["slider.horizontal.3", "slider.vertical.3"],
            "checkbox": ["checkmark.square", "square"],
            "radio": ["circle", "circle.fill"],
            "dropdown": ["chevron.down", "arrowtriangle.down"],
            "arrow": ["arrow.right", "arrow.left", "arrow.up", "arrow.down"],
            "chevron": ["chevron.right", "chevron.left", "chevron.up", "chevron.down"],
            "back": ["chevron.left", "arrow.left", "arrowshape.turn.up.backward"],
            "next": ["chevron.right", "arrow.right", "arrowshape.turn.up.forward"],

            // Technical
            "code": ["chevron.left.forwardslash.chevron.right", "terminal", "curlybraces"],
            "terminal": ["terminal", "apple.terminal"],
            "database": ["cylinder", "cylinder.fill", "externaldrive"],
            "server": ["server.rack", "xserve"],
            "cloud": ["cloud", "cloud.fill", "icloud"],
            "network": ["network", "globe", "antenna.radiowaves.left.and.right"],
            "link": ["link", "link.circle", "paperclip"],
            "api": ["chevron.left.forwardslash.chevron.right", "arrow.left.arrow.right"],
            "debug": ["ant", "ladybug", "hammer"],
            "build": ["hammer", "hammer.fill", "wrench.and.screwdriver"],
            "test": ["checkmark.shield", "testtube.2"],
            "key": ["key", "key.fill"],
            "security": ["lock.shield", "shield", "checkmark.shield"],
            "privacy": ["hand.raised", "eye.slash", "lock.shield"],
            "encrypt": ["lock", "key", "lock.shield"],

            // Status & States
            "loading": ["arrow.triangle.2.circlepath", "circle.dotted"],
            "progress": ["chart.bar", "gauge", "circle.dotted"],
            "complete": ["checkmark.circle.fill", "checkmark.seal.fill"],
            "pending": ["clock", "hourglass"],
            "active": ["circle.fill", "checkmark.circle"],
            "inactive": ["circle", "xmark.circle"],
            "online": ["circle.fill", "checkmark.circle.fill"],
            "offline": ["circle", "wifi.slash"],
            "new": ["sparkles", "star.fill", "burst"],
            "hot": ["flame", "flame.fill"],
            "trending": ["chart.line.uptrend.xyaxis", "arrow.up.right"],
            "popular": ["star.fill", "hand.thumbsup.fill"]
        ]

        // Populate the forward mapping
        for (keyword, symbols) in mappings {
            keywordToSymbols[keyword] = Set(symbols)
        }

        // Build reverse mapping
        for (keyword, symbols) in mappings {
            for symbol in symbols {
                if symbolToKeywords[symbol] == nil {
                    symbolToKeywords[symbol] = []
                }
                symbolToKeywords[symbol]?.insert(keyword)
            }
        }
    }
}

// MARK: - Search Integration Extension
extension SymbolRepository {
    /// Enhanced search that includes semantic keyword matching
    func searchWithSemantics(
        query: String,
        category: SymbolCategory?,
        keywordRepository: KeywordRepository
    ) -> [SymbolItem] {
        let trimmedQuery = query.trimmingCharacters(in: .whitespaces).lowercased()

        guard !trimmedQuery.isEmpty else {
            return symbols(matching: "", category: category)
        }

        // Get results from name-based search
        var results = Set(symbols(matching: query, category: category))

        // Get additional results from semantic search
        let semanticMatches = keywordRepository.symbols(forKeyword: trimmedQuery)
        for symbolName in semanticMatches {
            if let symbol = symbol(named: symbolName) {
                // Apply category filter if needed
                if let category = category {
                    if symbol.category == category || category == .all {
                        results.insert(symbol)
                    }
                } else {
                    results.insert(symbol)
                }
            }
        }

        return Array(results).sorted { $0.name < $1.name }
    }
}
