import SwiftUI
import SFSymbols

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
                Label(PremiumTab.search.title, symbol: selectedTab == .search ? PremiumTab.search.selectedIcon : PremiumTab.search.icon)
            }

            // Favorites Tab
            NavigationStack {
                PremiumFavoritesView()
            }
            .tag(PremiumTab.favorites)
            .tabItem {
                Label(PremiumTab.favorites.title, symbol: selectedTab == .favorites ? PremiumTab.favorites.selectedIcon : PremiumTab.favorites.icon)
            }
            .badge(persistence.favoriteSymbolNames.count)

            // Settings Tab
            NavigationStack {
                PremiumSettingsView()
            }
            .tag(PremiumTab.settings)
            .tabItem {
                Label(PremiumTab.settings.title, symbol: selectedTab == .settings ? PremiumTab.settings.selectedIcon : PremiumTab.settings.icon)
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

    @State private var repository = SymbolRepository.shared
    @State private var isCreatingCollection = false
    @State private var newCollectionName = ""
    @State private var selectedSymbols: Set<String> = []
    @State private var isSelectionMode = false

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
                    HapticManager.shared.success()
                }
            }
        }
    }

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        if isSelectionMode {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    withAnimation(DesignSystem.Animation.snappy) {
                        isSelectionMode = false
                        selectedSymbols.removeAll()
                    }
                    HapticManager.shared.lightTap()
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
                        Label("Remove Selected", systemImage: "heart.slash")
                    }
                } label: {
                    Text("\(selectedSymbols.count) selected")
                        .font(.subheadline.weight(.medium))
                }
                .disabled(selectedSymbols.isEmpty)
            }
        } else {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    if !favoriteSymbols.isEmpty {
                        Button {
                            withAnimation(DesignSystem.Animation.snappy) {
                                isSelectionMode = true
                            }
                            HapticManager.shared.lightTap()
                        } label: {
                            Label("Select Multiple", systemImage: "checkmark.circle")
                        }
                    }

                    Button {
                        isCreatingCollection = true
                        HapticManager.shared.lightTap()
                    } label: {
                        Label("New Collection", systemImage: "folder.badge.plus")
                    }
                } label: {
                    Image(symbol: .ellipsisCircle)
                }
            }
        }
    }

    // MARK: - Empty State
    private var emptyState: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            Image(symbol: .heart)
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
                if isSelectionMode {
                    selectableCell(for: symbol)
                } else {
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
        }
        .padding(.vertical, 8)
    }

    // MARK: - Selectable Cell
    private func selectableCell(for symbol: SymbolItem) -> some View {
        Button {
            withAnimation(DesignSystem.Animation.snappy) {
                if selectedSymbols.contains(symbol.name) {
                    selectedSymbols.remove(symbol.name)
                } else {
                    selectedSymbols.insert(symbol.name)
                }
            }
            HapticManager.shared.selection()
        } label: {
            ZStack(alignment: .topLeading) {
                PremiumSymbolCellView(
                    symbol: symbol,
                    isFavorite: true
                )

                Image(symbol: selectedSymbols.contains(symbol.name) ? .checkmarkCircleFill : .circle)
                    .foregroundStyle(selectedSymbols.contains(symbol.name) ? .primary : .secondary)
                    .background(Circle().fill(.background))
                    .font(.title3)
                    .padding(6)
            }
        }
        .buttonStyle(PremiumCellButtonStyle())
    }

    // MARK: - Actions
    private func deleteCollections(at offsets: IndexSet) {
        for index in offsets {
            persistence.deleteCollection(persistence.collections[index])
        }
        HapticManager.shared.warning()
    }

    private func addSelectedToCollection(_ collection: SymbolCollection) {
        for name in selectedSymbols {
            if let symbol = repository.symbol(named: name) {
                persistence.addToCollection(symbol, collection: collection)
            }
        }
        withAnimation(DesignSystem.Animation.snappy) {
            isSelectionMode = false
            selectedSymbols.removeAll()
        }
        HapticManager.shared.success()
    }

    private func removeSelectedFromFavorites() {
        for name in selectedSymbols {
            if let symbol = repository.symbol(named: name) {
                persistence.toggleFavorite(symbol)
            }
        }
        withAnimation(DesignSystem.Animation.snappy) {
            isSelectionMode = false
            selectedSymbols.removeAll()
        }
        HapticManager.shared.warning()
    }
}

// MARK: - Premium Collection Row
struct PremiumCollectionRow: View {
    let collection: SymbolCollection

    var body: some View {
        HStack(spacing: DesignSystem.Spacing.md) {
            Image(symbol: .folder)
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

            Image(symbol: .chevronRight)
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

    @State private var repository = SymbolRepository.shared
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
                Image(symbol: .ellipsisCircle)
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
                        Image(symbol: .sparkles)
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

                NavigationLink {
                    PremiumExportScalesSettingsView()
                } label: {
                    HStack {
                        Text("Default Scales")
                        Spacer()
                        Text(scalesDescription)
                            .foregroundStyle(.secondary)
                    }
                }

                Picker("Default Weight", selection: weightBinding) {
                    ForEach(Font.Weight.allWeights, id: \.self) { weight in
                        Text(weight.displayName).tag(weight)
                    }
                }
            } header: {
                Text("Export Defaults")
            } footer: {
                Text("These settings are used as defaults when exporting symbols.")
            }

            // Compatibility Section
            Section {
                Picker("Target iOS", selection: targetIOSBinding) {
                    Text("iOS 13.0").tag(13.0)
                    Text("iOS 14.0").tag(14.0)
                    Text("iOS 15.0").tag(15.0)
                    Text("iOS 16.0").tag(16.0)
                    Text("iOS 17.0").tag(17.0)
                    Text("iOS 18.0").tag(18.0)
                }

                Toggle("Show Compatibility Badge", isOn: showBadgeBinding)
            } header: {
                Text("Compatibility")
            } footer: {
                Text("Filter symbols and show badges based on iOS version compatibility.")
            }

            // Display Section
            Section {
                Picker("Grid Columns", selection: columnsBinding) {
                    Text("Auto").tag(0)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                    Text("6").tag(6)
                }

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
                    Label("Reset All Settings", symbol: .arrowCounterclockwise)
                }

                NavigationLink {
                    PremiumDataManagementView()
                } label: {
                    Label("Manage Data", symbol: .externaldrive)
                }
            } header: {
                Text("Data")
            }

