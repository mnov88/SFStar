import SwiftUI
import SFSafeSymbols

/// Premium tab view with delightful animations
struct PremiumMainTabView: View {
    @Environment(PersistenceService.self) private var persistence
    @State private var selectedTab: PremiumTab = .search
    @State private var previousTab: PremiumTab = .search

    enum PremiumTab: String, CaseIterable {
        case search
        case favorites
        case settings

        var title: String {
            switch self {
            case .search: return "Search"
            case .favorites: return "Favorites"
            case .settings: return "Settings"
            }
        }

        var icon: SFSymbol {
            switch self {
            case .search: return .magnifyingglass
            case .favorites: return .heart
            case .settings: return .gearshape
            }
        }

        var selectedIcon: SFSymbol {
            switch self {
            case .search: return .magnifyingglass
            case .favorites: return .heartFill
            case .settings: return .gearshapeFill
            }
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            // Search Tab
            NavigationStack {
                PremiumSymbolGridView()
            }
            .tag(PremiumTab.search)
            .tabItem {
                Label(PremiumTab.search.title, systemSymbol: selectedTab == .search ? PremiumTab.search.selectedIcon : PremiumTab.search.icon)
            }

            // Favorites Tab
            NavigationStack {
                PremiumFavoritesView()
            }
            .tag(PremiumTab.favorites)
            .tabItem {
                Label(PremiumTab.favorites.title, systemSymbol: selectedTab == .favorites ? PremiumTab.favorites.selectedIcon : PremiumTab.favorites.icon)
            }
            .badge(persistence.favoriteSymbolNames.count)

            // Settings Tab
            NavigationStack {
                PremiumSettingsView()
            }
            .tag(PremiumTab.settings)
            .tabItem {
                Label(PremiumTab.settings.title, systemSymbol: selectedTab == .settings ? PremiumTab.settings.selectedIcon : PremiumTab.settings.icon)
            }
        }
        .onChange(of: selectedTab) { oldValue, newValue in
            if oldValue != newValue {
                HapticManager.shared.selection()
            }
            previousTab = oldValue
        }
        .sensoryFeedback(.selection, trigger: selectedTab)
    }
}

// MARK: - Premium Favorites View
struct PremiumFavoritesView: View {
    @Environment(PersistenceService.self) private var persistence
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    @State private var repository = SymbolRepository()
    @State private var isCreatingCollection = false
    @State private var newCollectionName = ""

    private var columns: [GridItem] {
        let minSize: CGFloat = horizontalSizeClass == .regular ? 88 : 76
        let maxSize: CGFloat = horizontalSizeClass == .regular ? 110 : 94
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
                emptyState
            } else {
                contentList
            }
        }
        .navigationTitle("Favorites")
        .navigationDestination(for: SymbolItem.self) { symbol in
            PremiumSymbolDetailView(symbol: symbol)
        }
        .navigationDestination(for: SymbolCollection.self) { collection in
            PremiumCollectionDetailView(collection: collection)
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button {
                    isCreatingCollection = true
                    HapticManager.shared.lightTap()
                } label: {
                    Image(systemSymbol: .folderBadgePlus)
                }
            }
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
                    HapticManager.shared.success()
                }
            }
        }
    }

    // MARK: - Empty State
    private var emptyState: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            Image(systemSymbol: .heart)
                .font(.system(size: 60))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.pink, .red],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .symbolEffect(.pulse, options: .repeating)

            VStack(spacing: DesignSystem.Spacing.sm) {
                Text("No Favorites Yet")
                    .font(.title2.weight(.semibold))

                Text("Tap the heart icon on any symbol to add it here")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
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
                            PremiumCollectionRow(collection: collection)
                        }
                    }
                    .onDelete(perform: deleteCollections)
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
                NavigationLink(value: symbol) {
                    PremiumSymbolCellView(
                        symbol: symbol,
                        isFavorite: true
                    ) {
                        withAnimation(DesignSystem.Animation.bouncy) {
                            persistence.toggleFavorite(symbol)
                        }
                    }
                }
                .buttonStyle(PremiumCellButtonStyle())
            }
        }
        .padding(.vertical, 8)
    }

    private func deleteCollections(at offsets: IndexSet) {
        for index in offsets {
            persistence.deleteCollection(persistence.collections[index])
        }
        HapticManager.shared.warning()
    }
}

// MARK: - Premium Collection Row
struct PremiumCollectionRow: View {
    let collection: SymbolCollection

