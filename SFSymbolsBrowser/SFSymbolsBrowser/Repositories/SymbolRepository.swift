import Foundation
import SFSafeSymbols

/// Repository for accessing and filtering SF Symbols
@Observable
final class SymbolRepository: @unchecked Sendable {
    private(set) var allSymbols: [SymbolItem] = []
    private var symbolsByCategory: [SymbolCategory: [SymbolItem]] = [:]

    var totalCount: Int { allSymbols.count }

    init() {
        loadSymbols()
    }

    // MARK: - Symbol Loading

    private func loadSymbols() {
        // Load all symbols from SFSafeSymbols
        let symbols = SFSymbol.allSymbols.map { symbol -> SymbolItem in
            let category = SymbolCategory.categorize(symbolName: symbol.rawValue)
            return SymbolItem(symbol: symbol, category: category)
        }

        // Sort alphabetically
        allSymbols = symbols.sorted { $0.name < $1.name }

        // Build category index
        for category in SymbolCategory.allCases {
            if category == .all {
                symbolsByCategory[category] = allSymbols
            } else {
                symbolsByCategory[category] = allSymbols.filter { $0.category == category }
            }
        }
    }

    // MARK: - Filtering

    /// Returns symbols matching the search query and optional category filter
    func symbols(matching query: String, category: SymbolCategory?) -> [SymbolItem] {
        var results = symbolsForCategory(category)

        if !query.isEmpty {
            let lowercasedQuery = query.lowercased()
            results = results.filter { symbol in
                symbol.name.lowercased().contains(lowercasedQuery)
            }
        }

        return results
    }

    /// Returns all symbols in a category
    func symbolsForCategory(_ category: SymbolCategory?) -> [SymbolItem] {
        guard let category = category, category != .all else {
            return allSymbols
        }
        return symbolsByCategory[category] ?? []
    }

    /// Returns the count for a specific category
    func count(for category: SymbolCategory) -> Int {
        if category == .all {
            return allSymbols.count
        }
        return symbolsByCategory[category]?.count ?? 0
    }

    /// Finds a symbol by its name
    func symbol(named name: String) -> SymbolItem? {
        allSymbols.first { $0.name == name }
    }
}

