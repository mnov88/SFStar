import Foundation
import SFSymbols

/// Repository for accessing and filtering SF Symbols
@Observable
@MainActor
final class SymbolRepository {
    static let shared = SymbolRepository()

    private(set) var allSymbols: [SymbolItem] = []
    private var symbolsByCategory: [SymbolCategory: [SymbolItem]] = [:]
    private var isLoaded = false
    private var isLoading = false

    private let symbolDataTask: Task<SymbolData, Never>

    var totalCount: Int { allSymbols.count }

    init(symbolDataTask: Task<SymbolData, Never> = SymbolRepository.symbolDataTask) {
        self.symbolDataTask = symbolDataTask

        // Kick off loading in the background so the main thread stays responsive
        prepareIfNeeded()
    }

    // MARK: - Symbol Loading

    private func prepareIfNeeded() {
        guard !isLoaded, !isLoading else { return }

        isLoading = true

        Task { [symbolDataTask] in
            let data = await symbolDataTask.value
            apply(data)
        }
    }

    private func apply(_ data: SymbolData) {
        guard !isLoaded else {
            isLoading = false
            return
        }

        allSymbols = data.allSymbols
        symbolsByCategory = data.symbolsByCategory
        isLoaded = true
        isLoading = false
    }

    private nonisolated static let symbolDataTask: Task<SymbolData, Never> = Task.detached(priority: .userInitiated) {
        let symbols = SFSymbol.allSymbols.map { symbol -> SymbolItem in
            let category = SymbolCategory.categorize(symbolName: symbol.title)
            return SymbolItem(symbol: symbol, category: category)
        }

        // Sort alphabetically
        let sortedSymbols = symbols.sorted { $0.name < $1.name }

        // Build category index
        var categoryIndex: [SymbolCategory: [SymbolItem]] = [:]
        for category in SymbolCategory.allCases {
            if category == .all {
                categoryIndex[category] = sortedSymbols
            } else {
                categoryIndex[category] = sortedSymbols.filter { $0.category == category }
            }
        }

        return SymbolData(allSymbols: sortedSymbols, symbolsByCategory: categoryIndex)
    }

    // MARK: - Filtering

    /// Returns symbols matching the search query and optional category filter
    func symbols(matching query: String, category: SymbolCategory?) -> [SymbolItem] {
        prepareIfNeeded()

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
        prepareIfNeeded()

        guard let category = category, category != .all else {
            return allSymbols
        }
        return symbolsByCategory[category] ?? []
    }

    /// Returns the count for a specific category
    func count(for category: SymbolCategory) -> Int {
        prepareIfNeeded()

        if category == .all {
            return allSymbols.count
        }
        return symbolsByCategory[category]?.count ?? 0
    }

    /// Finds a symbol by its name
    func symbol(named name: String) -> SymbolItem? {
        prepareIfNeeded()

        allSymbols.first { $0.name == name }
    }
}

// MARK: - Supporting Types
private struct SymbolData {
    let allSymbols: [SymbolItem]
    let symbolsByCategory: [SymbolCategory: [SymbolItem]]
}
