import SwiftUI
import SFSafeSymbols

/// Picker for selecting SF Symbol rendering modes
struct RenderingModePicker: View {
    @Binding var selectedMode: SymbolRenderingMode
    var symbolName: String = "heart.fill"
    var color: Color = .blue
    var onModeChange: ((SymbolRenderingMode) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Rendering Mode")
                .font(.headline)

            // Segmented picker
            Picker("Rendering Mode", selection: $selectedMode) {
                ForEach(SymbolRenderingMode.allCases) { mode in
                    Text(mode.displayName).tag(mode)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: selectedMode) { _, newMode in
                onModeChange?(newMode)
                let generator = UISelectionFeedbackGenerator()
                generator.selectionChanged()
            }

            // Mode description
            Text(selectedMode.description)
                .font(.caption)
                .foregroundStyle(.secondary)

            // Preview strip
            HStack(spacing: 16) {
                ForEach(SymbolRenderingMode.allCases) { mode in
                    VStack(spacing: 4) {
                        Image(systemName: symbolName)
                            .font(.title2)
                            .symbolRenderingMode(mode)
                            .foregroundStyle(color)
                            .frame(width: 40, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .fill(selectedMode == mode ? Color.accentColor.opacity(0.1) : Color.clear)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8, style: .continuous)
                                    .strokeBorder(selectedMode == mode ? Color.accentColor : Color.clear, lineWidth: 2)
                            )

                        Text(mode.displayName)
                            .font(.caption2)
                            .foregroundStyle(selectedMode == mode ? .primary : .secondary)
                    }
                    .onTapGesture {
                        selectedMode = mode
                        onModeChange?(mode)
                    }
                }
            }
        }
    }
}

// MARK: - Premium Rendering Mode Picker
struct PremiumRenderingModePicker: View {
    @Binding var selectedMode: SymbolRenderingMode
    var symbolName: String = "heart.fill"
    var color: Color = .blue
    var onModeChange: ((SymbolRenderingMode) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            Text("Rendering Mode")
                .font(.headline)

            // Mode cards
            HStack(spacing: DesignSystem.Spacing.sm) {
                ForEach(SymbolRenderingMode.allCases) { mode in
                    PremiumRenderingModeCard(
                        mode: mode,
                        symbolName: symbolName,
                        color: color,
                        isSelected: selectedMode == mode
                    ) {
                        withAnimation(DesignSystem.Animation.snappy) {
                            selectedMode = mode
                        }
                        onModeChange?(mode)
                        HapticManager.shared.selection()
                    }
                }
            }

            // Selected mode description
            HStack {
                Image(systemSymbol: .infoCircle)
                    .foregroundStyle(.secondary)
                Text(selectedMode.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.top, DesignSystem.Spacing.xs)
        }
        .padding()
        .glassEffect()
    }
}

// MARK: - Premium Rendering Mode Card
struct PremiumRenderingModeCard: View {
    let mode: SymbolRenderingMode
    let symbolName: String
    let color: Color
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: DesignSystem.Spacing.sm) {
                // Symbol preview
                Image(systemName: symbolName)
                    .font(.title2)
                    .symbolRenderingMode(mode)
                    .foregroundStyle(color)
                    .frame(width: 44, height: 44)

                // Mode name
                Text(mode.displayName)
                    .font(.caption2.weight(isSelected ? .semibold : .regular))
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, DesignSystem.Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                    .fill(isSelected ? Color.accentColor.opacity(0.15) : Color.secondary.opacity(0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                    .strokeBorder(
                        isSelected ? Color.accentColor : Color.clear,
                        lineWidth: 2
                    )
            )
            .foregroundStyle(isSelected ? .primary : .secondary)
        }
        .buttonStyle(.plain)
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(DesignSystem.Animation.snappy, value: isSelected)
    }
}

// MARK: - Compact Rendering Mode Picker
struct CompactRenderingModePicker: View {
    @Binding var selectedMode: SymbolRenderingMode

    var body: some View {
        Menu {
            ForEach(SymbolRenderingMode.allCases) { mode in
                Button {
                    selectedMode = mode
                } label: {
                    HStack {
                        Text(mode.displayName)
                        if selectedMode == mode {
                            Image(systemSymbol: .checkmark)
                        }
                    }
                }
            }
        } label: {
            HStack {
                Text("Mode:")
                    .foregroundStyle(.secondary)
                Text(selectedMode.displayName)
                    .fontWeight(.medium)
                Image(systemSymbol: .chevronDown)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.secondarySystemBackground))
            .clipShape(Capsule())
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var mode: SymbolRenderingMode = .hierarchical

        var body: some View {
            VStack(spacing: 32) {
                RenderingModePicker(selectedMode: $mode, symbolName: "heart.fill", color: .pink)
                    .padding()

                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .symbolRenderingMode(mode)
                    .foregroundStyle(.pink)
            }
        }
    }

    return PreviewWrapper()
}

#Preview("Premium") {
    struct PreviewWrapper: View {
        @State private var mode: SymbolRenderingMode = .hierarchical

        var body: some View {
            VStack(spacing: 32) {
                PremiumRenderingModePicker(selectedMode: $mode, symbolName: "heart.fill", color: .pink)

                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .symbolRenderingMode(mode)
                    .foregroundStyle(.pink)
            }
            .padding()
            .background(Color(.systemGroupedBackground))
        }
    }

    return PreviewWrapper()
}

#Preview("Compact") {
    struct PreviewWrapper: View {
        @State private var mode: SymbolRenderingMode = .hierarchical

        var body: some View {
            CompactRenderingModePicker(selectedMode: $mode)
        }
    }

    return PreviewWrapper()
}