// MARK: - SFSymbol Extension for All Symbols
extension SFSymbol {
    /// Returns all available SF Symbols
    /// This uses reflection to get all cases from the SFSafeSymbols enum
    static var allSymbols: [SFSymbol] {
        // Common symbols that are available across iOS versions
        // This is a curated subset - the full list would be much larger
        return [
            // Communication
            .message, .messageFill, .bubble, .bubbleFill,
            .phone, .phoneFill, .phoneCircle, .phoneCircleFill,
            .video, .videoFill, .videoCircle, .videoCircleFill,
            .envelope, .envelopeFill, .envelopeCircle, .envelopeCircleFill,

            // Weather
            .cloud, .cloudFill, .cloudRain, .cloudRainFill,
            .cloudSun, .cloudSunFill, .cloudMoon, .cloudMoonFill,
            .sun, .sunMax, .sunMaxFill, .moon, .moonFill,
            .snowflake, .wind, .humidity,

            // Devices
            .desktopcomputer, .laptopcomputer,
            .keyboard, .computermouse,

            // Media
            .play, .playFill, .playCircle, .playCircleFill,
            .pause, .pauseFill, .pauseCircle, .pauseCircleFill,
            .stop, .stopFill, .stopCircle, .stopCircleFill,
            .forward, .forwardFill, .backward, .backwardFill,
            .musicNote, .musicNoteList,

            // Objects & Tools
            .pencil, .pencilCircle, .pencilCircleFill,
            .scissors, .scissorsCircle,
            .doc, .docFill, .docText, .docTextFill,
            .folder, .folderFill, .folderCircle, .folderCircleFill,
            .trash, .trashFill, .trashCircle, .trashCircleFill,
            .paperclip, .paperclipCircle,
            .link, .linkCircle, .linkCircleFill,
            .lock, .lockFill, .lockCircle, .lockCircleFill,
            .lockOpen, .lockOpenFill,
            .key, .keyFill,
            .pin, .pinFill, .pinCircle, .pinCircleFill,
            .mappin, .mappinCircle, .mappinCircleFill,

            // Symbols
            .star, .starFill, .starCircle, .starCircleFill,
            .heart, .heartFill, .heartCircle, .heartCircleFill,
            .bolt, .boltFill, .boltCircle, .boltCircleFill,
            .flag, .flagFill, .flagCircle, .flagCircleFill,
            .bell, .bellFill, .bellCircle, .bellCircleFill,
            .tag, .tagFill, .tagCircle, .tagCircleFill,
            .bookmark, .bookmarkFill, .bookmarkCircle, .bookmarkCircleFill,

            // Arrows
            .arrowUp, .arrowUpCircle, .arrowUpCircleFill,
            .arrowDown, .arrowDownCircle, .arrowDownCircleFill,
            .arrowLeft, .arrowLeftCircle, .arrowLeftCircleFill,
            .arrowRight, .arrowRightCircle, .arrowRightCircleFill,
            .arrowClockwise, .arrowCounterclockwise,
            .chevronUp, .chevronUpCircle, .chevronUpCircleFill,
            .chevronDown, .chevronDownCircle, .chevronDownCircleFill,
            .chevronLeft, .chevronLeftCircle, .chevronLeftCircleFill,
            .chevronRight, .chevronRightCircle, .chevronRightCircleFill,

            // Shapes
            .circle, .circleFill,
            .square, .squareFill,
            .triangle, .triangleFill,
            .diamond, .diamondFill,
            .hexagon, .hexagonFill,
            .capsule, .capsuleFill,
            .seal, .sealFill,
            .shield, .shieldFill,

            // Human
            .person, .personFill, .personCircle, .personCircleFill,
            .person2, .person2Fill, .person2Circle, .person2CircleFill,
            .person3, .person3Fill,
            .eye, .eyeFill, .eyeCircle, .eyeCircleFill,
            .eyeSlash, .eyeSlashFill,
            .hand, .handRaised, .handRaisedFill,
            .handThumbsup, .handThumbsupFill,
            .handThumbsdown, .handThumbsdownFill,

            // Editing
            .pencilAndOutline,
            .squareAndPencil,
            .slider, .sliderHorizontal3,

            // Commerce
            .cart, .cartFill, .cartCircle, .cartCircleFill,
            .bag, .bagFill, .bagCircle, .bagCircleFill,
            .creditcard, .creditcardFill, .creditcardCircle, .creditcardCircleFill,
            .giftcard, .giftcardFill,

            // Health
            .crossCircle, .crossCircleFill,

            // Settings
            .gear, .gearCircle, .gearCircleFill,
            .gearshape, .gearshapeFill, .gearshapeCircle, .gearshapeCircleFill,

            // Navigation
            .house, .houseFill, .houseCircle, .houseCircleFill,
            .magnifyingglass, .magnifyingglassCircle, .magnifyingglassCircleFill,

            // Status
            .checkmark, .checkmarkCircle, .checkmarkCircleFill,
            .xmark, .xmarkCircle, .xmarkCircleFill,
            .exclamationmark, .exclamationmarkCircle, .exclamationmarkCircleFill,
            .exclamationmarkTriangle, .exclamationmarkTriangleFill,
            .questionmark, .questionmarkCircle, .questionmarkCircleFill,
            .info, .infoCircle, .infoCircleFill,
            .plus, .plusCircle, .plusCircleFill,
            .minus, .minusCircle, .minusCircleFill,

            // Transportation
            .car, .carFill, .carCircle, .carCircleFill,
            .bus, .busFill,
            .tram, .tramFill,
            .airplane, .airplaneCircle, .airplaneCircleFill,
            .bicycle, .bicycleCircle,

            // Connectivity
            .wifi, .wifiCircle, .wifiCircleFill,
            .antenna, .antennaRadiowavesLeftAndRight,

            // Text
            .textformat, .textformatAbc, .textformatSize,
            .bold, .italic, .underline, .strikethrough,
            .listBullet, .listNumber,
            .paragraphsign,

            // Photos
            .photo, .photoFill, .photoCircle, .photoCircleFill,
            .camera, .cameraFill, .cameraCircle, .cameraCircleFill,
            .photoOnRectangle, .photoOnRectangleFill,

            // Nature
            .leaf, .leafFill, .leafCircle, .leafCircleFill,
            .flame, .flameFill, .flameCircle, .flameCircleFill,
            .drop, .dropFill, .dropCircle, .dropCircleFill,
            .sparkle, .sparkles,

            // More common symbols
            .squareAndArrowUp, .squareAndArrowUpFill,
            .squareAndArrowDown, .squareAndArrowDownFill,
            .docOnDoc, .docOnDocFill,
            .calendar, .calendarCircle, .calendarCircleFill,
            .clock, .clockFill,
            .alarm, .alarmFill,
            .stopwatch, .stopwatchFill,
            .timer,
            .chart, .chartBar, .chartBarFill,
        ]
    }
}
