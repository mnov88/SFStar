import XCTest
@testable import SFSymbolsBrowser

final class SymbolRepositoryTests: XCTestCase {
    var sut: SymbolRepository!

    override func setUp() {
        super.setUp()
        sut = SymbolRepository()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // MARK: - Loading Tests

    func test_init_loadsSymbols() {
        // Given/When - Repository initialized in setUp

        // Then
        XCTAssertGreaterThan(sut.allSymbols.count, 0, "Should load symbols")
        XCTAssertEqual(sut.totalCount, sut.allSymbols.count, "Total count should match")
    }

    func test_allSymbols_areSortedAlphabetically() {
        // Given
        let symbols = sut.allSymbols

        // When
        let sortedNames = symbols.map { $0.name }.sorted()
        let actualNames = symbols.map { $0.name }

        // Then
        XCTAssertEqual(actualNames, sortedNames, "Symbols should be sorted alphabetically")
    }

    // MARK: - Search Tests

    func test_symbols_withEmptyQuery_returnsAll() {
        // Given
        let query = ""

        // When
        let results = sut.symbols(matching: query, category: nil)

        // Then
        XCTAssertEqual(results.count, sut.allSymbols.count, "Empty query should return all symbols")
    }

    func test_symbols_withQuery_filtersCorrectly() {
        // Given
        let query = "heart"

        // When
        let results = sut.symbols(matching: query, category: nil)

        // Then
        XCTAssertGreaterThan(results.count, 0, "Should find heart symbols")
        XCTAssertTrue(results.allSatisfy { $0.name.lowercased().contains("heart") },
                     "All results should contain 'heart'")
    }

    func test_symbols_withQuery_isCaseInsensitive() {
        // Given
        let lowercaseResults = sut.symbols(matching: "heart", category: nil)
        let uppercaseResults = sut.symbols(matching: "HEART", category: nil)
        let mixedResults = sut.symbols(matching: "HeArT", category: nil)

        // Then
        XCTAssertEqual(lowercaseResults.count, uppercaseResults.count,
                      "Search should be case insensitive")
        XCTAssertEqual(lowercaseResults.count, mixedResults.count,
                      "Search should be case insensitive")
    }

    func test_symbols_withNonExistentQuery_returnsEmpty() {
        // Given
        let query = "xyznonexistent123"

        // When
        let results = sut.symbols(matching: query, category: nil)

        // Then
        XCTAssertTrue(results.isEmpty, "Should return empty for non-existent query")
    }

    // MARK: - Category Tests

    func test_symbolsForCategory_all_returnsAllSymbols() {
        // When
        let results = sut.symbolsForCategory(.all)

        // Then
        XCTAssertEqual(results.count, sut.allSymbols.count, "All category should return all symbols")
    }

    func test_symbolsForCategory_nil_returnsAllSymbols() {
        // When
        let results = sut.symbolsForCategory(nil)

        // Then
        XCTAssertEqual(results.count, sut.allSymbols.count, "Nil category should return all symbols")
    }

    func test_count_forAllCategory_matchesTotalCount() {
        // When
        let count = sut.count(for: .all)

        // Then
        XCTAssertEqual(count, sut.totalCount, "Count for .all should match total count")
    }

    // MARK: - Symbol Lookup Tests

    func test_symbolNamed_existingSymbol_returnsSymbol() {
        // Given - Get a known symbol name
        guard let firstSymbol = sut.allSymbols.first else {
            XCTFail("Should have at least one symbol")
            return
        }

        // When
        let result = sut.symbol(named: firstSymbol.name)

        // Then
        XCTAssertNotNil(result, "Should find existing symbol")
        XCTAssertEqual(result?.name, firstSymbol.name, "Should return correct symbol")
    }

    func test_symbolNamed_nonExistentSymbol_returnsNil() {
        // Given
        let name = "nonexistent.symbol.name"

        // When
        let result = sut.symbol(named: name)

        // Then
        XCTAssertNil(result, "Should return nil for non-existent symbol")
    }

    // MARK: - Combined Search Tests

    func test_symbols_withQueryAndCategory_appliesBothFilters() {
        // Given
        let query = "fill"
        let category = SymbolCategory.health

        // When
        let resultsWithBoth = sut.symbols(matching: query, category: category)
        let resultsQueryOnly = sut.symbols(matching: query, category: nil)
        let resultsCategoryOnly = sut.symbols(matching: "", category: category)

        // Then
        XCTAssertLessThanOrEqual(resultsWithBoth.count, resultsQueryOnly.count,
                                 "Combined filter should be more restrictive")
        XCTAssertLessThanOrEqual(resultsWithBoth.count, resultsCategoryOnly.count,
                                 "Combined filter should be more restrictive")
    }
}
