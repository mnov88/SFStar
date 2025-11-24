import SwiftUI
import SFSafeSymbols

/// Main tab-based navigation for iPhone
struct MainTabView: View {
    @State private var selectedTab: Tab = .search
    @Environment(PersistenceService.self) private var persistence

    enum Tab: String, CaseIterable {
        case search = "Search"
        case favorites = "Favorites"
        case settings = "Settings"

        var icon: SFSymbol {
            switch self {
            case .search: return .magnifyingglass
            case .favorites: return .star
            case .settings: return .gear
            }
        }

        var selectedIcon: SFSymbol {
            switch self {
            case .search: return .magnifyingglass
            case .favorites: return .starFill
            case .settings: return .gearshapeFill
            }
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // Search Tab
            NavigationStack {
                SymbolGridView()
            }
            .tabItem {
                Label {
                    Text("Search")
                } icon: {
                    Image(systemSymbol: selectedTab == .search ? Tab.search.selectedIcon : Tab.search.icon)
                }
            }
            .tag(Tab.search)

            // Favorites Tab
            NavigationStack {
                FavoritesView()
            }
            .tabItem {
                Label {
                    Text("Favorites")
                } icon: {
                    Image(systemSymbol: selectedTab == .favorites ? Tab.favorites.selectedIcon : Tab.favorites.icon)
                }
            }
            .tag(Tab.favorites)
            .badge(persistence.favoriteSymbolNames.count > 0 ? persistence.favoriteSymbolNames.count : 0)

            // Settings Tab
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label {
                    Text("Settings")
                } icon: {
                    Image(systemSymbol: selectedTab == .settings ? Tab.settings.selectedIcon : Tab.settings.icon)
                }
            }
            .tag(Tab.settings)
        }
    }
}

#Preview {
    MainTabView()
        .environment(PersistenceService())
}
