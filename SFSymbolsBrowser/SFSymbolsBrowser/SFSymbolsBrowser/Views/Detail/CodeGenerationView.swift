import SwiftUI
import SFSymbols

/// View for generating and copying SwiftUI/UIKit code for symbols
struct CodeGenerationView: View {
    let symbol: SymbolItem
    let weight: Font.Weight
    let color: Color
    let renderingMode: RenderingMode
    var effectConfiguration: SymbolEffectConfiguration? = nil

    @Environment(\.dismiss) private var dismiss
    @State private var selectedFramework: CodeGenerationService.Framework = .swiftUI
    @State private var showCopiedToast = false

    private let codeGenerator = CodeGenerationService()

    private var generatedCode: String {
        codeGenerator.generateCode(
            symbolName: symbol.name,
            weight: weight,
            color: color,
            renderingMode: renderingMode,
            size: 32,
            framework: selectedFramework,
            effectConfiguration: effectConfiguration
        )
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Preview section
                previewSection
                    .padding()

                Divider()

                // Framework picker
                frameworkPicker
                    .padding()

                // Code display
                codeDisplay
                    .padding(.horizontal)

                Spacer()

                // Copy button
                copyButton
                    .padding()
            }
            .navigationTitle("Generate Code")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .overlay(alignment: .bottom) {
                if showCopiedToast {
                    copiedToast
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .padding(.bottom, 80)
                }
            }
        }
    }

    // MARK: - Preview Section
    private var previewSection: some View {
        HStack(spacing: 16) {
            // Symbol preview
            Image(systemName: symbol.name)
                .font(.system(size: 48))
                .fontWeight(weight)
                .symbolRenderingMode(renderingMode.swiftUIMode)
                .foregroundStyle(color)
                .frame(width: 80, height: 80)
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))

            // Configuration summary
            VStack(alignment: .leading, spacing: 4) {
                Text(symbol.name)
                    .font(.headline)

                Text("Weight: \(weight.displayName)")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("Mode: \(renderingMode.displayName)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
    }

    // MARK: - Framework Picker
    private var frameworkPicker: some View {
        Picker("Framework", selection: $selectedFramework) {
            ForEach(CodeGenerationService.Framework.allCases) { framework in
                Text(framework.rawValue).tag(framework)
            }
        }
        .pickerStyle(.segmented)
    }

    // MARK: - Code Display
    private var codeDisplay: some View {
        ScrollView {
            Text(generatedCode)
                .font(.system(.body, design: .monospaced))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.secondarySystemBackground))
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .textSelection(.enabled)
        }
    }

    // MARK: - Copy Button
    private var copyButton: some View {
        Button {
            copyCode()
        } label: {
            Label("Copy Code", symbol: .docOnDoc)
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
    }

    // MARK: - Copied Toast
    private var copiedToast: some View {
        HStack(spacing: 8) {
            Image(symbol: .checkmarkCircleFill)
                .foregroundStyle(.green)

            Text("Copied to clipboard")
                .font(.subheadline.weight(.medium))
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(.ultraThinMaterial)
        .clipShape(Capsule())
    }

    // MARK: - Actions
    private func copyCode() {
        UIPasteboard.general.string = generatedCode

        // Haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

        // Show toast
        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
            showCopiedToast = true
        }

        // Hide toast after delay
        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation(.easeOut(duration: 0.3)) {
                showCopiedToast = false
            }
        }
    }
}

// MARK: - Premium Code Generation View
struct PremiumCodeGenerationView: View {
    let symbol: SymbolItem
    let weight: Font.Weight
    let color: Color
    let renderingMode: RenderingMode
    var effectConfiguration: SymbolEffectConfiguration? = nil

    @Environment(\.dismiss) private var dismiss
    @State private var selectedFramework: CodeGenerationService.Framework = .swiftUI
    @State private var showCopiedToast = false
    @State private var codeAnimationTrigger = false

    private let codeGenerator = CodeGenerationService()

    private var generatedCode: String {
        codeGenerator.generateCode(
            symbolName: symbol.name,
            weight: weight,
            color: color,
            renderingMode: renderingMode,
            size: 32,
            framework: selectedFramework,
            effectConfiguration: effectConfiguration
        )
    }

