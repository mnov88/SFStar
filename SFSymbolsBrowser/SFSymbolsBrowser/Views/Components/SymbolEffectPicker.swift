import SwiftUI
import SFSafeSymbols

/// Premium picker for selecting and previewing symbol effects
struct SymbolEffectPicker: View {
    @Binding var configuration: SymbolEffectConfiguration
    let symbolName: String
    let weight: Font.Weight
    let color: Color
    let renderingMode: SymbolRenderingMode

    @State private var effectTrigger = 0

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            // Section header
            HStack {
                Label("Animation Effect", systemImage: "sparkles")
                    .font(.headline)

                Spacer()

                if configuration.effectType != .none {
                    Button {
                        withAnimation(DesignSystem.Animation.snappy) {
                            configuration = SymbolEffectConfiguration()
                        }
                        HapticManager.shared.lightTap()
                    } label: {
                        Text("Reset")
                            .font(.caption.weight(.medium))
                            .foregroundStyle(.secondary)
                    }
                }
            }

            // Effect type selector
            effectTypeSelector

            // Additional options based on effect
            if configuration.effectType != .none {
                additionalOptions
            }

            // Live preview
            if configuration.effectType != .none {
                livePreviewSection
            }
        }
        .padding()
        .glassEffect()
    }

    // MARK: - Effect Type Selector

    private var effectTypeSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: DesignSystem.Spacing.sm) {
                ForEach(SymbolEffectType.availableCases) { effect in
                    EffectTypeButton(
                        effect: effect,
                        isSelected: configuration.effectType == effect
                    ) {
                        withAnimation(DesignSystem.Animation.snappy) {
                            configuration.effectType = effect
                            // Reset direction to valid option for new effect
                            if let firstDir = configuration.availableDirections.first {
                                configuration.direction = firstDir
                            }
                        }
                        HapticManager.shared.selection()
                        triggerEffect()
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }

    // MARK: - Additional Options

    @ViewBuilder
    private var additionalOptions: some View {
        VStack(spacing: DesignSystem.Spacing.sm) {
            // Direction picker
            if configuration.showsDirectionPicker {
                directionPicker
            }

            // Scope picker
            if configuration.supportsScope {
                scopePicker
            }

            // Variable color options
            if configuration.effectType == .variableColor {
                variableColorOptions
            }

            // Breathe style options (iOS 18+)
            if configuration.supportsBreatheStyle {
                breatheStylePicker
            }

            // Speed picker
            speedPicker

            // Repeat option
            repeatPicker
        }
        .transition(.opacity.combined(with: .move(edge: .top)))
    }

    // MARK: - Direction Picker

    private var directionPicker: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            Text("Direction")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: DesignSystem.Spacing.xs) {
                    ForEach(configuration.availableDirections) { direction in
                        OptionChip(
                            title: direction.rawValue,
                            iconName: direction.iconName,
                            isSelected: configuration.direction == direction
                        ) {
                            withAnimation(DesignSystem.Animation.snappy) {
                                configuration.direction = direction
                            }
                            HapticManager.shared.selection()
                            triggerEffect()
                        }
                    }
                }
            }
        }
    }

    // MARK: - Scope Picker

    private var scopePicker: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            Text("Scope")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            HStack(spacing: DesignSystem.Spacing.xs) {
                ForEach(SymbolEffectScope.allCases) { scope in
                    OptionChip(
                        title: scope.rawValue,
                        iconName: scope.iconName,
                        isSelected: configuration.scope == scope
                    ) {
                        withAnimation(DesignSystem.Animation.snappy) {
                            configuration.scope = scope
                        }
                        HapticManager.shared.selection()
                        triggerEffect()
                    }
                }
            }
        }
    }

    // MARK: - Variable Color Options

    private var variableColorOptions: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.sm) {
            // Fill Style
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                Text("Fill Style")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)

                HStack(spacing: DesignSystem.Spacing.xs) {
                    ForEach(VariableColorStyle.allCases) { style in
                        OptionChip(
                            title: style.rawValue,
                            isSelected: configuration.variableColorStyle == style
                        ) {
                            withAnimation(DesignSystem.Animation.snappy) {
                                configuration.variableColorStyle = style
                            }
                            HapticManager.shared.selection()
                            triggerEffect()
                        }
                    }

                    // Reversing toggle
                    OptionChip(
                        title: "Reversing",
                        iconName: "arrow.left.arrow.right",
                        isSelected: configuration.reversing
                    ) {
                        withAnimation(DesignSystem.Animation.snappy) {
                            configuration.reversing.toggle()
                        }
                        HapticManager.shared.selection()
                        triggerEffect()
                    }
                }
            }

            // Inactive Layers (per Apple docs)
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
                Text("Inactive Layers")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.secondary)

                HStack(spacing: DesignSystem.Spacing.xs) {
                    ForEach(VariableColorInactiveStyle.allCases) { style in
                        OptionChip(
                            title: style.rawValue,
                            isSelected: configuration.variableColorInactiveStyle == style
                        ) {
                            withAnimation(DesignSystem.Animation.snappy) {
                                configuration.variableColorInactiveStyle = style
                            }
                            HapticManager.shared.selection()
                            triggerEffect()
                        }
                    }
                }
            }
        }
    }

    // MARK: - Breathe Style Picker

    private var breatheStylePicker: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            Text("Style")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            HStack(spacing: DesignSystem.Spacing.xs) {
                ForEach(BreatheStyle.allCases) { style in
                    OptionChip(
                        title: style.rawValue,
                        isSelected: configuration.breatheStyle == style
                    ) {
                        withAnimation(DesignSystem.Animation.snappy) {
                            configuration.breatheStyle = style
                        }
                        HapticManager.shared.selection()
                        triggerEffect()
                    }
                }
            }
        }
    }

    // MARK: - Speed Picker

    private var speedPicker: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            Text("Speed")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            HStack(spacing: DesignSystem.Spacing.xs) {
                ForEach(SymbolEffectSpeed.allCases) { speed in
                    OptionChip(
                        title: speed.rawValue,
                        isSelected: configuration.speed == speed
                    ) {
                        withAnimation(DesignSystem.Animation.snappy) {
                            configuration.speed = speed
                        }
                        HapticManager.shared.selection()
                        triggerEffect()
                    }
                }
            }
        }
    }

    // MARK: - Repeat Picker

    private var repeatPicker: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.xs) {
            Text("Repeat")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)

            HStack(spacing: DesignSystem.Spacing.xs) {
                ForEach(SymbolEffectRepeat.allCases) { repeatOpt in
                    OptionChip(
                        title: repeatOpt.rawValue,
                        isSelected: configuration.repeatOption == repeatOpt
                    ) {
                        withAnimation(DesignSystem.Animation.snappy) {
                            configuration.repeatOption = repeatOpt
                        }
                        HapticManager.shared.selection()
                        triggerEffect()
                    }
                }
            }
        }
    }

    // MARK: - Live Preview Section

    private var livePreviewSection: some View {
        VStack(spacing: DesignSystem.Spacing.sm) {
            Text("Preview")
                .font(.subheadline.weight(.medium))
                .foregroundStyle(.secondary)
                .frame(maxWidth: .infinity, alignment: .leading)

            // Live animated symbol
            SymbolEffectPreview(
                symbolName: symbolName,
                weight: weight,
                color: color,
                renderingMode: renderingMode,
                configuration: configuration,
                trigger: effectTrigger
            )
            .frame(height: 80)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                    .fill(Color(.secondarySystemBackground))
            )
            .onTapGesture {
                triggerEffect()
            }

            Text("Tap to replay")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
    }

    private func triggerEffect() {
        effectTrigger += 1
    }
}

