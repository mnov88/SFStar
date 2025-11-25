import Foundation
import SFSymbols

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
        // Load all symbols from SFSymbols
        let symbols = SFSymbol.allSymbols.map { symbol -> SymbolItem in
            let category = SymbolCategory.categorize(symbolName: symbol.title)
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
