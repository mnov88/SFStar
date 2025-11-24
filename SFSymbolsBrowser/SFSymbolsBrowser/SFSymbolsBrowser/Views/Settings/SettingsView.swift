import SwiftUI
import SFSafeSymbols

/// Settings view for app configuration
struct SettingsView: View {
    @Environment(PersistenceService.self) private var persistence
    @State private var showingResetConfirmation = false

    var body: some View {
        Form {
            // Export Defaults Section
            Section {
                Picker("Default Format", selection: formatBinding) {
                    Text("PNG").tag(ExportFormat.png)
                    Text("SVG").tag(ExportFormat.svg)
                }

                NavigationLink {
                    ExportScalesSettingsView()
                } label: {
                    HStack {
                        Text("Default Scales")
                        Spacer()
                        Text(scalesDescription)
                            .foregroundStyle(.secondary)
                    }
                }

                Picker("Default Weight", selection: weightBinding) {
                    ForEach(Font.Weight.allWeights, id: \.self) { weight in
                        Text(weight.displayName).tag(weight)
                    }
                }
            } header: {
                Text("Export Defaults")
            } footer: {
                Text("These settings are used as defaults when exporting symbols.")
            }

            // Compatibility Section
            Section {
                Picker("Target iOS", selection: targetIOSBinding) {
                    Text("iOS 13.0").tag(13.0)
                    Text("iOS 14.0").tag(14.0)
                    Text("iOS 15.0").tag(15.0)
                    Text("iOS 16.0").tag(16.0)
                    Text("iOS 17.0").tag(17.0)
                    Text("iOS 18.0").tag(18.0)
                }

                Toggle("Show Compatibility Badge", isOn: showBadgeBinding)
            } header: {
                Text("Compatibility")
            } footer: {
                Text("Filter symbols and show badges based on iOS version compatibility.")
            }

            // Display Section
            Section {
                Picker("Grid Columns", selection: columnsBinding) {
                    Text("Auto").tag(0)
                    Text("3").tag(3)
                    Text("4").tag(4)
                    Text("5").tag(5)
                    Text("6").tag(6)
                }

                Picker("Symbol Size", selection: sizeBinding) {
                    ForEach(SymbolSize.allCases) { size in
                        Text(size.rawValue).tag(size)
                    }
                }
            } header: {
                Text("Display")
            }

            // Data Section
            Section {
                Button(role: .destructive) {
                    showingResetConfirmation = true
                } label: {
                    Label("Reset All Settings", systemSymbol: .arrowCounterclockwise)
                }

                NavigationLink {
                    DataManagementView()
                } label: {
                    Label("Manage Data", systemSymbol: .externaldrive)
                }
            } header: {
                Text("Data")
            }

            // About Section
            Section {
                LabeledContent("App Version", value: "1.0.0")
                LabeledContent("SF Symbols", value: "6.0+")
                LabeledContent("Build", value: "MVP")

                Link(destination: URL(string: "https://github.com")!) {
                    Label("Send Feedback", systemSymbol: .envelope)
                }

                Link(destination: URL(string: "https://developer.apple.com/sf-symbols/")!) {
                    Label("SF Symbols Documentation", systemSymbol: .questionmarkCircle)
                }
            } header: {
                Text("About")
            }
        }
        .navigationTitle("Settings")
        .confirmationDialog(
            "Reset All Settings?",
            isPresented: $showingResetConfirmation,
            titleVisibility: .visible
        ) {
            Button("Reset", role: .destructive) {
                persistence.settings = .default
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This will reset all settings to their default values. Your favorites and collections will not be affected.")
        }
    }

    // MARK: - Bindings
    private var formatBinding: Binding<ExportFormat> {
        Binding(
            get: { persistence.settings.defaultExportFormat },
            set: { persistence.settings.defaultExportFormat = $0 }
        )
    }

    private var weightBinding: Binding<Font.Weight> {
        Binding(
            get: { persistence.settings.defaultWeight },
            set: { persistence.settings.defaultWeight = $0 }
        )
    }

    private var targetIOSBinding: Binding<Double> {
        Binding(
            get: { persistence.settings.targetIOSVersion },
            set: { persistence.settings.targetIOSVersion = $0 }
        )
    }

    private var showBadgeBinding: Binding<Bool> {
        Binding(
            get: { persistence.settings.showCompatibilityBadge },
            set: { persistence.settings.showCompatibilityBadge = $0 }
        )
    }

    private var columnsBinding: Binding<Int> {
        Binding(
            get: { persistence.settings.gridColumns },
            set: { persistence.settings.gridColumns = $0 }
        )
    }

    private var sizeBinding: Binding<SymbolSize> {
        Binding(
            get: { persistence.settings.symbolSize },
            set: { persistence.settings.symbolSize = $0 }
        )
    }

    private var scalesDescription: String {
        let scales = persistence.settings.defaultScales.sorted()
        if scales.isEmpty {
            return "None"
        }
        return scales.map { $0.label }.joined(separator: ", ")
    }
}

// MARK: - Export Scales Settings
struct ExportScalesSettingsView: View {
    @Environment(PersistenceService.self) private var persistence