            // About Section
            Section {
                LabeledContent("App Version", value: "1.0.0")
                LabeledContent("SF Symbols", value: "6.0+")
                LabeledContent("Build", value: "Premium")

                Link(destination: URL(string: "https://github.com")!) {
                    Label("Send Feedback", symbol: .envelope)
                }

                Link(destination: URL(string: "https://developer.apple.com/sf-symbols/")!) {
                    Label("SF Symbols Documentation", symbol: .questionmarkCircle)
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

    private var targetIOSBinding: Binding<Double> {
        Binding(
            get: { persistence.settings.targetIOSVersion },
            set: { persistence.settings.targetIOSVersion = $0 }
        )
    }

    private var showBadgeBinding: Binding<Bool> {
        Binding(
            get: { persistence.settings.showCompatibilityBadge },
            set: { persistence.settings.showCompatibilityBadge = $0 }
        )
    }

    private var columnsBinding: Binding<Int> {
        Binding(
            get: { persistence.settings.gridColumns },
            set: { persistence.settings.gridColumns = $0 }
        )
    }

    private var sizeBinding: Binding<SymbolSize> {
        Binding(
            get: { persistence.settings.symbolSize },
            set: { persistence.settings.symbolSize = $0 }
        )
    }

    private var scalesDescription: String {
        let scales = persistence.settings.defaultScales.sorted()
        if scales.isEmpty {
            return "None"
        }
        return scales.map { $0.label }.joined(separator: ", ")
    }
}

// MARK: - Premium Export Scales Settings
struct PremiumExportScalesSettingsView: View {
    @Environment(PersistenceService.self) private var persistence

    var body: some View {
        Form {
            Section {
                ForEach(ExportScale.allCases) { scale in
                    Toggle(scale.label, isOn: scaleBinding(for: scale))
                }
            } footer: {
                Text("Select which scales to include when exporting PNG files.")
            }
        }
        .navigationTitle("Export Scales")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func scaleBinding(for scale: ExportScale) -> Binding<Bool> {
        Binding(
            get: { persistence.settings.defaultScales.contains(scale) },
            set: { isOn in
                if isOn {
                    persistence.settings.defaultScales.insert(scale)
                } else {
                    persistence.settings.defaultScales.remove(scale)
                }
                HapticManager.shared.selection()
            }
        )
    }
}

// MARK: - Premium Data Management View
struct PremiumDataManagementView: View {
    @Environment(PersistenceService.self) private var persistence
    @State private var showingClearFavorites = false
    @State private var showingClearCollections = false
    @State private var showingClearAll = false

    var body: some View {
        Form {
            Section {
                LabeledContent("Favorites", value: "\(persistence.favoriteSymbolNames.count)")
                LabeledContent("Collections", value: "\(persistence.collections.count)")

                let totalInCollections = persistence.collections.reduce(0) { $0 + $1.symbolNames.count }
                LabeledContent("Symbols in Collections", value: "\(totalInCollections)")
            } header: {
                Text("Statistics")
            }

            Section {
                Button(role: .destructive) {
                    showingClearFavorites = true
                } label: {
                    Label("Clear All Favorites", symbol: .starSlash)
                }
                .disabled(persistence.favoriteSymbolNames.isEmpty)

                Button(role: .destructive) {
                    showingClearCollections = true
                } label: {
                    Label("Delete All Collections", symbol: .folderBadgeMinus)
                }
                .disabled(persistence.collections.isEmpty)

                Button(role: .destructive) {
                    showingClearAll = true
                } label: {
                    Label("Clear All Data", symbol: .trash)
                }
            } header: {
                Text("Clear Data")
            } footer: {
                Text("These actions cannot be undone.")
            }
        }
        .navigationTitle("Manage Data")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("Clear Favorites?", isPresented: $showingClearFavorites) {
            Button("Clear All Favorites", role: .destructive) {
                persistence.favoriteSymbolNames.removeAll()
                HapticManager.shared.warning()
            }
        }
        .confirmationDialog("Delete Collections?", isPresented: $showingClearCollections) {
            Button("Delete All Collections", role: .destructive) {
                persistence.collections.removeAll()
                HapticManager.shared.warning()
            }
        }
        .confirmationDialog("Clear All Data?", isPresented: $showingClearAll) {
            Button("Clear Everything", role: .destructive) {
                persistence.favoriteSymbolNames.removeAll()
                persistence.collections.removeAll()
                persistence.settings = .default
                HapticManager.shared.warning()
            }
        }
    }
}

#Preview {
    PremiumMainTabView()
        .environment(PersistenceService())
}
