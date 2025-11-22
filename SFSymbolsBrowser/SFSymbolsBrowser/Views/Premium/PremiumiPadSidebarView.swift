import SwiftUI
import SFSafeSymbols

/// Premium iPad sidebar navigation with enhanced animations
struct PremiumiPadSidebarView: View {
    @Environment(PersistenceService.self) private var persistence
    @State private var selectedSection: PremiumSidebarSection? = .search
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    enum PremiumSidebarSection: Hashable {
        case search
        case favorites
        case collection(UUID)
        case settings
    }

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            sidebarContent
                .navigationTitle("SF Symbols")
        } detail: {
            detailContent
        }
        .navigationSplitViewStyle(.balanced)
    }

    // MARK: - Sidebar Content
    private var sidebarContent: some View {
        List(selection: $selectedSection) {
            // Browse Section
            Section("Browse") {
                NavigationLink(value: PremiumSidebarSection.search) {
                    Label {
                        Text("All Symbols")
                    } icon: {
                        Image(systemSymbol: .magnifyingglass)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: DesignSystem.Gradient.ocean,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                }
            }

            // Favorites Section
            Section("Library") {
                NavigationLink(value: PremiumSidebarSection.favorites) {
                    Label {
                        HStack {
                            Text("Favorites")
                            Spacer()
                            if persistence.favoriteSymbolNames.count > 0 {
                                Text("\(persistence.favoriteSymbolNames.count)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(Capsule().fill(.quaternary))
                            }
                        }
                    } icon: {
                        Image(systemSymbol: .heart)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.pink, .red],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                    }
                }

                // Collections
                ForEach(persistence.collections) { collection in
                    NavigationLink(value: PremiumSidebarSection.collection(collection.id)) {
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
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                    }
                }
                .onDelete(perform: deleteCollections)
            }

            // Settings Section
            Section {
                NavigationLink(value: PremiumSidebarSection.settings) {
                    Label {
                        Text("Settings")
                    } icon: {
                        Image(systemSymbol: .gearshape)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .listStyle(.sidebar)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    createNewCollection()
                } label: {
                    Image(systemSymbol: .folderBadgePlus)
                }
            }
        }
    }

    // MARK: - Detail Content
    @ViewBuilder
    private var detailContent: some View {
        switch selectedSection {
        case .search, .none:
            NavigationStack {
                PremiumSymbolGridView()
            }

        case .favorites:
            NavigationStack {
                PremiumFavoritesView()
            }

        case .collection(let id):
            if let collection = persistence.collections.first(where: { $0.id == id }) {
                NavigationStack {
                    PremiumCollectionDetailView(collection: collection)
                }
            } else {
                emptyCollectionView
            }

        case .settings:
            NavigationStack {
                PremiumSettingsView()
            }
        }
    }

    private var emptyCollectionView: some View {
        ContentUnavailableView(
            "Select a Collection",
            systemImage: "folder",
            description: Text("Choose a collection from the sidebar")
        )
    }

    // MARK: - Actions
    private func deleteCollections(at offsets: IndexSet) {
        for index in offsets {
            persistence.deleteCollection(persistence.collections[index])
        }
        HapticManager.shared.warning()
    }

    @State private var isCreatingCollection = false
    @State private var newCollectionName = ""

    private func createNewCollection() {
        // For simplicity, create with default name
        let name = "New Collection \(persistence.collections.count + 1)"
        let _ = persistence.createCollection(name: name)
        HapticManager.shared.success()
    }
}

#Preview {
    PremiumiPadSidebarView()
        .environment(PersistenceService())
}