    var body: some View {
        HStack(spacing: DesignSystem.Spacing.md) {
            Image(systemSymbol: .folder)
                .font(.title2)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            VStack(alignment: .leading, spacing: 2) {
                Text(collection.name)
                    .font(.body.weight(.medium))

                Text("\(collection.symbolNames.count) symbols")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemSymbol: .chevronRight)
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Premium Collection Detail View
struct PremiumCollectionDetailView: View {
    let collection: SymbolCollection

    @Environment(PersistenceService.self) private var persistence
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.dismiss) private var dismiss

    @State private var repository = SymbolRepository()
    @State private var isEditing = false
    @State private var editedName: String = ""
    @State private var showingDeleteConfirmation = false

    private var columns: [GridItem] {
        let minSize: CGFloat = horizontalSizeClass == .regular ? 88 : 76
        let maxSize: CGFloat = horizontalSizeClass == .regular ? 110 : 94
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
                    HapticManager.shared.success()
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
                HapticManager.shared.warning()
                dismiss()
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
                        PremiumSymbolCellView(
                            symbol: symbol,
                            isFavorite: persistence.isFavorite(symbol)
                        )
                    }
                    .buttonStyle(PremiumCellButtonStyle())
                    .contextMenu {
                        Button(role: .destructive) {
                            persistence.removeFromCollection(symbol, collection: collection)
                            HapticManager.shared.lightTap()
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
        PremiumEmptyStateView(
            icon: .squareGrid2x2,
            title: "No Symbols",
            message: "Add symbols to this collection from the symbol detail view"
        )
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

                Divider()

                Button(role: .destructive) {
                    showingDeleteConfirmation = true
                } label: {
                    Label("Delete Collection", systemImage: "trash")
                }
            } label: {
                Image(systemSymbol: .ellipsisCircle)
            }
        }
    }
}

// MARK: - Premium Settings View
struct PremiumSettingsView: View {
    @Environment(PersistenceService.self) private var persistence
    @AppStorage("usePremiumUI") private var usePremiumUI = true
    @State private var showingResetConfirmation = false

    var body: some View {
        Form {
            // UI Mode Section
            Section {
                Toggle(isOn: $usePremiumUI) {
                    HStack {
                        Image(systemSymbol: .sparkles)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: DesignSystem.Gradient.dawn,
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )

                        VStack(alignment: .leading) {
                            Text("Premium UI")
                            Text("Enhanced animations & effects")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .onChange(of: usePremiumUI) { _, _ in
                    HapticManager.shared.success()
                }
            } header: {
                Text("Appearance")
            } footer: {
                Text("Toggle between standard and premium UI with enhanced animations.")
            }

            // Export Defaults Section
            Section {
                Picker("Default Format", selection: formatBinding) {
                    Text("PNG").tag(ExportFormat.png)
                    Text("SVG").tag(ExportFormat.svg)
                }

                Picker("Default Weight", selection: weightBinding) {
                    ForEach(Font.Weight.allWeights, id: \.self) { weight in
                        Text(weight.displayName).tag(weight)
                    }
                }
            } header: {
                Text("Export Defaults")
            }

            // Display Section
            Section {
                Picker("Symbol Size", selection: sizeBinding) {
                    ForEach(SymbolSize.allCases) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
            } header: {
                Text("Display")
            }

            // Data Section
            Section {
                Button(role: .destructive) {
                    showingResetConfirmation = true
                } label: {
                    Label("Reset All Settings", systemSymbol: .arrowCounterclockwise)
                }
            } header: {
                Text("Data")
            }

            // About Section
            Section {
                LabeledContent("App Version", value: "1.0.0")
                LabeledContent("SF Symbols", value: "6.0+")
                LabeledContent("Build", value: "Premium")

                Link(destination: URL(string: "https://developer.apple.com/sf-symbols/")!) {
                    Label("SF Symbols Documentation", systemSymbol: .questionmarkCircle)
                }
            } header: {
                Text("About")
            }
        }
        .navigationTitle("Settings")
        .confirmationDialog(
            "Reset All Settings?",
            isPresented: $showingResetConfirmation,
            titleVisibility: .visible
        ) {
            Button("Reset", role: .destructive) {
                persistence.settings = .default
                HapticManager.shared.warning()
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This will reset all settings to their default values.")
        }
    }

    // MARK: - Bindings
    private var formatBinding: Binding<ExportFormat> {
        Binding(
            get: { persistence.settings.defaultExportFormat },
            set: { persistence.settings.defaultExportFormat = $0 }
        )
    }

    private var weightBinding: Binding<Font.Weight> {
        Binding(
            get: { persistence.settings.defaultWeight },
            set: { persistence.settings.defaultWeight = $0 }
        )
    }

    private var sizeBinding: Binding<SymbolSize> {
        Binding(
            get: { persistence.settings.symbolSize },
            set: { persistence.settings.symbolSize = $0 }
        )
    }
}

#Preview {
    PremiumMainTabView()
        .environment(PersistenceService())
}
