import SwiftUI
import SFSafeSymbols

/// Sheet for configuring and executing symbol exports with multi-scale support
struct ExportOptionsSheet: View {
    let symbol: SymbolItem
    let weight: Font.Weight
    let color: Color
    let renderingMode: SymbolRenderingMode

    @Environment(\.dismiss) private var dismiss
    @Environment(PersistenceService.self) private var persistence

    @State private var selectedFormat: ExportFormat = .png
    @State private var selectedScales: Set<ExportScale> = [.x2]
    @State private var isExporting = false
    @State private var exportResult: ExportResult?

    private var exportService = ExportService()

    init(symbol: SymbolItem, weight: Font.Weight, color: Color, renderingMode: SymbolRenderingMode) {
        self.symbol = symbol
        self.weight = weight
        self.color = color
        self.renderingMode = renderingMode
    }

    private var exportCount: Int {
        selectedFormat == .png ? selectedScales.count : 1
    }

    private var canExport: Bool {
        selectedFormat == .svg || !selectedScales.isEmpty
    }

    var body: some View {
        NavigationStack {
            Form {
                // Preview section
                Section {
                    previewRow
                }

                // Format section
                Section("Format") {
                    Picker("Format", selection: $selectedFormat) {
                        ForEach(ExportFormat.allCases) { format in
                            Text(format.rawValue).tag(format)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                // Scales section (PNG only)
                if selectedFormat == .png {
                    Section("Scales") {
                        ForEach(ExportScale.allCases) { scale in
                            Toggle(isOn: scaleBinding(for: scale)) {
                                HStack {
                                    Text(scale.label)
                                    Spacer()
                                    Text("\(scale.pixelSize)×\(scale.pixelSize) px")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                    }
                }

                // File info section
                Section("Output") {
                    ForEach(fileNames, id: \.self) { fileName in
                        HStack {
                            Image(systemSymbol: .docFill)
                                .foregroundStyle(.secondary)
                            Text(fileName)
                                .font(.subheadline.monospaced())
                        }
                    }
                }

                // Export button section
                Section {
                    Button {
                        performExport()
                    } label: {
                        HStack {
                            Spacer()
                            if isExporting {
                                ProgressView()
                                    .padding(.trailing, 8)
                            }
                            Text(isExporting ? "Exporting..." : "Export \(exportCount) File\(exportCount == 1 ? "" : "s")")
                                .font(.headline)
                            Spacer()
                        }
                    }
                    .disabled(!canExport || isExporting)
                }
            }
            .navigationTitle("Export Options")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Export Complete", isPresented: .init(
                get: { exportResult?.isSuccess == true },
                set: { if !$0 { exportResult = nil } }
            )) {
                Button("Done") {
                    dismiss()
                }
            } message: {
                Text("Files saved to Documents/SF Symbols Export/")
            }
            .alert("Export Failed", isPresented: .init(
                get: { exportResult?.isFailure == true },
                set: { if !$0 { exportResult = nil } }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                if case .failure(let error) = exportResult {
                    Text(error.localizedDescription)
                }
            }
        }
        .onAppear {
            // Use user's default scales from settings
            selectedScales = persistence.settings.defaultScales
            selectedFormat = persistence.settings.defaultExportFormat
        }
    }

    // MARK: - Preview Row
    private var previewRow: some View {
        HStack(spacing: 16) {
            Image(systemName: symbol.name)
                .font(.system(size: 40))
                .fontWeight(weight)
                .symbolRenderingMode(renderingMode)
                .foregroundStyle(color)
                .frame(width: 60, height: 60)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(symbol.name)
                    .font(.headline)
                Text("Weight: \(weight.displayName)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: - Scale Binding
    private func scaleBinding(for scale: ExportScale) -> Binding<Bool> {
        Binding(
            get: { selectedScales.contains(scale) },
            set: { isOn in
                if isOn {
                    selectedScales.insert(scale)
                } else {
                    selectedScales.remove(scale)
                }
            }
        )
    }

    // MARK: - File Names
    private var fileNames: [String] {
        if selectedFormat == .svg {
            return ["\(symbol.name).svg"]
        }

        return selectedScales.sorted().map { scale in
            "\(symbol.name)\(scale.fileSuffix).png"
        }
    }

    // MARK: - Export Action
    private func performExport() {
        isExporting = true

        Task {
            do {
                if selectedFormat == .png {
                    for scale in selectedScales.sorted() {
                        let _ = try await exportService.exportPNG(
                            symbolName: symbol.name,
                            weight: weight,
                            scale: scale,
                            color: UIColor(color),
                            renderingMode: renderingMode
                        )
                    }
                } else {
                    // SVG export (placeholder for now)
                    try await Task.sleep(nanoseconds: 500_000_000)
                }

                await MainActor.run {
                    isExporting = false
                    exportResult = .success(())

                    // Haptic feedback
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)
                }
            } catch {
                await MainActor.run {
                    isExporting = false
                    exportResult = .failure(error)

                    // Error haptic
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.error)
                }
            }
        }
    }
}

// MARK: - Export Result
enum ExportResult {
    case success(Void)
    case failure(Error)

    var isSuccess: Bool {
        if case .success = self { return true }
        return false
    }

    var isFailure: Bool {
        if case .failure = self { return true }
        return false
    }
}

// MARK: - Premium Export Options Sheet
struct PremiumExportOptionsSheet: View {
    let symbol: SymbolItem
    let weight: Font.Weight
    let color: Color
    let renderingMode: SymbolRenderingMode

    @Environment(\.dismiss) private var dismiss
    @Environment(PersistenceService.self) private var persistence

    @State private var selectedFormat: ExportFormat = .png
    @State private var selectedScales: Set<ExportScale> = [.x2]
    @State private var isExporting = false
    @State private var exportSuccess = false
    @State private var animationTrigger = false

    private var exportService = ExportService()

    init(symbol: SymbolItem, weight: Font.Weight, color: Color, renderingMode: SymbolRenderingMode) {
        self.symbol = symbol
        self.weight = weight
        self.color = color
        self.renderingMode = renderingMode
    }

    var body: some View {
        NavigationStack {
            ZStack {
                AnimatedMeshGradient(colors: DesignSystem.Gradient.subtle)
                    .opacity(0.3)
                    .ignoresSafeArea()

                VStack(spacing: DesignSystem.Spacing.lg) {
                    // Preview card
                    premiumPreviewCard
                        .scaleEffect(animationTrigger ? 1.0 : 0.9)
                        .opacity(animationTrigger ? 1.0 : 0)

                    // Format selection
                    premiumFormatPicker

                    // Scale selection (PNG only)
                    if selectedFormat == .png {
                        premiumScalePicker
                    }

                    Spacer()

                    // Export button
                    premiumExportButton
                }
                .padding()
            }
            .navigationTitle("Export")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                selectedScales = persistence.settings.defaultScales
                selectedFormat = persistence.settings.defaultExportFormat
                withAnimation(DesignSystem.Animation.smooth.delay(0.1)) {
                    animationTrigger = true
                }
            }
        }
    }

    // MARK: - Premium Preview Card
    private var premiumPreviewCard: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            Image(systemName: symbol.name)
                .font(.system(size: 64))
                .fontWeight(weight)
                .symbolRenderingMode(renderingMode)
                .foregroundStyle(color)
                .frame(width: 120, height: 120)
                .glassEffect()

            Text(symbol.name)
                .font(.headline.monospaced())
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Premium Format Picker
    private var premiumFormatPicker: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Format")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            HStack(spacing: DesignSystem.Spacing.sm) {
                ForEach(ExportFormat.allCases) { format in
                    Button {
                        withAnimation(DesignSystem.Animation.snappy) {
                            selectedFormat = format
                        }
                        HapticManager.shared.selection()
                    } label: {
                        Text(format.rawValue)
                            .font(.subheadline.weight(selectedFormat == format ? .semibold : .regular))
                            .foregroundStyle(selectedFormat == format ? .white : .primary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, DesignSystem.Spacing.md)
                            .background(
                                RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                                    .fill(selectedFormat == format ? Color.accentColor : Color.secondary.opacity(0.1))
                            )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
        .glassEffect()
    }

    // MARK: - Premium Scale Picker
    private var premiumScalePicker: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            Text("Scales")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            HStack(spacing: DesignSystem.Spacing.sm) {
                ForEach(ExportScale.allCases) { scale in
                    Button {
                        withAnimation(DesignSystem.Animation.snappy) {
                            if selectedScales.contains(scale) {
                                selectedScales.remove(scale)
                            } else {
                                selectedScales.insert(scale)
                            }
                        }
                        HapticManager.shared.selection()
                    } label: {
                        VStack(spacing: 4) {
                            Text(scale.label)
                                .font(.headline)

                            Text("\(scale.pixelSize)px")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, DesignSystem.Spacing.md)
                        .background(
                            RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                                .fill(selectedScales.contains(scale) ? Color.accentColor : Color.secondary.opacity(0.1))
                        )
                        .foregroundStyle(selectedScales.contains(scale) ? .white : .primary)
                        .overlay(
                            RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                                .strokeBorder(selectedScales.contains(scale) ? Color.clear : Color.secondary.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding()
        .glassEffect()
    }

    // MARK: - Premium Export Button
    private var premiumExportButton: some View {
        Button {
            performExport()
        } label: {
            HStack(spacing: DesignSystem.Spacing.sm) {
                if isExporting {
                    ProgressView()
                        .tint(.white)
                } else if exportSuccess {
                    Image(systemSymbol: .checkmark)
                } else {
                    Image(systemSymbol: .squareAndArrowUp)
                }

                Text(exportSuccess ? "Exported!" : "Export \(selectedScales.count) File\(selectedScales.count == 1 ? "" : "s")")
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    colors: exportSuccess ? [.green, .mint] : DesignSystem.Gradient.ocean,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .shadow(color: exportSuccess ? .green.opacity(0.3) : .blue.opacity(0.3), radius: 10, y: 4)
        }
        .disabled(selectedScales.isEmpty || isExporting)
        .buttonStyle(PremiumCellButtonStyle())
    }

    // MARK: - Export Action
    private func performExport() {
        isExporting = true
        HapticManager.shared.lightTap()

        Task {
            // Simulate export for each scale
            for scale in selectedScales.sorted() {
                try? await Task.sleep(nanoseconds: 300_000_000)
            }

            await MainActor.run {
                isExporting = false
                exportSuccess = true
                HapticManager.shared.celebration()
            }

            try? await Task.sleep(nanoseconds: 1_500_000_000)
            await MainActor.run {
                dismiss()
            }
        }
    }
}

#Preview {
    ExportOptionsSheet(
        symbol: SymbolItem(symbol: .heartFill, category: .general),
        weight: .regular,
        color: .pink,
        renderingMode: .hierarchical
    )
    .environment(PersistenceService())
}

#Preview("Premium") {
    PremiumExportOptionsSheet(
        symbol: SymbolItem(symbol: .heartFill, category: .general),
        weight: .regular,
        color: .pink,
        renderingMode: .hierarchical
    )
    .environment(PersistenceService())
}
