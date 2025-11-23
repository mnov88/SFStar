import Foundation
import SwiftUI

/// Service for persisting user data including favorites, collections, and settings
@Observable
final class PersistenceService: @unchecked Sendable {
    // MARK: - Storage Keys
    private enum StorageKey {
        static let favorites = "favorites"
        static let collections = "collections"
        static let settings = "settings"
        static let searchHistory = "searchHistory"
    }

    // MARK: - Constants
    private static let maxSearchHistoryCount = 10

    // MARK: - Properties
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    var favoriteSymbolNames: Set<String> {
        didSet {
            saveFavorites()
        }
    }

    var collections: [SymbolCollection] {
        didSet {
            saveCollections()
        }
    }

    var settings: AppSettings {
        didSet {
            saveSettings()
        }
    }

    var searchHistory: [String] {
        didSet {
            saveSearchHistory()
        }
    }

    // MARK: - Initialization
    init() {
        favoriteSymbolNames = Self.loadFavorites(from: UserDefaults.standard)
        collections = Self.loadCollections(from: UserDefaults.standard, decoder: JSONDecoder())
        settings = Self.loadSettings(from: UserDefaults.standard, decoder: JSONDecoder())
        searchHistory = Self.loadSearchHistory(from: UserDefaults.standard)
    }

    // MARK: - Favorites
    func toggleFavorite(_ symbol: SymbolItem) {
        if favoriteSymbolNames.contains(symbol.name) {
            favoriteSymbolNames.remove(symbol.name)
        } else {
            favoriteSymbolNames.insert(symbol.name)
        }
    }

    func isFavorite(_ symbol: SymbolItem) -> Bool {
        favoriteSymbolNames.contains(symbol.name)
    }

    func isFavorite(named name: String) -> Bool {
        favoriteSymbolNames.contains(name)
    }

    private func saveFavorites() {
        defaults.set(Array(favoriteSymbolNames), forKey: StorageKey.favorites)
    }

    private static func loadFavorites(from defaults: UserDefaults) -> Set<String> {
        guard let array = defaults.array(forKey: StorageKey.favorites) as? [String] else {
            return []
        }
        return Set(array)
    }

    // MARK: - Collections
    func createCollection(name: String) -> SymbolCollection {
        let collection = SymbolCollection(name: name)
        collections.append(collection)
        return collection
    }

    func deleteCollection(_ collection: SymbolCollection) {
        collections.removeAll { $0.id == collection.id }
    }

    func renameCollection(_ collection: SymbolCollection, to newName: String) {
        guard let index = collections.firstIndex(where: { $0.id == collection.id }) else {
            return
        }
        collections[index].name = newName
    }

    func addToCollection(_ symbol: SymbolItem, collection: SymbolCollection) {
        guard let index = collections.firstIndex(where: { $0.id == collection.id }) else {
            return
        }
        if !collections[index].symbolNames.contains(symbol.name) {
            collections[index].symbolNames.append(symbol.name)
        }
    }

    func removeFromCollection(_ symbol: SymbolItem, collection: SymbolCollection) {
        guard let index = collections.firstIndex(where: { $0.id == collection.id }) else {
            return
        }
        collections[index].symbolNames.removeAll { $0 == symbol.name }
    }

    private func saveCollections() {
        guard let data = try? encoder.encode(collections) else { return }
        defaults.set(data, forKey: StorageKey.collections)
    }

    private static func loadCollections(from defaults: UserDefaults, decoder: JSONDecoder) -> [SymbolCollection] {
        guard let data = defaults.data(forKey: StorageKey.collections),
              let collections = try? decoder.decode([SymbolCollection].self, from: data) else {
            return []
        }
        return collections
    }

    // MARK: - Settings
    private func saveSettings() {
        guard let data = try? encoder.encode(settings) else { return }
        defaults.set(data, forKey: StorageKey.settings)
    }

    private static func loadSettings(from defaults: UserDefaults, decoder: JSONDecoder) -> AppSettings {
        guard let data = defaults.data(forKey: StorageKey.settings),
              let settings = try? decoder.decode(AppSettings.self, from: data) else {
            return .default
        }
        return settings
    }

    // MARK: - Search History
    func addToSearchHistory(_ query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, trimmed.count >= 2 else { return }

        // Remove if already exists (to move to front)
        searchHistory.removeAll { $0.lowercased() == trimmed.lowercased() }

        // Add to front
        searchHistory.insert(trimmed, at: 0)

        // Trim to max count
        if searchHistory.count > Self.maxSearchHistoryCount {
            searchHistory = Array(searchHistory.prefix(Self.maxSearchHistoryCount))
        }
    }

    func removeFromSearchHistory(_ query: String) {
        searchHistory.removeAll { $0 == query }
    }

    func clearSearchHistory() {
        searchHistory = []
    }

    private func saveSearchHistory() {
        defaults.set(searchHistory, forKey: StorageKey.searchHistory)
    }

    private static func loadSearchHistory(from defaults: UserDefaults) -> [String] {
        defaults.array(forKey: StorageKey.searchHistory) as? [String] ?? []
    }
}

// MARK: - Symbol Collection
struct SymbolCollection: Identifiable, Codable, Equatable, Hashable, Sendable {
    let id: UUID
    var name: String
    var symbolNames: [String]
    var createdAt: Date

    init(name: String) {
        self.id = UUID()
        self.name = name
        self.symbolNames = []
        self.createdAt = Date()
    }
}
