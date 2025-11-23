import SwiftUI
import SFSafeSymbols

/// Premium symbol detail view with delightful animations and interactions
struct PremiumSymbolDetailView: View {
    let symbol: SymbolItem

    @Environment(PersistenceService.self) private var persistence
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel: SymbolDetailViewModel
    @State private var showingExportSheet = false
    @State private var showingCollectionPicker = false
    @State private var showingCodeGeneration = false
    @State private var showingComparison = false
    @State private var exportResult: ExportResult?
    @State private var symbolAnimationTrigger = false
    @State private var showCopiedToast = false

    init(symbol: SymbolItem) {
        self.symbol = symbol
        self._viewModel = State(initialValue: SymbolDetailViewModel(symbol: symbol))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: DesignSystem.Spacing.xl) {
                // Hero symbol presentation
                heroSection

                // Weight selector
                weightSection

                // Color picker
                colorSection

                // Rendering mode
                renderingModeSection

                // Symbol effects (iOS 17+)
                if #available(iOS 17.0, *) {
                    effectsSection
                }

                // Quick actions
                actionsSection

                // Symbol info
                infoSection
            }
            .padding()
        }
        .background(
            AnimatedMeshGradient(colors: DesignSystem.Gradient.subtle)
                .opacity(0.3)
                .ignoresSafeArea()
        )
        .navigationTitle(symbol.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            toolbarContent
        }
        .sheet(isPresented: $showingExportSheet) {
            PremiumExportOptionsSheet(
                symbol: symbol,
                weight: viewModel.selectedWeight,
                color: viewModel.selectedColor,
                renderingMode: viewModel.selectedRenderingMode
            )
        }
        .sheet(isPresented: $showingCollectionPicker) {
            CollectionPickerSheet(symbol: symbol)
        }
        .sheet(isPresented: $showingCodeGeneration) {
            PremiumCodeGenerationView(
                symbol: symbol,
                weight: viewModel.selectedWeight,
                color: viewModel.selectedColor,
                renderingMode: viewModel.selectedRenderingMode,
                effectConfiguration: viewModel.effectConfiguration
            )
        }
        .sheet(isPresented: $showingComparison) {
            SymbolComparisonView(primarySymbol: symbol)
        }
        .overlay(alignment: .bottom) {
            if showCopiedToast {
                copiedToast
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .onAppear {
            withAnimation(DesignSystem.Animation.smooth.delay(0.2)) {
                symbolAnimationTrigger = true
            }
        }
    }

    // MARK: - Hero Section
    private var heroSection: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            // Animated symbol card
            symbolCard
                .onTapGesture {
                    triggerSymbolAnimation()
                }

            // Symbol name with copy button
            HStack {
                Text(symbol.name)
                    .font(.title3.monospaced())
                    .foregroundStyle(.secondary)

                Button {
                    copySymbolName()
                } label: {
                    Image(systemSymbol: .docOnDoc)
                        .font(.body)
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: - Symbol Card with Keyframe Animation
    private var symbolCard: some View {
        ZStack {
            // Background card
            RoundedRectangle(cornerRadius: DesignSystem.Radius.xl, style: .continuous)
                .fill(.ultraThinMaterial)
                .shadow(color: .black.opacity(0.1), radius: 20, y: 10)

            // Symbol with animation
            symbolWithAnimation
        }
        .frame(width: 200, height: 200)
        .scaleEffect(symbolAnimationTrigger ? 1.0 : 0.8)
        .opacity(symbolAnimationTrigger ? 1.0 : 0)
    }

    @ViewBuilder
    private var symbolWithAnimation: some View {
        if #available(iOS 17.0, *) {
            KeyframeAnimator(
                initialValue: SymbolAnimationValues(),
                trigger: symbolAnimationTrigger
            ) { values in
                Image(systemName: symbol.name)
                    .font(.system(size: 72))
                    .fontWeight(viewModel.configuration.weight)
                    .symbolRenderingMode(viewModel.selectedRenderingMode)
                    .foregroundStyle(symbolGradient)
                    .scaleEffect(values.scale)
                    .rotationEffect(.degrees(values.rotation))
                    .offset(y: values.verticalOffset)
            } keyframes: { _ in
                KeyframeTrack(\.scale) {
                    SpringKeyframe(1.1, duration: 0.3, spring: .bouncy)
                    SpringKeyframe(1.0, duration: 0.2, spring: .smooth)
                }
                KeyframeTrack(\.rotation) {
                    LinearKeyframe(0, duration: 0.1)
                    SpringKeyframe(-5, duration: 0.15, spring: .snappy)
                    SpringKeyframe(5, duration: 0.15, spring: .snappy)
                    SpringKeyframe(0, duration: 0.2, spring: .smooth)
                }
                KeyframeTrack(\.verticalOffset) {
                    LinearKeyframe(0, duration: 0.1)
                    SpringKeyframe(-10, duration: 0.2, spring: .bouncy)
                    SpringKeyframe(0, duration: 0.3, spring: .smooth)
                }
            }
        } else {
            Image(systemName: symbol.name)
                .font(.system(size: 72))
                .fontWeight(viewModel.configuration.weight)
                .symbolRenderingMode(viewModel.selectedRenderingMode)
                .foregroundStyle(symbolGradient)
        }
    }

    private var symbolGradient: LinearGradient {
        // Use user-selected color if not default, otherwise use gradient based on favorite status
        if viewModel.selectedColor != .primary {
            return LinearGradient(
                colors: [viewModel.selectedColor, viewModel.selectedColor.opacity(0.7)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
        return LinearGradient(
            colors: persistence.isFavorite(symbol)
                ? [.pink, .orange]
                : DesignSystem.Gradient.ocean,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // MARK: - Weight Section
    private var weightSection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            Text("Weight")
                .font(.headline)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DesignSystem.Spacing.sm) {
                    ForEach(Font.Weight.allWeights, id: \.self) { weight in
                        PremiumWeightButton(
                            weight: weight,
                            isSelected: viewModel.configuration.weight == weight
                        ) {
                            withAnimation(DesignSystem.Animation.snappy) {
                                viewModel.setWeight(weight)
                            }
                            HapticManager.shared.selection()
                            triggerSymbolAnimation()
                        }
                    }
                }
                .padding(.horizontal, 4)
            }
        }
        .padding()
        .glassEffect()
    }

    // MARK: - Color Section
    private var colorSection: some View {
        PremiumSymbolColorPicker(selectedColor: $viewModel.selectedColor) { _ in
            triggerSymbolAnimation()
        }
    }

    // MARK: - Rendering Mode Section
    private var renderingModeSection: some View {
        PremiumRenderingModePicker(
            selectedMode: $viewModel.selectedRenderingMode,
            symbolName: symbol.name,
            color: viewModel.selectedColor
        ) { _ in
            triggerSymbolAnimation()
        }
    }

    // MARK: - Effects Section
    @available(iOS 17.0, *)
    private var effectsSection: some View {
        SymbolEffectPicker(
            configuration: $viewModel.effectConfiguration,
            symbolName: symbol.name,
            weight: viewModel.selectedWeight,
            color: viewModel.selectedColor,
            renderingMode: viewModel.selectedRenderingMode
        )
    }

    // MARK: - Actions Section
    private var actionsSection: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            HStack(spacing: DesignSystem.Spacing.md) {
                // Favorite button
                PremiumActionButton(
                    icon: persistence.isFavorite(symbol) ? .heartFill : .heart,
                    title: persistence.isFavorite(symbol) ? "Favorited" : "Favorite",
                    gradient: [.pink, .red]
                ) {
                    withAnimation(DesignSystem.Animation.bouncy) {
                        persistence.toggleFavorite(symbol)
                    }
                    HapticManager.shared.heartbeat()
                    triggerSymbolAnimation()
                }

                // Collection button
                PremiumActionButton(
                    icon: .folderBadgePlus,
                    title: "Collection",
                    gradient: [.blue, .purple]
                ) {
                    showingCollectionPicker = true
                    HapticManager.shared.lightTap()
                }
            }

            HStack(spacing: DesignSystem.Spacing.md) {
                // Export button
                PremiumActionButton(
                    icon: .squareAndArrowUp,
                    title: "Export",
                    gradient: DesignSystem.Gradient.ocean
                ) {
                    showingExportSheet = true
                    HapticManager.shared.lightTap()
                }

                // Code Generation button
                PremiumActionButton(
                    icon: .chevronLeftForwardslashChevronRight,
                    title: "Code",
                    gradient: [.purple, .indigo]
                ) {
                    showingCodeGeneration = true
                    HapticManager.shared.lightTap()
                }
            }

            HStack(spacing: DesignSystem.Spacing.md) {
                // Compare button
                PremiumActionButton(
                    icon: .rectangleOnRectangle,
                    title: "Compare",
                    gradient: [.orange, .yellow]
                ) {
                    showingComparison = true
                    HapticManager.shared.lightTap()
                }

                // Copy button
                PremiumActionButton(
                    icon: .docOnDoc,
                    title: "Copy Name",
                    gradient: [.green, .mint]
                ) {
                    copySymbolName()
                }
            }
        }
    }

    // MARK: - Info Section
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            HStack {
                Text("Information")
                    .font(.headline)

                Spacer()

                // Compatibility badge
                PremiumCompatibilityBadge(
                    symbolName: symbol.name,
                    targetVersion: persistence.settings.targetIOSVersion
                )
            }

            VStack(spacing: DesignSystem.Spacing.sm) {
                InfoRow(label: "Name", value: symbol.name)
                InfoRow(label: "Category", value: symbol.category.rawValue)
            }
        }
        .padding()
        .glassEffect()
    }

    // MARK: - Copied Toast
    private var copiedToast: some View {
        HStack(spacing: DesignSystem.Spacing.sm) {
            Image(systemSymbol: .checkmarkCircleFill)
                .foregroundStyle(.green)

            Text("Copied to clipboard")
                .font(.subheadline.weight(.medium))
        }
        .padding(.horizontal, DesignSystem.Spacing.lg)
        .padding(.vertical, DesignSystem.Spacing.md)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
        .padding(.bottom, DesignSystem.Spacing.xl)
    }

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Menu {
                Button {
                    showingExportSheet = true
                } label: {
                    Label("Export", systemSymbol: .squareAndArrowDown)
                }

                Button {
                    ShareService.shareSymbolImage(
                        name: symbol.name,
                        weight: viewModel.selectedWeight,
                        color: viewModel.selectedColor,
                        renderingMode: viewModel.selectedRenderingMode
                    )
                    HapticManager.shared.lightTap()
                } label: {
                    Label("Share", systemSymbol: .squareAndArrowUp)
                }
            } label: {
                Image(systemSymbol: .ellipsisCircle)
            }
        }
    }

    // MARK: - Actions
    private func copySymbolName() {
        UIPasteboard.general.string = symbol.name
        HapticManager.shared.success()

        withAnimation(DesignSystem.Animation.snappy) {
            showCopiedToast = true
        }

        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation(DesignSystem.Animation.smooth) {
                showCopiedToast = false
            }
        }
    }

    private func triggerSymbolAnimation() {
        symbolAnimationTrigger = false
        Task {
            try? await Task.sleep(nanoseconds: 50_000_000)
            withAnimation {
                symbolAnimationTrigger = true
            }
        }
    }
}

