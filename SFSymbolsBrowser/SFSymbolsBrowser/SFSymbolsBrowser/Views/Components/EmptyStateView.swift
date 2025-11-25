import SwiftUI
import SFSymbols

/// A view displayed when there's no content to show
struct EmptyStateView: View {
    let title: String
    let message: String
    let icon: SFSymbol
    var actionTitle: String? = nil
    var action: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 16) {
            Image(symbol: icon)
                .font(.system(size: 48))
                .foregroundStyle(.secondary)

            VStack(spacing: 8) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)

                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            if let actionTitle = actionTitle, let action = action {
                Button(actionTitle, action: action)
                    .buttonStyle(.bordered)
                    .padding(.top, 8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - Preset Empty States
extension EmptyStateView {
    static var noSearchResults: EmptyStateView {
        EmptyStateView(
            title: "No Results",
            message: "Try a different search term or check the spelling",
            icon: .magnifyingglassCircle
        )
    }

    static var noFavorites: EmptyStateView {
        EmptyStateView(
            title: "No Favorites",
            message: "Tap the star icon on any symbol to add it to your favorites",
            icon: .star
        )
    }

    static func noSymbolsInCategory(_ category: SymbolCategory) -> EmptyStateView {
        EmptyStateView(
            title: "No Symbols",
            message: "No symbols found in \(category.rawValue)",
            icon: .squareGrid2x2
        )
    }
}

#Preview {
    VStack(spacing: 40) {
        EmptyStateView.noSearchResults

        EmptyStateView(
            title: "Custom Empty State",
            message: "This is a custom message with an action button",
            icon: .questionmarkCircle,
            actionTitle: "Take Action"
        ) {
            print("Action tapped")
        }
    }
}
