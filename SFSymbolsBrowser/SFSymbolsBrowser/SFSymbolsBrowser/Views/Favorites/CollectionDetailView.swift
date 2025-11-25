import SwiftUI
import SFSymbols

/// Detail view for a single collection
struct CollectionDetailView: View {
    let collection: SymbolCollection

    @Environment(PersistenceService.self) private var persistence
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @State private var repository = SymbolRepository()
    @State private var isEditing = false
    @State private var editedName: String = ""
    @State private var showingDeleteConfirmation = false
    @State private var isExporting = false

    private var columns: [GridItem] {
        let minSize: CGFloat = horizontalSizeClass == .regular ? 72 : 64
        let maxSize: CGFloat = horizontalSizeClass == .regular ? 96 : 80
        let spacing: CGFloat = horizontalSizeClass == .regular ? 16 : 12

        return [GridItem(.adaptive(minimum: minSize, maximum: maxSize), spacing: spacing)]
    }

    private var collectionSymbols: [SymbolItem] {
        collection.symbolNames.compactMap { name in
            repository.symbol(named: name)
        }
    }

    var body: some View {
        Group {
            if collectionSymbols.isEmpty {
                emptyState
            } else {
                symbolGrid
            }
        }
        .navigationTitle(collection.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            toolbarContent
        }
        .alert("Rename Collection", isPresented: $isEditing) {
            TextField("Collection name", text: $editedName)
            Button("Cancel", role: .cancel) { }
            Button("Save") {
                if !editedName.isEmpty {
                    persistence.renameCollection(collection, to: editedName)
                }
            }
        }
        .confirmationDialog(
            "Delete Collection?",
            isPresented: $showingDeleteConfirmation,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                persistence.deleteCollection(collection)
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This will delete the collection but not the symbols themselves.")
        }
    }

    // MARK: - Symbol Grid
    private var symbolGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: horizontalSizeClass == .regular ? 16 : 12) {
                ForEach(collectionSymbols) { symbol in
                    NavigationLink(value: symbol) {
                        SymbolCellView(
                            symbol: symbol,
                            isFavorite: persistence.isFavorite(symbol)
                        )
                    }
                    .buttonStyle(.plain)
                    .contextMenu {
                        Button(role: .destructive) {
                            persistence.removeFromCollection(symbol, collection: collection)
                        } label: {
                            Label("Remove from Collection", systemImage: "minus.circle")
                        }
                    }
                }
            }
            .padding()
        }
    }

    // MARK: - Empty State
    private var emptyState: some View {
        ContentUnavailableView {
            Label("No Symbols", systemImage: "square.grid.2x2")
        } description: {
            Text("Add symbols to this collection from the symbol detail view.")
        }
    }

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Menu {
                Button {
                    editedName = collection.name
                    isEditing = true
                } label: {
                    Label("Rename", systemImage: "pencil")
                }

                if !collectionSymbols.isEmpty {
                    Button {
                        exportAll()
                    } label: {
                        Label("Export All", systemImage: "square.and.arrow.up")
                    }
                }

                Divider()

                Button(role: .destructive) {
                    showingDeleteConfirmation = true
                } label: {
                    Label("Delete Collection", systemImage: "trash")
                }
            } label: {
                Image(symbol: .ellipsisCircle)
            }
        }

        ToolbarItem(placement: .status) {
            Text("\(collectionSymbols.count) symbols")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Actions
    private func exportAll() {
        // TODO: Implement batch export in Phase 5
        isExporting = true
    }
}

#Preview {
    let service = PersistenceService()
    let collection = service.createCollection(name: "Test Collection")

    return NavigationStack {
        CollectionDetailView(collection: collection)
    }
    .environment(service)
}
