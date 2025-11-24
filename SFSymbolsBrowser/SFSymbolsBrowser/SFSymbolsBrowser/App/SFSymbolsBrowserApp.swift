import SwiftUI

@main
struct SFSymbolsBrowserApp: App {
    @State private var persistenceService = PersistenceService()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(persistenceService)
        }
    }
}
