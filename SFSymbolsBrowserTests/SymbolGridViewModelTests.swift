import XCTest
@testable import SFSymbolsBrowser

final class SymbolGridViewModelTests: XCTestCase {
    var sut: SymbolGridViewModel!

    override func setUp() {
        super.setUp()
        sut = SymbolGridViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Initial State Tests

    func test_init_hasEmptySearchText() {
        XCTAssertTrue(sut.searchText.isEmpty, "Search text should be empty initially")
    }

    func test_init_hasNoSelectedCategory() {
        XCTAssertNil(sut.selectedCategory, "No category should be selected initially")
    }

    func test_init_categoryFilterSheetNotShowing() {
        XCTAssertFalse(sut.isShowingCategoryFilter, "Category filter should not be showing initially")
    }

    // MARK: - Filtered Symbols Tests

    func test_filteredSymbols_withNoFilters_returnsAll() {
        // When
        let results = sut.filteredSymbols

        // Then
        XCTAssertEqual(results.count, sut.totalSymbolCount, "Should return all symbols without filters")
    }

    func test_filteredSymbols_withSearchText_filters() {
        // Given
        sut.searchText = "heart"

        // When
        let results = sut.filteredSymbols

        // Then
        XCTAssertLessThan(results.count, sut.totalSymbolCount, "Should filter results")
        XCTAssertTrue(results.allSatisfy { $0.name.contains("heart") }, "All results should contain query")
    }

    // MARK: - Display Properties Tests

    func test_displayTitle_withNoCategory_returnsDefault() {
        // When
        let title = sut.displayTitle

        // Then
        XCTAssertEqual(title, "SF Symbols", "Should show default title")
    }

    func test_displayTitle_withCategory_returnsCategoryName() {
        // Given
        sut.selectedCategory = .health

        // When
        let title = sut.displayTitle

        // Then
        XCTAssertEqual(title, "Health", "Should show category name")
    }

    func test_countDisplayText_withNoFilters_showsTotal() {
        // When
        let text = sut.countDisplayText

        // Then
        XCTAssertTrue(text.contains("symbols"), "Should mention symbols")
        XCTAssertTrue(text.contains("\(sut.totalSymbolCount)"), "Should include count")
    }

    func test_countDisplayText_withFilters_showsFilteredOfTotal() {
        // Given
        sut.searchText = "heart"

        // When
        let text = sut.countDisplayText

        // Then
        XCTAssertTrue(text.contains("of"), "Should show 'X of Y' format")
    }

    // MARK: - Action Tests

    func test_clearSearch_emptiesSearchText() {
        // Given
        sut.searchText = "test"

        // When
        sut.clearSearch()

        // Then
        XCTAssertTrue(sut.searchText.isEmpty, "Search text should be cleared")
    }

    func test_clearCategoryFilter_removesCategory() {
        // Given
        sut.selectedCategory = .health

        // When
        sut.clearCategoryFilter()

        // Then
        XCTAssertNil(sut.selectedCategory, "Category should be cleared")
    }

    func test_clearAllFilters_clearsEverything() {
        // Given
        sut.searchText = "test"
        sut.selectedCategory = .health

        // When
        sut.clearAllFilters()

        // Then
        XCTAssertTrue(sut.searchText.isEmpty, "Search text should be cleared")
        XCTAssertNil(sut.selectedCategory, "Category should be cleared")
    }

    func test_selectCategory_setsCategory() {
        // When
        sut.selectCategory(.health)

        // Then
        XCTAssertEqual(sut.selectedCategory, .health, "Category should be set")
        XCTAssertFalse(sut.isShowingCategoryFilter, "Filter sheet should dismiss")
    }

    func test_selectCategory_all_clearsCategory() {
        // Given
        sut.selectedCategory = .health

        // When
        sut.selectCategory(.all)

        // Then
        XCTAssertNil(sut.selectedCategory, "Category should be nil for .all")
    }
}
