import SwiftUI
import SFSafeSymbols

/// iPad sidebar-based navigation with NavigationSplitView
struct iPadSidebarView: View {
    @State private var selectedSection: SidebarSection? = .search
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var searchPath = NavigationPath()
    @State private var favoritesPath = NavigationPath()

    @Environment(PersistenceService.self) private var persistence

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            sidebar
                .navigationTitle("SF Symbols")
        } detail: {
            detailView
        }
    }

    // MARK: - Sidebar
    private var sidebar: some View {
        List(selection: $selectedSection) {
            Section {
                Label("Search", systemSymbol: .magnifyingglass)
                    .tag(SidebarSection.search)

                Label {
                    HStack {
                        Text("Favorites")
                        Spacer()
                        if persistence.favoriteSymbolNames.count > 0 {
                            Text("\(persistence.favoriteSymbolNames.count)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                } icon: {
                    Image(systemSymbol: .star)
                }
                .tag(SidebarSection.favorites)
            }

            Section("Collections") {
                if persistence.collections.isEmpty {
                    Text("No collections")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                } else {
                    ForEach(persistence.collections) { collection in
                        Label {
                            HStack {
                                Text(collection.name)
                                Spacer()
                                Text("\(collection.symbolNames.count)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                        } icon: {
                            Image(systemSymbol: .folder)
                        }
                        .tag(SidebarSection.collection(collection.id))
                    }
                    .onDelete(perform: deleteCollections)
                }

                Button {
                    createNewCollection()
                } label: {
                    Label("New Collection", systemSymbol: .plusCircle)
                }
                .buttonStyle(.plain)
                .foregroundStyle(.accentColor)
            }

            Section {
                Label("Settings", systemSymbol: .gear)
                    .tag(SidebarSection.settings)
            }
        }
        .listStyle(.sidebar)
    }

    // MARK: - Detail View
    @ViewBuilder
    private var detailView: some View {
        switch selectedSection {
        case .search, .none:
            NavigationStack(path: $searchPath) {
                SymbolGridView()
                    .navigationDestination(for: SymbolItem.self) { symbol in
                        SymbolDetailView(symbol: symbol)
                    }
            }

        case .favorites:
            NavigationStack(path: $favoritesPath) {
                FavoritesView()
                    .navigationDestination(for: SymbolItem.self) { symbol in
                        SymbolDetailView(symbol: symbol)
                    }
            }

        case .collection(let id):
            if let collection = persistence.collections.first(where: { $0.id == id }) {
                NavigationStack {
                    CollectionDetailView(collection: collection)
                        .navigationDestination(for: SymbolItem.self) { symbol in
                            SymbolDetailView(symbol: symbol)
                        }
                }
            } else {
                ContentUnavailableView("Collection Not Found", systemImage: "folder.badge.questionmark")
            }

        case .settings:
            NavigationStack {
                SettingsView()
            }
        }
    }

    // MARK: - Actions
    private func createNewCollection() {
        let _ = persistence.createCollection(name: "New Collection")
    }

    private func deleteCollections(at offsets: IndexSet) {
        for index in offsets {
            let collection = persistence.collections[index]
            persistence.deleteCollection(collection)
        }
    }
}

// MARK: - Sidebar Section
enum SidebarSection: Hashable {
    case search
    case favorites
    case collection(UUID)
    case settings
}

#Preview {
    iPadSidebarView()
        .environment(PersistenceService())
}