// MARK: - Effect Type Button

private struct EffectTypeButton: View {
    let effect: SymbolEffectType
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: effect.iconName)
                    .font(.title3)

                Text(effect.rawValue)
                    .font(.caption2)
                    .lineLimit(1)
            }
            .foregroundStyle(isSelected ? .white : .primary)
            .frame(width: 70, height: 56)
            .background(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.small, style: .continuous)
                    .fill(isSelected ? Color.accentColor : Color.secondary.opacity(0.1))
            )
        }
        .buttonStyle(.plain)
        .scaleEffect(isSelected ? 1.02 : 1.0)
        .animation(DesignSystem.Animation.snappy, value: isSelected)
    }
}

// MARK: - Option Chip

private struct OptionChip: View {
    let title: String
    var iconName: String? = nil
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                if let iconName {
                    Image(systemName: iconName)
                        .font(.caption)
                }
                Text(title)
                    .font(.caption)
            }
            .foregroundStyle(isSelected ? .white : .primary)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(isSelected ? Color.accentColor : Color.secondary.opacity(0.1))
            )
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Symbol Effect Preview

struct SymbolEffectPreview: View {
    let symbolName: String
    let weight: Font.Weight
    let color: Color
    let renderingMode: SymbolRenderingMode
    let configuration: SymbolEffectConfiguration
    let trigger: Int

