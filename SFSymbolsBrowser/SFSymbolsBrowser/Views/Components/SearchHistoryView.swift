import SwiftUI
import SFSafeSymbols

/// View displaying recent search history with tap-to-search and swipe-to-delete
struct SearchHistoryView: View {
    @Environment(PersistenceService.self) private var persistence
    let onSelect: (String) -> Void

    var body: some View {
        if !persistence.searchHistory.isEmpty {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Recent Searches")
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)

                    Spacer()

                    Button("Clear") {
                        withAnimation {
                            persistence.clearSearchHistory()
                        }
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }

                FlowLayout(spacing: 8) {
                    ForEach(persistence.searchHistory, id: \.self) { query in
                        SearchHistoryChip(query: query) {
                            onSelect(query)
                        } onDelete: {
                            withAnimation {
                                persistence.removeFromSearchHistory(query)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }
}

/// Individual search history chip with tap and delete actions
struct SearchHistoryChip: View {
    let query: String
    let onTap: () -> Void
    let onDelete: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemSymbol: .clock)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(query)
                    .font(.subheadline)
                    .lineLimit(1)

                Button {
                    onDelete()
                } label: {
                    Image(systemSymbol: .xmarkCircleFill)
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.secondarySystemBackground))
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Search for \(query)")
        .accessibilityHint("Double tap to search, or swipe to delete")
    }
}

/// Premium search history view with enhanced styling
struct PremiumSearchHistoryView: View {
    @Environment(PersistenceService.self) private var persistence
    let onSelect: (String) -> Void

    var body: some View {
        if !persistence.searchHistory.isEmpty {
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
                HStack {
                    Label("Recent", systemSymbol: .clockArrowCirclepath)
                        .font(.subheadline.weight(.semibold))
                        .foregroundStyle(.secondary)

                    Spacer()

                    Button {
                        withAnimation(DesignSystem.Animation.snappy) {
                            persistence.clearSearchHistory()
                        }
                        HapticManager.shared.lightTap()
                    } label: {
                        Text("Clear All")
                            .font(.caption.weight(.medium))
                            .foregroundStyle(.secondary)
                    }
                }

                FlowLayout(spacing: DesignSystem.Spacing.sm) {
                    ForEach(persistence.searchHistory, id: \.self) { query in
                        PremiumSearchHistoryChip(query: query) {
                            onSelect(query)
                            HapticManager.shared.selection()
                        } onDelete: {
                            withAnimation(DesignSystem.Animation.snappy) {
                                persistence.removeFromSearchHistory(query)
                            }
                            HapticManager.shared.lightTap()
                        }
                    }
                }
            }
            .padding()
            .glassEffect()
        }
    }
}

/// Premium styled search history chip
struct PremiumSearchHistoryChip: View {
    let query: String
    let onTap: () -> Void
    let onDelete: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemSymbol: .magnifyingglass)
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                Text(query)
                    .font(.subheadline)
                    .lineLimit(1)

                Button {
                    onDelete()
                } label: {
                    Image(systemSymbol: .xmarkCircleFill)
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                Capsule()
                    .fill(.ultraThinMaterial)
            )
            .overlay(
                Capsule()
                    .strokeBorder(Color.primary.opacity(0.1), lineWidth: 0.5)
            )
        }
        .buttonStyle(.plain)
        .scaleEffect(isPressed ? 0.95 : 1.0)
        .animation(DesignSystem.Animation.snappy, value: isPressed)
        .accessibilityLabel("Search for \(query)")
        .accessibilityHint("Double tap to search")
    }
}

/// Flow layout for wrapping chips
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrangeSubviews(proposal: proposal, subviews: subviews)

        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: ProposedViewSize(result.sizes[index])
            )
        }
    }

    private func arrangeSubviews(proposal: ProposedViewSize, subviews: Subviews) -> ArrangementResult {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var sizes: [CGSize] = []
        var currentX: CGFloat = 0
        var currentY: CGFloat = 0
        var lineHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            sizes.append(size)

            if currentX + size.width > maxWidth && currentX > 0 {
                currentX = 0
                currentY += lineHeight + spacing
                lineHeight = 0
            }

            positions.append(CGPoint(x: currentX, y: currentY))
            lineHeight = max(lineHeight, size.height)
            currentX += size.width + spacing
        }

        let totalHeight = currentY + lineHeight
        return ArrangementResult(
            size: CGSize(width: maxWidth, height: totalHeight),
            positions: positions,
            sizes: sizes
        )
    }

    private struct ArrangementResult {
        let size: CGSize
        let positions: [CGPoint]
        let sizes: [CGSize]
    }
}

#Preview {
    VStack {
        SearchHistoryView { query in
            print("Selected: \(query)")
        }

        PremiumSearchHistoryView { query in
            print("Selected: \(query)")
        }
    }
    .environment(PersistenceService())
}
