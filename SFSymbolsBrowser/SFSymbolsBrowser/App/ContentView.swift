import SwiftUI

/// Root content view that switches between iPhone and iPad layouts
/// Also supports Premium UI toggle for enhanced animations and effects
struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @AppStorage("usePremiumUI") private var usePremiumUI = true

    var body: some View {
        Group {
            if usePremiumUI {
                // Premium UI with enhanced animations
                if horizontalSizeClass == .regular {
                    PremiumiPadSidebarView()
                } else {
                    PremiumMainTabView()
                }
            } else {
                // Standard UI
                if horizontalSizeClass == .regular {
                    iPadSidebarView()
                } else {
                    MainTabView()
                }
            }
        }
        .animation(DesignSystem.Animation.smooth, value: usePremiumUI)
    }
}

#Preview("iPhone - Premium") {
    ContentView()
        .environment(PersistenceService())
        .environment(\.horizontalSizeClass, .compact)
}

#Preview("iPhone - Standard") {
    ContentView()
        .environment(PersistenceService())
        .environment(\.horizontalSizeClass, .compact)
}

#Preview("iPad - Premium") {
    ContentView()
        .environment(PersistenceService())
        .environment(\.horizontalSizeClass, .regular)
}
