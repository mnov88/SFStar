import SwiftUI

/// ViewModel for the symbol grid view
@Observable
final class SymbolGridViewModel {
    // MARK: - Properties
    var searchText: String = ""
    var selectedCategory: SymbolCategory? = nil
    var isShowingCategoryFilter: Bool = false

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
}
