import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .regular {
            iPadMainView()
        } else {
            iPhoneMainView()
        }
    }
}

// MARK: - iPhone Layout
struct iPhoneMainView: View {
    var body: some View {
        NavigationStack {
            SymbolGridView()
        }
    }
}

// MARK: - iPad Layout
struct iPadMainView: View {
    @State private var columnVisibility: NavigationSplitViewVisibility = .all

    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            List {
                NavigationLink {
                    SymbolGridView()
                } label: {
                    Label("All Symbols", systemImage: "square.grid.2x2")
                }
            }
            .navigationTitle("SF Symbols")
        } detail: {
            SymbolGridView()
        }
    }
}

#Preview {
    ContentView()
        .environment(PersistenceService())
}
