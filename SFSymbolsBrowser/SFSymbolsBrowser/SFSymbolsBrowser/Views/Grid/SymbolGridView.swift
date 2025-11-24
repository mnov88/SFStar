import SwiftUI
import SFSafeSymbols

/// Main grid view displaying all SF Symbols
struct SymbolGridView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(PersistenceService.self) private var persistence

    @State private var viewModel = SymbolGridViewModel()

    // Adaptive columns based on device
    private var columns: [GridItem] {
        let minSize: CGFloat = horizontalSizeClass == .regular ? 72 : 64
        let maxSize: CGFloat = horizontalSizeClass == .regular ? 96 : 80
        let spacing: CGFloat = horizontalSizeClass == .regular ? 16 : 12

        return [GridItem(.adaptive(minimum: minSize, maximum: maxSize), spacing: spacing)]
    }

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: horizontalSizeClass == .regular ? 16 : 12) {
                ForEach(viewModel.filteredSymbols) { symbol in
                    NavigationLink(value: symbol) {
                        SymbolCellView(
                            symbol: symbol,
                            isFavorite: persistence.isFavorite(symbol)
                        )
                    }
                    .buttonStyle(.plain)
                    .contextMenu {
                        symbolContextMenu(for: symbol)
                    }
                }
            }
            .padding()
        }
        .navigationTitle(viewModel.displayTitle)
        .navigationBarTitleDisplayMode(horizontalSizeClass == .regular ? .inline : .large)
        .searchable(text: $viewModel.searchText, prompt: "Search symbols")
        .onSubmit(of: .search) {
            persistence.addToSearchHistory(viewModel.searchText)
        }
        .searchSuggestions {
            if viewModel.searchText.isEmpty && !persistence.searchHistory.isEmpty {
                ForEach(persistence.searchHistory, id: \.self) { query in
                    Label(query, systemImage: "clock")
                        .searchCompletion(query)
                }
            }
        }
        .navigationDestination(for: SymbolItem.self) { symbol in
            SymbolDetailView(symbol: symbol)
        }
        .toolbar {
            toolbarContent
        }
        .sheet(isPresented: $viewModel.isShowingCategoryFilter) {
            CategoryFilterView(
                selectedCategory: $viewModel.selectedCategory,
                viewModel: viewModel
            )
            .presentationDetents([.medium, .large])
        }
        .overlay(alignment: .bottom) {
            if !viewModel.searchText.isEmpty || viewModel.selectedCategory != nil {
                filterStatusBar
            }
        }
    }

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                viewModel.isShowingCategoryFilter = true
            } label: {
                Label("Filter", systemImage: viewModel.selectedCategory != nil ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")
            }
        }
    }

    // MARK: - Context Menu
    @ViewBuilder
    private func symbolContextMenu(for symbol: SymbolItem) -> some View {
        Button {
            UIPasteboard.general.string = symbol.name
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        } label: {
            Label("Copy Name", systemImage: "doc.on.doc")
        }

        Button {
            ShareService.shareSymbolName(symbol.name)
        } label: {
            Label("Share", systemImage: "square.and.arrow.up")
        }

        Button {
            persistence.toggleFavorite(symbol)
        } label: {
            if persistence.isFavorite(symbol) {
                Label("Remove from Favorites", systemImage: "star.slash")
            } else {
                Label("Add to Favorites", systemImage: "star")
            }
        }
    }

    // MARK: - Filter Status Bar
    private var filterStatusBar: some View {
        HStack {
            Text(viewModel.countDisplayText)
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()

            if viewModel.selectedCategory != nil || !viewModel.searchText.isEmpty {
                Button("Clear") {
                    viewModel.clearAllFilters()
                }
                .font(.caption)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    NavigationStack {
        SymbolGridView()
    }
    .environment(PersistenceService())
}