    var body: some View {
        NavigationStack {
            ZStack {
                // Subtle background
                AnimatedMeshGradient(colors: DesignSystem.Gradient.subtle)
                    .opacity(0.3)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    // Preview section
                    premiumPreviewSection
                        .padding()

                    // Framework picker
                    premiumFrameworkPicker
                        .padding(.horizontal)

                    // Code display
                    premiumCodeDisplay
                        .padding()

                    Spacer()

                    // Copy button
                    premiumCopyButton
                        .padding()
                }
            }
            .navigationTitle("Generate Code")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
            .overlay(alignment: .bottom) {
                if showCopiedToast {
                    premiumCopiedToast
                        .transition(.scale.combined(with: .opacity))
                        .padding(.bottom, 100)
                }
            }
            .onAppear {
                withAnimation(DesignSystem.Animation.smooth.delay(0.2)) {
                    codeAnimationTrigger = true
                }
            }
        }
    }

    // MARK: - Premium Preview Section
    private var premiumPreviewSection: some View {
        VStack(spacing: DesignSystem.Spacing.md) {
            // Symbol in glass card
            Image(systemName: symbol.name)
                .font(.system(size: 56))
                .fontWeight(weight)
                .symbolRenderingMode(renderingMode.swiftUIMode)
                .foregroundStyle(color)
                .frame(width: 100, height: 100)
                .glassEffect()
                .scaleEffect(codeAnimationTrigger ? 1.0 : 0.8)
                .opacity(codeAnimationTrigger ? 1.0 : 0)

            // Symbol name
            Text(symbol.name)
                .font(.title3.monospaced())
                .foregroundStyle(.secondary)
        }
    }

    // MARK: - Premium Framework Picker
    private var premiumFrameworkPicker: some View {
        HStack(spacing: DesignSystem.Spacing.sm) {
            ForEach(CodeGenerationService.Framework.allCases) { framework in
                Button {
                    withAnimation(DesignSystem.Animation.snappy) {
                        selectedFramework = framework
                    }
                    HapticManager.shared.selection()
                } label: {
                    Text(framework.rawValue)
                        .font(.subheadline.weight(selectedFramework == framework ? .semibold : .regular))
                        .foregroundStyle(selectedFramework == framework ? .white : .primary)
                        .padding(.horizontal, DesignSystem.Spacing.lg)
                        .padding(.vertical, DesignSystem.Spacing.sm)
                        .background(
                            Capsule()
                                .fill(selectedFramework == framework ? Color.accentColor : Color.secondary.opacity(0.1))
                        )
                }
                .buttonStyle(.plain)
            }
        }
    }

    // MARK: - Premium Code Display
    private var premiumCodeDisplay: some View {
        ScrollView {
            Text(generatedCode)
                .font(.system(.body, design: .monospaced))
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: DesignSystem.Radius.large, style: .continuous)
                        .fill(.background)
                        .shadow(color: .black.opacity(0.06), radius: 8, y: 2)
                )
                .textSelection(.enabled)
        }
        .opacity(codeAnimationTrigger ? 1.0 : 0)
        .offset(y: codeAnimationTrigger ? 0 : 20)
    }

    // MARK: - Premium Copy Button
    private var premiumCopyButton: some View {
        Button {
            copyCode()
        } label: {
            HStack(spacing: DesignSystem.Spacing.sm) {
                Image(symbol: .docOnDoc)
                Text("Copy Code")
            }
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                LinearGradient(
                    colors: DesignSystem.Gradient.ocean,
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .shadow(color: .blue.opacity(0.3), radius: 10, y: 4)
        }
        .buttonStyle(PremiumCellButtonStyle())
    }

    // MARK: - Premium Copied Toast
    private var premiumCopiedToast: some View {
        HStack(spacing: DesignSystem.Spacing.sm) {
            Image(symbol: .checkmarkCircleFill)
                .foregroundStyle(.green)

            Text("Copied to clipboard")
                .font(.subheadline.weight(.medium))
        }
        .padding(.horizontal, DesignSystem.Spacing.lg)
        .padding(.vertical, DesignSystem.Spacing.md)
        .glassEffect(cornerRadius: DesignSystem.Radius.capsule)
    }

    // MARK: - Actions
    private func copyCode() {
        UIPasteboard.general.string = generatedCode
        HapticManager.shared.celebration()

        withAnimation(DesignSystem.Animation.bouncy) {
            showCopiedToast = true
        }

        Task {
            try? await Task.sleep(nanoseconds: 2_000_000_000)
            withAnimation(DesignSystem.Animation.smooth) {
                showCopiedToast = false
            }
        }
    }
}

#Preview {
    CodeGenerationView(
        symbol: SymbolItem(symbol: .heartFill),
        weight: .semibold,
        color: .pink,
        renderingMode: .hierarchical
    )
}

#Preview("Premium") {
    PremiumCodeGenerationView(
        symbol: SymbolItem(symbol: .heartFill),
        weight: .semibold,
        color: .pink,
        renderingMode: .hierarchical
    )
}