// MARK: - Animation Values
struct SymbolAnimationValues {
    var scale: CGFloat = 1.0
    var rotation: Double = 0
    var verticalOffset: CGFloat = 0
}

// MARK: - Premium Weight Button
struct PremiumWeightButton: View {
    let weight: Font.Weight
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(weight.displayName)
                .font(.subheadline.weight(isSelected ? .semibold : .regular))
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, DesignSystem.Spacing.md)
                .padding(.vertical, DesignSystem.Spacing.sm)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.accentColor : Color.secondary.opacity(0.1))
                )
        }
        .buttonStyle(.plain)
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(DesignSystem.Animation.snappy, value: isSelected)
        .accessibilityLabel("\(weight.displayName) weight")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

// MARK: - Premium Action Button
struct PremiumActionButton: View {
    let icon: SFSymbol
    let title: String
    let gradient: [Color]
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: action) {
            VStack(spacing: DesignSystem.Spacing.sm) {
                Image(systemSymbol: icon)
                    .font(.title2)
                    .foregroundStyle(
                        LinearGradient(colors: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                    )

                Text(title)
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, DesignSystem.Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                    .fill(.background)
                    .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
            )
        }
        .buttonStyle(PremiumCellButtonStyle())
        .accessibilityLabel(title)
    }
}

