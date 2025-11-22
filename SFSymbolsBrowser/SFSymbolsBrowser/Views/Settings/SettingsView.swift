import SwiftUI

/// Settings view for app configuration (MVP version - minimal)
struct SettingsView: View {
    @Environment(PersistenceService.self) private var persistence

    var body: some View {
        Form {
            Section("Export Defaults") {
                Picker("Default Scale", selection: defaultScaleBinding) {
                    Text("@1x").tag(ExportScale.x1)
                    Text("@2x").tag(ExportScale.x2)
                    Text("@3x").tag(ExportScale.x3)
                }

                Picker("Default Weight", selection: defaultWeightBinding) {
                    ForEach(Font.Weight.allWeights, id: \.self) { weight in
                        Text(weight.displayName).tag(weight)
                    }
                }
            }

            Section("Display") {
                Picker("Symbol Size", selection: symbolSizeBinding) {
                    ForEach(SymbolSize.allCases) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
            }

            Section("About") {
                LabeledContent("Version", value: "1.0.0")
                LabeledContent("SF Symbols", value: "6.0+")

                Link(destination: URL(string: "https://github.com")!) {
                    Label("Send Feedback", systemImage: "envelope")
                }

                Link(destination: URL(string: "https://apps.apple.com")!) {
                    Label("Rate App", systemImage: "star")
                }
            }
        }
        .navigationTitle("Settings")
    }

    // MARK: - Bindings
    private var defaultScaleBinding: Binding<ExportScale> {
        Binding(
            get: { persistence.settings.defaultScales.first ?? .x2 },
            set: { persistence.settings.defaultScales = [$0] }
        )
    }

    private var defaultWeightBinding: Binding<Font.Weight> {
        Binding(
            get: { persistence.settings.defaultWeight },
            set: { persistence.settings.defaultWeight = $0 }
        )
    }

    private var symbolSizeBinding: Binding<SymbolSize> {
        Binding(
            get: { persistence.settings.symbolSize },
            set: { persistence.settings.symbolSize = $0 }
        )
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environment(PersistenceService())
}
