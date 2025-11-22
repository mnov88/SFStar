import SwiftUI

/// View displaying user's favorite symbols (MVP version)
struct FavoritesView: View {
    @Environment(PersistenceService.self) private var persistence
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @State private var repository = SymbolRepository()

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
            if favoriteSymbols.isEmpty {
                EmptyStateView.noFavorites
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: horizontalSizeClass == .regular ? 16 : 12) {
                        ForEach(favoriteSymbols) { symbol in
                            NavigationLink(value: symbol) {
                                SymbolCellView(symbol: symbol, isFavorite: true)
                            }
                            .buttonStyle(.plain)
                            .contextMenu {
                                Button(role: .destructive) {
                                    persistence.toggleFavorite(symbol)
                                } label: {
                                    Label("Remove from Favorites", systemImage: "star.slash")
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Favorites")
        .navigationDestination(for: SymbolItem.self) { symbol in
            SymbolDetailView(symbol: symbol)
        }
        .toolbar {
            if !favoriteSymbols.isEmpty {
                ToolbarItem(placement: .primaryAction) {
                    Text("\(favoriteSymbols.count) symbols")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
}

#Preview("With Favorites") {
    let service = PersistenceService()
    service.favoriteSymbolNames = ["heart", "star", "gear"]

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
