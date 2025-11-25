import SwiftUI
import SFSymbols

/// A single cell in the symbol grid
struct SymbolCellView: View {
    let symbol: SymbolItem
    var isFavorite: Bool = false

    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                Image(symbol: symbol.symbol)
                    .font(.system(size: 28))
                    .foregroundStyle(.primary)
                    .frame(width: 48, height: 48)

                if isFavorite {
                    Image(symbol: .starFill)
                        .font(.system(size: 8))
                        .foregroundStyle(.yellow)
                        .offset(x: 4, y: -4)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
        .accessibilityLabel(symbol.name)
        .accessibilityHint("Double tap to view details")
    }
}

// MARK: - Large Cell Variant (for iPad)
struct SymbolCellLargeView: View {
    let symbol: SymbolItem
    var isFavorite: Bool = false

    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Image(symbol: symbol.symbol)
                    .font(.system(size: 36))
                    .foregroundStyle(.primary)
                    .frame(width: 56, height: 56)

                if isFavorite {
                    Image(symbol: .starFill)
                        .font(.system(size: 10))
                        .foregroundStyle(.yellow)
                        .offset(x: 4, y: -4)
                }
            }

            Text(symbol.name)
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .truncationMode(.middle)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .padding(.horizontal, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.secondarySystemBackground))
        )
        .accessibilityLabel(symbol.name)
        .accessibilityHint("Double tap to view details")
    }
}

#Preview("Standard") {
    HStack {
        SymbolCellView(symbol: SymbolItem(symbol: .heart))
        SymbolCellView(symbol: SymbolItem(symbol: .star), isFavorite: true)
        SymbolCellView(symbol: SymbolItem(symbol: .gear))
    }
    .padding()
}

#Preview("Large") {
    HStack {
        SymbolCellLargeView(symbol: SymbolItem(symbol: .heart))
        SymbolCellLargeView(symbol: SymbolItem(symbol: .star), isFavorite: true)
    }
    .padding()
}
