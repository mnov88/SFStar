import SwiftUI
import SFSafeSymbols

/// View for comparing multiple symbols or the same symbol with different configurations
struct SymbolComparisonView: View {
    let primarySymbol: SymbolItem
    @Environment(\.dismiss) private var dismiss

    @State private var comparisonMode: ComparisonMode = .weights
    @State private var selectedSymbols: [SymbolItem] = []
    @State private var baseColor: Color = .primary
    @State private var baseRenderingMode: SymbolRenderingMode = .monochrome
    @State private var showSymbolPicker = false

    enum ComparisonMode: String, CaseIterable, Identifiable {
        case weights = "Weights"
        case renderingModes = "Rendering"
        case colors = "Colors"
        case symbols = "Symbols"

        var id: String { rawValue }

        var iconName: String {
            switch self {
            case .weights: return "textformat.size"
            case .renderingModes: return "paintbrush"
            case .colors: return "paintpalette"
            case .symbols: return "square.grid.3x3"
            }
        }
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Mode picker
                modePicker
                    .padding()

                Divider()

                // Comparison grid
                ScrollView {
                    comparisonContent
                        .padding()
                }
            }
            .navigationTitle("Compare")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .sheet(isPresented: $showSymbolPicker) {
                SymbolSearchSheet(selectedSymbols: $selectedSymbols, limit: 8)
            }
            .onAppear {
                if selectedSymbols.isEmpty {
                    selectedSymbols = [primarySymbol]
                }
            }
        }
    }

    // MARK: - Mode Picker

    private var modePicker: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DesignSystem.Spacing.sm) {
                ForEach(ComparisonMode.allCases) { mode in
                    Button {
                        withAnimation(DesignSystem.Animation.snappy) {
                            comparisonMode = mode
                        }
                        HapticManager.shared.selection()
                    } label: {
                        Label(mode.rawValue, systemImage: mode.iconName)
                            .font(.subheadline.weight(comparisonMode == mode ? .semibold : .regular))
                            .foregroundStyle(comparisonMode == mode ? .white : .primary)
                            .padding(.horizontal, DesignSystem.Spacing.md)
                            .padding(.vertical, DesignSystem.Spacing.sm)
                            .background(
                                Capsule()
                                    .fill(comparisonMode == mode ? Color.accentColor : Color.secondary.opacity(0.1))
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }

    // MARK: - Comparison Content

    @ViewBuilder
    private var comparisonContent: some View {
        switch comparisonMode {
        case .weights:
            weightsComparison
        case .renderingModes:
            renderingModesComparison
        case .colors:
            colorsComparison
        case .symbols:
            symbolsComparison
        }
    }

    // MARK: - Weights Comparison

    private var weightsComparison: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            Text("Compare all weights")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: DesignSystem.Spacing.md) {
                ForEach(Font.Weight.allWeights, id: \.self) { weight in
                    ComparisonCell(
                        symbolName: primarySymbol.name,
                        weight: weight,
                        color: baseColor,
                        renderingMode: baseRenderingMode,
                        label: weight.displayName
                    )
                }
            }
        }
    }

    // MARK: - Rendering Modes Comparison

    private var renderingModesComparison: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            Text("Compare rendering modes")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: DesignSystem.Spacing.md) {
                ForEach(SymbolRenderingMode.allCases) { mode in
                    ComparisonCell(
                        symbolName: primarySymbol.name,
                        weight: .regular,
                        color: baseColor,
                        renderingMode: mode,
                        label: mode.displayName
                    )
                }
            }
        }
    }

    // MARK: - Colors Comparison

    private var colorsComparison: some View {
        let colors: [(Color, String)] = [
            (.primary, "Primary"),
            (.secondary, "Secondary"),
            (.red, "Red"),
            (.orange, "Orange"),
            (.yellow, "Yellow"),
            (.green, "Green"),
            (.mint, "Mint"),
            (.teal, "Teal"),
            (.cyan, "Cyan"),
            (.blue, "Blue"),
            (.indigo, "Indigo"),
            (.purple, "Purple"),
            (.pink, "Pink"),
            (.brown, "Brown")
        ]

        return VStack(spacing: DesignSystem.Spacing.lg) {
            Text("Compare colors")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: DesignSystem.Spacing.md) {
                ForEach(colors, id: \.1) { color, name in
                    ComparisonCell(
                        symbolName: primarySymbol.name,
                        weight: .regular,
                        color: color,
                        renderingMode: baseRenderingMode,
                        label: name
                    )
                }
            }
        }
    }

    // MARK: - Symbols Comparison

    private var symbolsComparison: some View {
        VStack(spacing: DesignSystem.Spacing.lg) {
            HStack {
                Text("Compare symbols")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                Button {
                    showSymbolPicker = true
                } label: {
                    Label("Add", systemImage: "plus.circle")
                        .font(.subheadline)
                }
            }

            if selectedSymbols.isEmpty {
                ContentUnavailableView(
                    "No Symbols Selected",
                    systemImage: "square.grid.3x3",
                    description: Text("Add symbols to compare")
                )
                .frame(height: 200)
            } else {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: DesignSystem.Spacing.md) {
                    ForEach(selectedSymbols) { symbol in
                        ComparisonCell(
                            symbolName: symbol.name,
                            weight: .regular,
                            color: baseColor,
                            renderingMode: baseRenderingMode,
                            label: symbol.name,
                            showRemoveButton: selectedSymbols.count > 1
                        ) {
                            withAnimation(DesignSystem.Animation.snappy) {
                                selectedSymbols.removeAll { $0.name == symbol.name }
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Comparison Cell

private struct ComparisonCell: View {
    let symbolName: String
    let weight: Font.Weight
    let color: Color
    let renderingMode: SymbolRenderingMode
    let label: String
    var showRemoveButton: Bool = false
    var onRemove: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.sm) {
            ZStack(alignment: .topTrailing) {
                Image(systemName: symbolName)
                    .font(.system(size: 40))
                    .fontWeight(weight)
                    .symbolRenderingMode(renderingMode)
                    .foregroundStyle(color)
                    .frame(width: 80, height: 80)
                    .background(Color(.secondarySystemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous))

                if showRemoveButton {
                    Button {
                        onRemove?()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.white, .red)
                            .font(.title3)
                    }
                    .offset(x: 8, y: -8)
                }
            }

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .lineLimit(1)
        }
    }
}

// MARK: - Symbol Search Sheet

struct SymbolSearchSheet: View {
    @Binding var selectedSymbols: [SymbolItem]
    let limit: Int

    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    @State private var searchResults: [SymbolItem] = []

    private let symbolRepository = SymbolRepository()

    var body: some View {
        NavigationStack {
            List {
                if searchText.isEmpty {
                    Section {
                        Text("Search for symbols to add")
                            .foregroundStyle(.secondary)
                    }
                } else {
                    ForEach(searchResults) { symbol in
                        Button {
                            addSymbol(symbol)
                        } label: {
                            HStack {
                                Image(systemName: symbol.name)
                                    .font(.title2)
                                    .frame(width: 40)

                                Text(symbol.name)
                                    .font(.body)

                                Spacer()

                                if selectedSymbols.contains(where: { $0.name == symbol.name }) {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                        .foregroundStyle(.primary)
                    }
                }
            }
            .searchable(text: $searchText, prompt: "Search symbols")
            .navigationTitle("Add Symbols")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .onChange(of: searchText) { _, newValue in
                performSearch(newValue)
            }
        }
    }

    private func performSearch(_ query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        searchResults = Array(symbolRepository.symbols(matching: query, category: nil).prefix(50))
    }

    private func addSymbol(_ symbol: SymbolItem) {
        if selectedSymbols.contains(where: { $0.name == symbol.name }) {
            selectedSymbols.removeAll { $0.name == symbol.name }
        } else if selectedSymbols.count < limit {
            selectedSymbols.append(symbol)
            HapticManager.shared.success()
        } else {
            HapticManager.shared.warning()
        }
    }
}

// MARK: - Multi-Symbol Grid Preview

/// A view showing multiple symbols in a configurable grid layout
struct MultiSymbolGridPreview: View {
    let symbols: [SymbolItem]
    let weight: Font.Weight
    let color: Color
    let renderingMode: SymbolRenderingMode
    var columns: Int = 3
    var symbolSize: CGFloat = 32

    private var gridColumns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: DesignSystem.Spacing.sm), count: columns)
    }

    var body: some View {
        LazyVGrid(columns: gridColumns, spacing: DesignSystem.Spacing.sm) {
            ForEach(symbols) { symbol in
                Image(systemName: symbol.name)
                    .font(.system(size: symbolSize))
                    .fontWeight(weight)
                    .symbolRenderingMode(renderingMode)
                    .foregroundStyle(color)
                    .frame(maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
    }
}

// MARK: - Symbol Variants Row

/// Shows a symbol in all its weight variants horizontally
struct SymbolWeightVariantsRow: View {
    let symbolName: String
    let color: Color
    let renderingMode: SymbolRenderingMode

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DesignSystem.Spacing.md) {
                ForEach(Font.Weight.allWeights, id: \.self) { weight in
                    VStack(spacing: DesignSystem.Spacing.xs) {
                        Image(systemName: symbolName)
                            .font(.system(size: 28))
                            .fontWeight(weight)
                            .symbolRenderingMode(renderingMode)
                            .foregroundStyle(color)
                            .frame(width: 50, height: 50)
                            .background(Color(.tertiarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                        Text(weight.shortName)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Preview

#Preview {
    SymbolComparisonView(
        primarySymbol: SymbolItem(symbol: .heartFill, category: .health)
    )
}

#Preview("Multi-Symbol Grid") {
    MultiSymbolGridPreview(
        symbols: [
            SymbolItem(symbol: .heartFill),
            SymbolItem(symbol: .starFill),
            SymbolItem(symbol: .bellFill),
            SymbolItem(symbol: .bookmarkFill),
            SymbolItem(symbol: .flagFill),
            SymbolItem(symbol: .tagFill)
        ],
        weight: .regular,
        color: .blue,
        renderingMode: .monochrome
    )
    .padding()
}
