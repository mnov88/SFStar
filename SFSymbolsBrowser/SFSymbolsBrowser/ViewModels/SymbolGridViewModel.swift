import SwiftUI

/// ViewModel for the symbol grid view
@Observable
final class SymbolGridViewModel {
    // MARK: - Properties
    var searchText: String = ""
    var selectedCategory: SymbolCategory? = nil
    var isShowingCategoryFilter: Bool = false
    var isSearchFocused: Bool = false

    private let repository: SymbolRepository

    // MARK: - Computed Properties
    var filteredSymbols: [SymbolItem] {
        repository.symbols(matching: searchText, category: selectedCategory)
    }

    var symbolCount: Int {
        filteredSymbols.count
    }

    var totalSymbolCount: Int {
        repository.totalCount
    }

    var displayTitle: String {
        if let category = selectedCategory, category != .all {
            return category.rawValue
        }
        return "SF Symbols"
    }

    var countDisplayText: String {
        if searchText.isEmpty && selectedCategory == nil {
            return "\(totalSymbolCount) symbols"
        } else {
            return "\(symbolCount) of \(totalSymbolCount)"
        }
    }

    var categoryCounts: [SymbolCategory: Int] {
        var counts: [SymbolCategory: Int] = [:]
        for category in SymbolCategory.allCases {
            counts[category] = repository.count(for: category)
        }
        return counts
    }

    /// Whether to show search suggestions (when focused and search is empty)
    var shouldShowSearchHistory: Bool {
        isSearchFocused && searchText.isEmpty
    }

    // MARK: - Initialization
    init(repository: SymbolRepository = SymbolRepository()) {
        self.repository = repository
    }

    // MARK: - Actions
    func clearSearch() {
        searchText = ""
    }

    func clearCategoryFilter() {
        selectedCategory = nil
    }

    func clearAllFilters() {
        searchText = ""
        selectedCategory = nil
    }

    func selectCategory(_ category: SymbolCategory) {
        if category == .all {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }
        isShowingCategoryFilter = false
    }

    func categoryCount(for category: SymbolCategory) -> Int {
        repository.count(for: category)
    }

    func applySearchFromHistory(_ query: String) {
        searchText = query
        isSearchFocused = false
    }
}