// MARK: - Info Row
struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .font(.subheadline)
                .foregroundStyle(.primary)
                .lineLimit(1)
        }
        .padding(.vertical, DesignSystem.Spacing.xs)
    }
}

// MARK: - Collection Picker Sheet
struct CollectionPickerSheet: View {
    let symbol: SymbolItem
    @Environment(PersistenceService.self) private var persistence
    @Environment(\.dismiss) private var dismiss
    @State private var newCollectionName = ""
    @State private var isCreating = false

    var body: some View {
        NavigationStack {
            List {
                if persistence.collections.isEmpty {
                    Section {
                        Text("No collections yet")
                            .foregroundStyle(.secondary)
                    }
                } else {
                    Section("Add to Collection") {
                        ForEach(persistence.collections) { collection in
                            Button {
                                persistence.addToCollection(symbol, collection: collection)
                                HapticManager.shared.success()
                                dismiss()
                            } label: {
                                HStack {
                                    Image(systemSymbol: .folder)
                                        .foregroundStyle(.accentColor)

                                    Text(collection.name)

                                    Spacer()

                                    if collection.symbolNames.contains(symbol.name) {
                                        Image(systemSymbol: .checkmark)
                                            .foregroundStyle(.green)
                                    }
                                }
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }

                Section {
                    if isCreating {
                        HStack {
                            TextField("Collection name", text: $newCollectionName)

                            Button("Create") {
                                if !newCollectionName.isEmpty {
                                    let collection = persistence.createCollection(name: newCollectionName)
                                    persistence.addToCollection(symbol, collection: collection)
                                    HapticManager.shared.success()
                                    dismiss()
                                }
                            }
                            .disabled(newCollectionName.isEmpty)
                        }
                    } else {
                        Button {
                            isCreating = true
                        } label: {
                            Label("Create New Collection", systemSymbol: .plusCircle)
                        }
                    }
                }
            }
            .navigationTitle("Collections")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        PremiumSymbolDetailView(symbol: SymbolItem(symbol: .heartFill, category: .health))
    }
    .environment(PersistenceService())
}