    var body: some View {
        if #available(iOS 17.0, *) {
            symbolWithEffect
        } else {
            // Fallback for older iOS
            Image(systemName: symbolName)
                .font(.system(size: 48))
                .fontWeight(weight)
                .symbolRenderingMode(renderingMode)
                .foregroundStyle(color)
        }
    }

    @available(iOS 17.0, *)
    @ViewBuilder
    private var symbolWithEffect: some View {
        switch configuration.effectType {
        case .none:
            baseSymbol

        case .bounce:
            bounceEffect

        case .pulse:
            pulseEffect

        case .variableColor:
            variableColorEffect

        case .scale:
            scaleEffect

        case .breathe:
            breatheEffect

        case .wiggle:
            wiggleEffect

        case .rotate:
            rotateEffect
        }
    }

    @available(iOS 17.0, *)
    private var baseSymbol: some View {
        Image(systemName: symbolName)
            .font(.system(size: 48))
            .fontWeight(weight)
            .symbolRenderingMode(renderingMode)
            .foregroundStyle(color)
    }

    @available(iOS 17.0, *)
    @ViewBuilder
    private var bounceEffect: some View {
        let effect: BounceSymbolEffect = configuration.direction == .down
            ? .bounce.down
            : .bounce.up

        let scopedEffect = configuration.scope == .byLayer
            ? effect.byLayer
            : effect.wholeSymbol

        Image(systemName: symbolName)
            .font(.system(size: 48))
            .fontWeight(weight)
            .symbolRenderingMode(renderingMode)
            .foregroundStyle(color)
            .symbolEffect(scopedEffect, options: effectOptions, value: trigger)
    }

    @available(iOS 17.0, *)
    @ViewBuilder
    private var pulseEffect: some View {
        let effect: PulseSymbolEffect = configuration.scope == .byLayer
            ? .pulse.byLayer
            : .pulse.wholeSymbol

        if configuration.repeatOption == .continuous {
            Image(systemName: symbolName)
                .font(.system(size: 48))
                .fontWeight(weight)
                .symbolRenderingMode(renderingMode)
                .foregroundStyle(color)
                .symbolEffect(effect, options: effectOptions)
        } else {
            Image(systemName: symbolName)
                .font(.system(size: 48))
                .fontWeight(weight)
                .symbolRenderingMode(renderingMode)
                .foregroundStyle(color)
                .symbolEffect(effect, options: effectOptions, value: trigger)
        }
    }

    @available(iOS 17.0, *)
    @ViewBuilder
    private var variableColorEffect: some View {
        var effect: VariableColorSymbolEffect = .variableColor

        // Apply inactive layer style (per Apple docs)
        switch configuration.variableColorInactiveStyle {
        case .hideInactiveLayers:
            effect = effect.hideInactiveLayers
        case .dimInactiveLayers:
            effect = effect.dimInactiveLayers
        case .normal:
            break
        }

        // Apply fill style
        if configuration.variableColorStyle == .cumulative {
            effect = effect.cumulative
        } else {
            effect = effect.iterative
        }

        // Apply reversing
        if configuration.reversing {
            effect = effect.reversing
        }

        if configuration.repeatOption == .continuous {
            Image(systemName: symbolName)
                .font(.system(size: 48))
                .fontWeight(weight)
                .symbolRenderingMode(renderingMode)
                .foregroundStyle(color)
                .symbolEffect(effect, options: effectOptions)
        } else {
            Image(systemName: symbolName)
                .font(.system(size: 48))
                .fontWeight(weight)
                .symbolRenderingMode(renderingMode)
                .foregroundStyle(color)
                .symbolEffect(effect, options: effectOptions, value: trigger)
        }
    }

    @available(iOS 17.0, *)
    @ViewBuilder
    private var scaleEffect: some View {
        let effect: ScaleSymbolEffect = configuration.direction == .down
            ? .scale.down
            : .scale.up

        let scopedEffect = configuration.scope == .byLayer
            ? effect.byLayer
            : effect.wholeSymbol

        Image(systemName: symbolName)
            .font(.system(size: 48))
            .fontWeight(weight)
            .symbolRenderingMode(renderingMode)
            .foregroundStyle(color)
            .symbolEffect(scopedEffect, options: effectOptions, isActive: true)
    }

    @available(iOS 17.0, *)
    @ViewBuilder
    private var breatheEffect: some View {
        if #available(iOS 18.0, *) {
            // Build effect with style
            let effect: BreatheSymbolEffect = configuration.breatheStyle == .pulse
                ? .breathe.pulse
                : .breathe.plain

            // Apply scope
            let scopedEffect = configuration.scope == .byLayer
                ? effect.byLayer
                : effect.wholeSymbol

            if configuration.repeatOption == .continuous {
                Image(systemName: symbolName)
                    .font(.system(size: 48))
                    .fontWeight(weight)
                    .symbolRenderingMode(renderingMode)
                    .foregroundStyle(color)
                    .symbolEffect(scopedEffect, options: effectOptions)
            } else {
                Image(systemName: symbolName)
                    .font(.system(size: 48))
                    .fontWeight(weight)
                    .symbolRenderingMode(renderingMode)
                    .foregroundStyle(color)
                    .symbolEffect(scopedEffect, options: effectOptions, value: trigger)
            }
        } else {
            baseSymbol
        }
    }

    @available(iOS 17.0, *)
    @ViewBuilder
    private var wiggleEffect: some View {
        if #available(iOS 18.0, *) {
            let effect: WiggleSymbolEffect = {
                switch configuration.direction {
                case .up: return .wiggle.up
                case .down: return .wiggle.down
                case .left: return .wiggle.left
                case .right: return .wiggle.right
                case .forward: return .wiggle.forward
                case .backward: return .wiggle.backward
                case .clockwise: return .wiggle.clockwise
                case .counterClockwise: return .wiggle.counterClockwise
                }
            }()

            // Apply scope
            let scopedEffect = configuration.scope == .byLayer
                ? effect.byLayer
                : effect.wholeSymbol

            if configuration.repeatOption == .continuous {
                Image(systemName: symbolName)
                    .font(.system(size: 48))
                    .fontWeight(weight)
                    .symbolRenderingMode(renderingMode)
                    .foregroundStyle(color)
                    .symbolEffect(scopedEffect, options: effectOptions)
            } else {
                Image(systemName: symbolName)
                    .font(.system(size: 48))
                    .fontWeight(weight)
                    .symbolRenderingMode(renderingMode)
                    .foregroundStyle(color)
                    .symbolEffect(scopedEffect, options: effectOptions, value: trigger)
            }
        } else {
            baseSymbol
        }
    }

    @available(iOS 17.0, *)
    @ViewBuilder
    private var rotateEffect: some View {
        if #available(iOS 18.0, *) {
            let effect: RotateSymbolEffect = configuration.direction == .counterClockwise
                ? .rotate.counterClockwise
                : .rotate.clockwise

            // Apply scope
            let scopedEffect = configuration.scope == .byLayer
                ? effect.byLayer
                : effect.wholeSymbol

            if configuration.repeatOption == .continuous {
                Image(systemName: symbolName)
                    .font(.system(size: 48))
                    .fontWeight(weight)
                    .symbolRenderingMode(renderingMode)
                    .foregroundStyle(color)
                    .symbolEffect(scopedEffect, options: effectOptions)
            } else {
                Image(systemName: symbolName)
                    .font(.system(size: 48))
                    .fontWeight(weight)
                    .symbolRenderingMode(renderingMode)
                    .foregroundStyle(color)
                    .symbolEffect(scopedEffect, options: effectOptions, value: trigger)
            }
        } else {
            baseSymbol
        }
    }

    @available(iOS 17.0, *)
    private var effectOptions: SymbolEffectOptions {
        var options = SymbolEffectOptions.default

        // Apply speed
        switch configuration.speed {
        case .slow:
            options = options.speed(0.5)
        case .normal:
            break
        case .fast:
            options = options.speed(2.0)
        }

        // Apply repeat count
        if let count = configuration.repeatOption.count {
            options = options.repeat(count)
        } else {
            options = options.repeating
        }

        return options
    }
}

// MARK: - Preview

#Preview {
    ScrollView {
        SymbolEffectPicker(
            configuration: .constant(SymbolEffectConfiguration(effectType: .bounce)),
            symbolName: "heart.fill",
            weight: .regular,
            color: .pink,
            renderingMode: .monochrome
        )
        .padding()
    }
}
