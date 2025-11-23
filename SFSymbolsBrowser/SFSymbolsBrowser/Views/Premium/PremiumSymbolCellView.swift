import SwiftUI
import SFSafeSymbols

/// Premium symbol cell with micro-interactions and delightful animations
struct PremiumSymbolCellView: View {
    let symbol: SymbolItem
    let isFavorite: Bool
    var onFavoriteToggle: (() -> Void)?

    @State private var isPressed = false
    @State private var isHovering = false
    @State private var showFavoriteAnimation = false

    var body: some View {
        VStack(spacing: DesignSystem.Spacing.sm) {
            // Symbol with animations
            symbolContent
                .frame(width: 44, height: 44)

            // Name label
            Text(symbol.name)
                .font(.caption2)
                .lineLimit(1)
                .foregroundStyle(.primary.opacity(0.8))
        }
        .padding(DesignSystem.Spacing.sm)
        .frame(minWidth: 72, minHeight: 88)
        .background(cellBackground)
        .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous))
        .scaleEffect(isPressed ? 0.92 : (isHovering ? 1.02 : 1.0))
        .animation(DesignSystem.Animation.snappy, value: isPressed)
        .animation(DesignSystem.Animation.gentle, value: isHovering)
        .onLongPressGesture(minimumDuration: 0.5, pressing: { pressing in
            isPressed = pressing
            if pressing {
                HapticManager.shared.lightTap()
            }
        }, perform: {
            onFavoriteToggle?()
            showFavoriteAnimation = true
            HapticManager.shared.success()
        })
        .sensoryFeedback(.selection, trigger: isHovering)
        .overlay(alignment: .topTrailing) {
            favoriteIndicator
        }
        .accessibilityLabel("\(symbol.name)\(isFavorite ? ", favorite" : "")")
        .accessibilityHint("Double tap to view details, long press to toggle favorite")
    }

    // MARK: - Symbol Content with PhaseAnimator
    @ViewBuilder
    private var symbolContent: some View {
        if #available(iOS 17.0, *) {
            PhaseAnimator([false, true], trigger: showFavoriteAnimation) { phase in
                Image(systemName: symbol.name)
                    .font(.title2)
                    .fontWeight(.medium)
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(symbolGradient)
                    .scaleEffect(phase && showFavoriteAnimation ? 1.3 : 1.0)
                    .rotationEffect(.degrees(phase && showFavoriteAnimation ? 10 : 0))
            } animation: { phase in
                phase ? .spring(response: 0.3, dampingFraction: 0.5) : .spring(response: 0.4, dampingFraction: 0.7)
            }
            .onChange(of: showFavoriteAnimation) { _, newValue in
                if newValue {
                    Task {
                        try? await Task.sleep(nanoseconds: 500_000_000)
                        showFavoriteAnimation = false
                    }
                }
            }
        } else {
            Image(systemName: symbol.name)
                .font(.title2)
                .fontWeight(.medium)
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(symbolGradient)
        }
    }

    // MARK: - Cell Background
    private var cellBackground: some View {
        ZStack {
            // Base background with subtle gradient
            RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                .fill(.background)

            // Hover/press highlight
            RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color.accentColor.opacity(isHovering ? 0.1 : 0),
                            Color.accentColor.opacity(isHovering ? 0.05 : 0)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )

            // Subtle border
            RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                .strokeBorder(
                    LinearGradient(
                        colors: [
                            Color.primary.opacity(0.08),
                            Color.primary.opacity(0.04)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 0.5
                )
        }
        .shadow(
            color: .black.opacity(isPressed ? 0.02 : (isHovering ? 0.08 : 0.04)),
            radius: isPressed ? 2 : (isHovering ? 12 : 6),
            x: 0,
            y: isPressed ? 1 : (isHovering ? 6 : 3)
        )
    }

    // MARK: - Symbol Gradient
    private var symbolGradient: LinearGradient {
        LinearGradient(
            colors: isFavorite
                ? [Color.orange, Color.pink]
                : [Color.primary.opacity(0.9), Color.primary.opacity(0.7)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // MARK: - Favorite Indicator
    @ViewBuilder
    private var favoriteIndicator: some View {
        if isFavorite {
            Image(systemSymbol: .heartFill)
                .font(.caption2)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.pink, .red],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .padding(6)
                .transition(.scale.combined(with: .opacity))
                .animation(DesignSystem.Animation.bouncy, value: isFavorite)
        }
    }
}

// MARK: - Premium Symbol Cell with Selection
struct SelectablePremiumSymbolCellView: View {
    let symbol: SymbolItem
    let isFavorite: Bool
    let isSelected: Bool
    let onSelect: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: {
            onSelect()
            HapticManager.shared.selection()
        }) {
            ZStack(alignment: .topLeading) {
                PremiumSymbolCellView(symbol: symbol, isFavorite: isFavorite)

                // Selection indicator
                Circle()
                    .fill(isSelected ? Color.accentColor : Color.clear)
                    .frame(width: 22, height: 22)
                    .overlay(
                        Circle()
                            .strokeBorder(
                                isSelected ? Color.accentColor : Color.secondary.opacity(0.5),
                                lineWidth: 1.5
                            )
                    )
                    .overlay(
                        Image(systemSymbol: .checkmark)
                            .font(.caption2.bold())
                            .foregroundStyle(.white)
                            .opacity(isSelected ? 1 : 0)
                    )
                    .padding(6)
                    .scaleEffect(isSelected ? 1.0 : 0.9)
                    .animation(DesignSystem.Animation.bouncy, value: isSelected)
            }
        }
        .buttonStyle(PremiumCellButtonStyle())
    }
}

// MARK: - Custom Button Style
struct PremiumCellButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.94 : 1.0)
            .animation(DesignSystem.Animation.snappy, value: configuration.isPressed)
    }
}

#Preview {
    VStack(spacing: 20) {
        HStack(spacing: 16) {
            PremiumSymbolCellView(symbol: SymbolItem(symbol: .heartFill, category: .health), isFavorite: false)
            PremiumSymbolCellView(symbol: SymbolItem(symbol: .heartFill, category: .health), isFavorite: true)
        }

        HStack(spacing: 16) {
            SelectablePremiumSymbolCellView(
                symbol: SymbolItem(symbol: .heartFill, category: .health),
                isFavorite: false,
                isSelected: false,
                onSelect: {}
            )
            SelectablePremiumSymbolCellView(
                symbol: SymbolItem(symbol: .heartFill, category: .health),
                isFavorite: true,
                isSelected: true,
                onSelect: {}
            )
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
