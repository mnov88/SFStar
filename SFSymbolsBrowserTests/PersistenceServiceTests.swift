import XCTest
@testable import SFSymbolsBrowser
import SFSafeSymbols

final class SymbolCategoryTests: XCTestCase {

    // MARK: - Categorization Tests

    func test_categorize_heartSymbol_returnsHealth() {
        // Given
        let symbolName = "heart.fill"

        // When
        let category = SymbolCategory.categorize(symbolName: symbolName)

        // Then
        XCTAssertEqual(category, .health, "Heart should be in health category")
    }

    func test_categorize_cloudSymbol_returnsWeather() {
        // Given
        let symbolName = "cloud.sun.fill"

        // When
        let category = SymbolCategory.categorize(symbolName: symbolName)

        // Then
        XCTAssertEqual(category, .weather, "Cloud should be in weather category")
    }

    func test_categorize_unknownSymbol_returnsAll() {
        // Given
        let symbolName = "xyzunknown123"

        // When
        let category = SymbolCategory.categorize(symbolName: symbolName)

        // Then
        XCTAssertEqual(category, .all, "Unknown symbol should be in .all category")
    }

    func test_categorize_isCaseInsensitive() {
        // Given
        let lowercaseResult = SymbolCategory.categorize(symbolName: "heart")
        let uppercaseResult = SymbolCategory.categorize(symbolName: "HEART")

        // Then
        XCTAssertEqual(lowercaseResult, uppercaseResult, "Categorization should be case insensitive")
    }

    // MARK: - Keywords Tests

    func test_allCategory_hasNoKeywords() {
        XCTAssertTrue(SymbolCategory.all.keywords.isEmpty, ".all should have no keywords")
    }

    func test_otherCategories_haveKeywords() {
        for category in SymbolCategory.allCases where category != .all {
            XCTAssertFalse(category.keywords.isEmpty, "\(category) should have keywords")
        }
    }

    // MARK: - System Image Tests

    func test_allCategories_haveSystemImage() {
        for category in SymbolCategory.allCases {
            XCTAssertFalse(category.systemImage.isEmpty, "\(category) should have a system image")
        }
    }
}

final class SymbolItemTests: XCTestCase {

    func test_init_setsPropertiesCorrectly() {
        // Given
        let symbol = SFSymbol.heart

        // When
        let item = SymbolItem(symbol: symbol, category: .health)

        // Then
        XCTAssertEqual(item.id, "heart", "ID should be symbol name")
        XCTAssertEqual(item.name, "heart", "Name should match raw value")
        XCTAssertEqual(item.category, .health, "Category should be set")
    }

    func test_equality_basedOnId() {
        // Given
        let item1 = SymbolItem(symbol: .heart, category: .health)
        let item2 = SymbolItem(symbol: .heart, category: .all)

        // Then
        XCTAssertEqual(item1, item2, "Items with same symbol should be equal")
    }

    func test_hashValue_basedOnId() {
        // Given
        let item1 = SymbolItem(symbol: .heart)
        let item2 = SymbolItem(symbol: .heart)

        // Then
        XCTAssertEqual(item1.hashValue, item2.hashValue, "Same symbols should have same hash")
    }
}

final class ExportConfigurationTests: XCTestCase {

    func test_defaultConfiguration_hasExpectedValues() {
        // When
        let config = ExportConfiguration.default

        // Then
        XCTAssertEqual(config.format, .png, "Default format should be PNG")
        XCTAssertEqual(config.scales, [.x2], "Default scale should be @2x")
        XCTAssertEqual(config.weight, .regular, "Default weight should be regular")
    }

    func test_exportScale_pixelSize_calculatesCorrectly() {
        // Given
        let baseSize: CGFloat = 64

        // Then
        XCTAssertEqual(ExportScale.x1.pixelSize(for: baseSize), 64, "@1x should be 64")
        XCTAssertEqual(ExportScale.x2.pixelSize(for: baseSize), 128, "@2x should be 128")
        XCTAssertEqual(ExportScale.x3.pixelSize(for: baseSize), 192, "@3x should be 192")
    }

    func test_exportScale_labels() {
        XCTAssertEqual(ExportScale.x1.label, "@1x")
        XCTAssertEqual(ExportScale.x2.label, "@2x")
        XCTAssertEqual(ExportScale.x3.label, "@3x")
    }

    func test_exportFormat_fileExtensions() {
        XCTAssertEqual(ExportFormat.png.fileExtension, "png")
        XCTAssertEqual(ExportFormat.svg.fileExtension, "svg")
    }
}

final class FontWeightExtensionTests: XCTestCase {

    func test_displayName_hasAllWeights() {
        for weight in Font.Weight.allWeights {
            XCTAssertFalse(weight.displayName.isEmpty, "\(weight) should have display name")
        }
    }

    func test_shortName_hasAllWeights() {
        for weight in Font.Weight.allWeights {
            XCTAssertFalse(weight.shortName.isEmpty, "\(weight) should have short name")
            XCTAssertLessThanOrEqual(weight.shortName.count, 2, "Short name should be 2 chars max")
        }
    }

    func test_intValue_roundTrip() {
        for weight in Font.Weight.allWeights {
            let intValue = weight.intValue
            let converted = Font.Weight.from(intValue: intValue)
            XCTAssertEqual(weight, converted, "Round-trip should preserve weight")
        }
    }
}
