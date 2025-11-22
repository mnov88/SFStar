import SwiftUI

/// Root content view that switches between iPhone and iPad layouts
struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .regular {
            iPadSidebarView()
        } else {
            MainTabView()
        }
    }
}

#Preview("iPhone") {
    ContentView()
        .environment(PersistenceService())
        .environment(\.horizontalSizeClass, .compact)
}

#Preview("iPad") {
    ContentView()
        .environment(PersistenceService())
        .environment(\.horizontalSizeClass, .regular)
}
