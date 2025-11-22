import SwiftUI
import SFSafeSymbols

/// Premium symbol grid with ambient animations and delightful interactions
struct PremiumSymbolGridView: View {
    @Environment(PersistenceService.self) private var persistence
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @State private var viewModel = SymbolGridViewModel()
    @State private var showingFilters = false
    @State private var selectedSymbol: SymbolItem?
    @State private var showAmbientBackground = true

    private var columns: [GridItem] {
        let minSize: CGFloat = horizontalSizeClass == .regular ? 88 : 76
        let maxSize: CGFloat = horizontalSizeClass == .regular ? 110 : 94
        let spacing: CGFloat = horizontalSizeClass == .regular ? 16 : 12

        return [GridItem(.adaptive(minimum: minSize, maximum: maxSize), spacing: spacing)]
    }

    var body: some View {
        ZStack {
            // Ambient animated background
            if showAmbientBackground {
                ambientBackground
            }

            // Main content
            mainContent
        }
        .navigationTitle("SF Symbols")
        .navigationBarTitleDisplayMode(.large)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search \(viewModel.filteredSymbols.count) symbols"
        )
        .toolbar {
            toolbarContent
        }
        .sheet(isPresented: $showingFilters) {
            PremiumCategoryFilterSheet(
                selectedCategory: $viewModel.selectedCategory,
                symbolCounts: viewModel.categoryCounts
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .navigationDestination(for: SymbolItem.self) { symbol in
            PremiumSymbolDetailView(symbol: symbol)
        }
        .onAppear {
            HapticManager.shared.lightTap()
        }
    }

    // MARK: - Ambient Background
    private var ambientBackground: some View {
        AnimatedMeshGradient(colors: DesignSystem.Gradient.subtle)
            .opacity(0.5)
            .ignoresSafeArea()
    }

    // MARK: - Main Content
    @ViewBuilder
    private var mainContent: some View {
        if viewModel.filteredSymbols.isEmpty {
            PremiumEmptyStateView(
                icon: .magnifyingglass,
                title: "No Symbols Found",
                message: "Try adjusting your search or filters"
            )
        } else {
            symbolGrid
        }
    }

    // MARK: - Symbol Grid
    private var symbolGrid: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: horizontalSizeClass == .regular ? 16 : 12) {
                ForEach(viewModel.filteredSymbols) { symbol in
                    NavigationLink(value: symbol) {
                        PremiumSymbolCellView(
                            symbol: symbol,
                            isFavorite: persistence.isFavorite(symbol)
                        ) {
                            withAnimation(DesignSystem.Animation.bouncy) {
                                persistence.toggleFavorite(symbol)
                            }
                        }
                    }
                    .buttonStyle(PremiumCellButtonStyle())
                    .contextMenu {
                        symbolContextMenu(for: symbol)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .padding(.bottom, 100)
        }
        .scrollIndicators(.hidden)
    }

    // MARK: - Context Menu
    @ViewBuilder
    private func symbolContextMenu(for symbol: SymbolItem) -> some View {
        Button {
            withAnimation(DesignSystem.Animation.bouncy) {
                persistence.toggleFavorite(symbol)
            }
            HapticManager.shared.success()
        } label: {
            Label(
                persistence.isFavorite(symbol) ? "Remove from Favorites" : "Add to Favorites",
                systemImage: persistence.isFavorite(symbol) ? "heart.slash" : "heart"
            )
        }

        Button {
            UIPasteboard.general.string = symbol.name
            HapticManager.shared.mediumTap()
        } label: {
            Label("Copy Name", systemImage: "doc.on.doc")
        }

        if !persistence.collections.isEmpty {
            Menu {
                ForEach(persistence.collections) { collection in
                    Button {
                        persistence.addToCollection(symbol, collection: collection)
                        HapticManager.shared.success()
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
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                showingFilters = true
                HapticManager.shared.lightTap()
            } label: {
                Image(systemSymbol: .line3HorizontalDecreaseCircle)
                    .symbolVariant(viewModel.selectedCategory != nil ? .fill : .none)
                    .symbolEffect(.bounce, value: viewModel.selectedCategory)
            }
        }

        ToolbarItem(placement: .topBarTrailing) {
            Menu {
                Toggle("Ambient Background", isOn: $showAmbientBackground)

                Divider()

                Text("\(viewModel.filteredSymbols.count) symbols")
            } label: {
                Image(systemSymbol: .ellipsisCircle)
            }
        }
    }
}

// MARK: - Premium Category Filter Sheet
struct PremiumCategoryFilterSheet: View {
    @Binding var selectedCategory: SymbolCategory?
    let symbolCounts: [SymbolCategory: Int]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))], spacing: 12) {
                    // All symbols option
                    categoryCard(
                        title: "All Symbols",
                        icon: .squareGrid2x2,
                        count: symbolCounts.values.reduce(0, +),
                        isSelected: selectedCategory == nil,
                        colors: DesignSystem.Gradient.ocean
                    ) {
                        selectedCategory = nil
                        dismiss()
                    }

                    // Category cards
                    ForEach(SymbolCategory.allCases) { category in
                        categoryCard(
                            title: category.displayName,
                            icon: category.icon,
                            count: symbolCounts[category] ?? 0,
                            isSelected: selectedCategory == category,
                            colors: gradientForCategory(category)
                        ) {
                            selectedCategory = category
                            dismiss()
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func categoryCard(
        title: String,
        icon: SFSymbol,
        count: Int,
        isSelected: Bool,
        colors: [Color],
        action: @escaping () -> Void
    ) -> some View {
        Button(action: {
            action()
            HapticManager.shared.selection()
        }) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemSymbol: icon)
                        .font(.title2)
                        .foregroundStyle(
                            LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
                        )

                    Spacer()

                    if isSelected {
                        Image(systemSymbol: .checkmarkCircleFill)
                            .foregroundStyle(.accentColor)
                    }
                }

                Spacer()

                Text(title)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)

                Text("\(count) symbols")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding()
            .frame(height: 100)
            .background(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.large, style: .continuous)
                    .fill(.background)
                    .shadow(color: isSelected ? .accentColor.opacity(0.3) : .black.opacity(0.06), radius: isSelected ? 12 : 8, y: isSelected ? 4 : 2)
            )
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.large, style: .continuous)
                    .strokeBorder(isSelected ? Color.accentColor : Color.clear, lineWidth: 2)
            )
        }
        .buttonStyle(.plain)
    }

    private func gradientForCategory(_ category: SymbolCategory) -> [Color] {
        switch category {
        case .general: return DesignSystem.Gradient.ocean
        case .communication: return [.blue, .cyan]
        case .weather: return [.orange, .yellow]
        case .objectsAndTools: return [.gray, .brown]
        case .devices: return [.purple, .indigo]
        case .gaming: return [.pink, .red]
        case .connectivity: return [.green, .mint]
        case .transportation: return [.blue, .purple]
        case .accessibility: return [.blue, .green]
        case .privacy: return [.gray, .black]
        case .human: return [.orange, .pink]
        case .home: return [.brown, .orange]
        case .fitness: return [.red, .orange]
        case .nature: return DesignSystem.Gradient.forest
        case .editing: return [.purple, .pink]
        case .textFormatting: return [.gray, .blue]
        case .media: return [.red, .pink]
        case .keyboard: return [.gray, .blue]
        case .commerce: return [.green, .mint]
        case .time: return [.orange, .red]
        case .health: return [.red, .pink]
        case .shapes: return [.purple, .blue]
        case .arrows: return [.blue, .cyan]
        case .indices: return [.gray, .black]
        case .math: return [.orange, .yellow]
        }
    }
}

// MARK: - Premium Empty State
struct PremiumEmptyStateView: View {
    let icon: SFSymbol
    let title: String
    let message: String

    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            Image(systemSymbol: icon)
                .font(.system(size: 56))
                .foregroundStyle(
                    LinearGradient(
                        colors: DesignSystem.Gradient.ocean,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .symbolEffect(.pulse, options: .repeating)

            VStack(spacing: DesignSystem.Spacing.sm) {
                Text(title)
                    .font(.title2.weight(.semibold))

                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(DesignSystem.Spacing.xl)
    }
}

#Preview {
    NavigationStack {
        PremiumSymbolGridView()
    }
    .environment(PersistenceService())
}
