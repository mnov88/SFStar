import SwiftUI
import SFSymbols

/// Detail view for a single symbol with customization options
struct SymbolDetailView: View {
    let symbol: SymbolItem

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(PersistenceService.self) private var persistence

    @State private var viewModel: SymbolDetailViewModel
    @State private var showingExportOptions = false
    @State private var showingCodeGeneration = false

    // Adapter to map our view model rendering mode to SwiftUI's SymbolRenderingMode
    private var uiSymbolRenderingMode: SymbolRenderingMode {
        switch viewModel.selectedRenderingMode {
        case .monochrome: return .monochrome
        case .hierarchical: return .hierarchical
        case .palette: return .palette
        case .multicolor: return .multicolor
        }
    }

    init(symbol: SymbolItem) {
        self.symbol = symbol
        self._viewModel = State(initialValue: SymbolDetailViewModel(symbol: symbol))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Large Preview
                symbolPreview

                // Symbol Name with Compatibility
                symbolNameSection

                // Customization Options
                customizationSection

                // Preview with customizations
                customizedPreview

                // Action Buttons
                actionButtons
            }
            .padding()
        }
        .navigationTitle("Symbol")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            toolbarContent
        }
        .overlay {
            toastOverlay
        }
        .sheet(isPresented: $showingExportOptions) {
            ExportOptionsSheet(
                symbol: symbol,
                weight: viewModel.selectedWeight,
                color: viewModel.selectedColor,
                renderingMode: viewModel.selectedRenderingMode
            )
        }
        .sheet(isPresented: $showingCodeGeneration) {
            CodeGenerationView(
                symbol: symbol,
                weight: viewModel.selectedWeight,
                color: viewModel.selectedColor,
                renderingMode: viewModel.selectedRenderingMode
            )
        }
        .alert(
            "Export Error",
            isPresented: .init(
                get: { viewModel.exportError != nil },
                set: { if !$0 { viewModel.exportError = nil } }
            ),
            presenting: viewModel.exportError
        ) { _ in
            Button("OK") { viewModel.exportError = nil }
        } message: { error in
            Text(error.localizedDescription)
        }
    }

    // MARK: - Symbol Preview
    private var symbolPreview: some View {
        Image(symbol: symbol.symbol)
            .font(.system(size: horizontalSizeClass == .regular ? 160 : 128))
            .foregroundStyle(viewModel.selectedColor)
            .fontWeight(viewModel.selectedWeight)
            .symbolRenderingMode(uiSymbolRenderingMode)
            .frame(height: horizontalSizeClass == .regular ? 200 : 160)
            .frame(maxWidth: .infinity)
            .accessibilityLabel(symbol.name)
    }

    // MARK: - Symbol Name
    private var symbolNameSection: some View {
        VStack(spacing: 8) {
            Text(symbol.name)
                .font(.title3.monospaced())
                .foregroundStyle(.primary)
                .textSelection(.enabled)

            // Compatibility badge
            CompatibilityBadge(
                symbolName: symbol.name,
                targetVersion: persistence.settings.targetIOSVersion
            )
        }
    }

    // MARK: - Customization Section
    private var customizationSection: some View {
        VStack(spacing: 20) {
            // Weight Selector
            WeightSelectorView(selectedWeight: $viewModel.selectedWeight)

            Divider()

            // Color Picker
            SymbolColorPicker(selectedColor: $viewModel.selectedColor)

            Divider()

            // Rendering Mode Picker
            RenderingModePicker(
                selectedMode: $viewModel.selectedRenderingMode,
                symbolName: symbol.name,
                color: viewModel.selectedColor
            )

            Divider()
        }
        .padding(.horizontal)
    }

    // MARK: - Customized Preview
    private var customizedPreview: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Preview")
                .font(.headline)

            HStack(spacing: 16) {
                ForEach([32, 48, 64], id: \.self) { size in
                    VStack {
                        Image(symbol: symbol.symbol)
                            .font(.system(size: CGFloat(size)))
                            .foregroundStyle(viewModel.selectedColor)
                            .fontWeight(viewModel.selectedWeight)
                            .symbolRenderingMode(uiSymbolRenderingMode)

                        Text("\(size)pt")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.secondarySystemBackground))
            )
        }
    }

    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: 12) {
            // Primary action row
            HStack(spacing: 12) {
                // Export Button
                Button {
                    showingExportOptions = true
                } label: {
                    HStack {
                        Image(symbol: .squareAndArrowDown)
                        Text("Export")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)

                // Code Generation Button
                Button {
                    showingCodeGeneration = true
                } label: {
                    HStack {
                        Image(symbol: .chevronLeftForwardslashChevronRight)
                        Text("Code")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)
            }

            // Secondary action row
            HStack(spacing: 12) {
                // Copy Name Button
                Button {
                    viewModel.copyName()
                } label: {
                    HStack {
                        Image(symbol: .docOnDoc)
                        Text("Copy Name")
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.bordered)

                // Add to Collection Button
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
                        HStack {
                            Image(symbol: .folderBadgePlus)
                            Text("Collection")
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
        .padding(.horizontal)
    }

    // MARK: - Toolbar
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .primaryAction) {
            Button {
                persistence.toggleFavorite(symbol)
            } label: {
                Image(symbol: persistence.isFavorite(symbol) ? .starFill : .star)
                    .foregroundStyle(persistence.isFavorite(symbol) ? .yellow : .primary)
            }
        }

        ToolbarItem(placement: .secondaryAction) {
            Button {
                ShareService.shareSymbolImage(
                    name: symbol.name,
                    weight: viewModel.selectedWeight,
                    color: viewModel.selectedColor,
                    renderingMode: viewModel.selectedRenderingMode
                )
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }
        }

        ToolbarItem(placement: .secondaryAction) {
            Button {
                viewModel.copyName()
            } label: {
                Label("Copy Name", systemImage: "doc.on.doc")
            }
        }
    }

    // MARK: - Toast Overlay
    @ViewBuilder
    private var toastOverlay: some View {
        if viewModel.showCopiedToast {
            VStack {
                Spacer()
                ToastView(message: "Copied to clipboard", icon: .docOnDoc)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            .animation(.spring(response: 0.3), value: viewModel.showCopiedToast)
        }

        if viewModel.showExportSuccess {
            VStack {
                Spacer()
                ToastView(message: "Saved to Files", icon: .checkmarkCircleFill)
                    .transition(.move(edge: .bottom).combined(with: .opacity))
            }
            .animation(.spring(response: 0.3), value: viewModel.showExportSuccess)
        }
    }
}

#Preview {
    NavigationStack {
        SymbolDetailView(symbol: SymbolItem(symbol: .heart))
    }
    .environment(PersistenceService())
}
