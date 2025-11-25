import SwiftUI
import SFSymbols

/// View displaying user's favorite symbols and collections
struct FavoritesView: View {
    @Environment(PersistenceService.self) private var persistence
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @State private var repository = SymbolRepository.shared
    @State private var isCreatingCollection = false
    @State private var newCollectionName = ""
    @State private var selectedSymbols: Set<String> = []
    @State private var isSelectionMode = false

    private var columns: [GridItem] {
        let minSize: CGFloat = horizontalSizeClass == .regular ? 72 : 64
        let maxSize: CGFloat = horizontalSizeClass == .regular ? 96 : 80
        let spacing: CGFloat = horizontalSizeClass == .regular ? 16 : 12

        return [GridItem(.adaptive(minimum: minSize, maximum: maxSize), spacing: spacing)]
    }

    private var favoriteSymbols: [SymbolItem] {
        persistence.favoriteSymbolNames.compactMap { name in
            repository.symbol(named: name)
        }.sorted { $0.name < $1.name }
    }

    var body: some View {
        Group {
            if favoriteSymbols.isEmpty && persistence.collections.isEmpty {
                EmptyStateView.noFavorites
            } else {
                contentList
            }
        }
        .navigationTitle("Favorites")
        .navigationDestination(for: SymbolItem.self) { symbol in
            SymbolDetailView(symbol: symbol)
        }
        .navigationDestination(for: SymbolCollection.self) { collection in
            CollectionDetailView(collection: collection)
        }
        .toolbar {
            toolbarContent
        }
        .alert("New Collection", isPresented: $isCreatingCollection) {
            TextField("Collection name", text: $newCollectionName)
            Button("Cancel", role: .cancel) {
                newCollectionName = ""
            }
            Button("Create") {
                if !newCollectionName.isEmpty {
                    let _ = persistence.createCollection(name: newCollectionName)
                    newCollectionName = ""
                }
            }
        } message: {
            Text("Enter a name for your new collection.")
        }
    }

    // MARK: - Content List
    private var contentList: some View {
        List {
            // Favorites Section
            if !favoriteSymbols.isEmpty {
                Section {
                    favoritesGrid
                } header: {
                    HStack {
                        Text("Favorites")
                        Spacer()
                        Text("\(favoriteSymbols.count)")
                            .foregroundStyle(.secondary)
                    }
                }
            }

            // Collections Section
            Section {
                if persistence.collections.isEmpty {
                    Text("No collections yet")
                        .foregroundStyle(.secondary)
                        .font(.subheadline)
                } else {
                    ForEach(persistence.collections) { collection in
                        NavigationLink(value: collection) {
                            CollectionRow(collection: collection)
                        }
                    }
                    .onDelete(perform: deleteCollections)
                }

                Button {
                    isCreatingCollection = true
                } label: {
                    Label("New Collection", symbol: .plusCircle)
                }
            } header: {
                Text("Collections")
            }
        }
        .listStyle(.insetGrouped)
    }

    // MARK: - Favorites Grid
    private var favoritesGrid: some View {
        LazyVGrid(columns: columns, spacing: 12) {
            ForEach(favoriteSymbols) { symbol in
                if isSelectionMode {
                    selectableCell(for: symbol)
                } else {
                    NavigationLink(value: symbol) {
                        SymbolCellView(symbol: symbol, isFavorite: true)
                    }
                    .buttonStyle(.plain)
                    .contextMenu {
                        symbolContextMenu(for: symbol)
                    }
                }
            }
        }
        .padding(.vertical, 8)
    }

    // MARK: - Selectable Cell
    private func selectableCell(for symbol: SymbolItem) -> some View {
        Button {
            if selectedSymbols.contains(symbol.name) {
                selectedSymbols.remove(symbol.name)
            } else {
                selectedSymbols.insert(symbol.name)
            }
        } label: {
            ZStack(alignment: .topLeading) {
                SymbolCellView(symbol: symbol, isFavorite: true)

                Image(symbol: selectedSymbols.contains(symbol.name) ? .checkmarkCircleFill : .circle)
                    .foregroundStyle(selectedSymbols.contains(symbol.name) ? Color.accentColor : .secondary)
                    .background(Circle().fill(.background))
                    .padding(4)
            }
        }
        .buttonStyle(.plain)
    }

    // MARK: - Context Menu
    @ViewBuilder
    private func symbolContextMenu(for symbol: SymbolItem) -> some View {
        Button(role: .destructive) {
            persistence.toggleFavorite(symbol)
        } label: {
            Label("Remove from Favorites", systemImage: "star.slash")
        }

        if !persistence.collections.isEmpty {
            Menu {
                ForEach(persistence.collections) { collection in
                    Button {
                        persistence.addToCollection(symbol, collection: collection)
                    } label: {
                        Label(collection.name, systemImage: "folder")
                    }
                }
            } label: {
                Label("Add to Collection", systemImage: "folder.badge.plus")
            }
        }
    }

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        if isSelectionMode {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    isSelectionMode = false
                    selectedSymbols.removeAll()
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Menu {
                    if !persistence.collections.isEmpty {
                        Menu {
                            ForEach(persistence.collections) { collection in
                                Button(collection.name) {
                                    addSelectedToCollection(collection)
                                }
                            }
                        } label: {
                            Label("Add to Collection", systemImage: "folder.badge.plus")
                        }
                    }

                    Button(role: .destructive) {
                        removeSelectedFromFavorites()
                    } label: {
                        Label("Remove Selected", systemImage: "star.slash")
                    }
                } label: {
                    Text("\(selectedSymbols.count) selected")
                }
                .disabled(selectedSymbols.isEmpty)
            }
        } else {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    if !favoriteSymbols.isEmpty {
                        Button {
                            isSelectionMode = true
                        } label: {
                            Label("Select Multiple", systemImage: "checkmark.circle")
                        }
                    }

                    Button {
                        isCreatingCollection = true
                    } label: {
                        Label("New Collection", systemImage: "folder.badge.plus")
                    }
                } label: {
                    Image(symbol: .ellipsisCircle)
                }
            }
        }
    }

    // MARK: - Actions
    private func deleteCollections(at offsets: IndexSet) {
        for index in offsets {
            persistence.deleteCollection(persistence.collections[index])
        }
    }

    private func addSelectedToCollection(_ collection: SymbolCollection) {
        for name in selectedSymbols {
            if let symbol = repository.symbol(named: name) {
                persistence.addToCollection(symbol, collection: collection)
            }
        }
        isSelectionMode = false
        selectedSymbols.removeAll()
    }

    private func removeSelectedFromFavorites() {
        for name in selectedSymbols {
            if let symbol = repository.symbol(named: name) {
                persistence.toggleFavorite(symbol)
            }
        }
        isSelectionMode = false
        selectedSymbols.removeAll()
    }
}

// MARK: - Collection Row
struct CollectionRow: View {
    let collection: SymbolCollection

    var body: some View {
        HStack {
            Image(symbol: .folder)
                .foregroundStyle(Color.accentColor)

            VStack(alignment: .leading, spacing: 2) {
                Text(collection.name)

                Text("\(collection.symbolNames.count) symbols")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview("With Favorites") {
    let service = PersistenceService()
    service.favoriteSymbolNames = ["heart", "star", "gear"]
    let _ = service.createCollection(name: "My Icons")

    return NavigationStack {
        FavoritesView()
    }
    .environment(service)
}

#Preview("Empty") {
    NavigationStack {
        FavoritesView()
    }
    .environment(PersistenceService())
}