    var body: some View {
        Form {
            Section {
                ForEach(ExportScale.allCases) { scale in
                    Toggle(scale.label, isOn: scaleBinding(for: scale))
                }
            } footer: {
                Text("Select which scales to include when exporting PNG files.")
            }
        }
        .navigationTitle("Export Scales")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func scaleBinding(for scale: ExportScale) -> Binding<Bool> {
        Binding(
            get: { persistence.settings.defaultScales.contains(scale) },
            set: { isOn in
                if isOn {
                    persistence.settings.defaultScales.insert(scale)
                } else {
                    persistence.settings.defaultScales.remove(scale)
                }
            }
        )
    }
}

// MARK: - Data Management View
struct DataManagementView: View {
    @Environment(PersistenceService.self) private var persistence
    @State private var showingClearFavorites = false
    @State private var showingClearCollections = false
    @State private var showingClearAll = false

    var body: some View {
        Form {
            Section {
                LabeledContent("Favorites", value: "\(persistence.favoriteSymbolNames.count)")
                LabeledContent("Collections", value: "\(persistence.collections.count)")

                let totalInCollections = persistence.collections.reduce(0) { $0 + $1.symbolNames.count }
                LabeledContent("Symbols in Collections", value: "\(totalInCollections)")
            } header: {
                Text("Statistics")
            }

            Section {
                Button(role: .destructive) {
                    showingClearFavorites = true
                } label: {
                    Label("Clear All Favorites", systemSymbol: .starSlash)
                }
                .disabled(persistence.favoriteSymbolNames.isEmpty)

                Button(role: .destructive) {
                    showingClearCollections = true
                } label: {
                    Label("Delete All Collections", systemSymbol: .folderBadgeMinus)
                }
                .disabled(persistence.collections.isEmpty)

                Button(role: .destructive) {
                    showingClearAll = true
                } label: {
                    Label("Clear All Data", systemSymbol: .trash)
                }
            } header: {
                Text("Clear Data")
            } footer: {
                Text("These actions cannot be undone.")
            }
        }
        .navigationTitle("Manage Data")
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog("Clear Favorites?", isPresented: $showingClearFavorites) {
            Button("Clear All Favorites", role: .destructive) {
                persistence.favoriteSymbolNames.removeAll()
            }
        }
        .confirmationDialog("Delete Collections?", isPresented: $showingClearCollections) {
            Button("Delete All Collections", role: .destructive) {
                persistence.collections.removeAll()
            }
        }
        .confirmationDialog("Clear All Data?", isPresented: $showingClearAll) {
            Button("Clear Everything", role: .destructive) {
                persistence.favoriteSymbolNames.removeAll()
                persistence.collections.removeAll()
                persistence.settings = .default
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
    .environment(PersistenceService())
}
