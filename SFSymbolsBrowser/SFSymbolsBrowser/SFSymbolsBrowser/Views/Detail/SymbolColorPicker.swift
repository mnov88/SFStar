import SwiftUI
import SFSymbols

/// Color picker with system colors grid and custom color option
struct SymbolColorPicker: View {
    @Binding var selectedColor: Color
    var onColorChange: ((Color) -> Void)?

    private let systemColors: [(Color, String)] = [
        (.primary, "Default"),
        (.red, "Red"),
        (.orange, "Orange"),
        (.yellow, "Yellow"),
        (.green, "Green"),
        (.mint, "Mint"),
        (.teal, "Teal"),
        (.cyan, "Cyan"),
        (.blue, "Blue"),
        (.indigo, "Indigo"),
        (.purple, "Purple"),
        (.pink, "Pink"),
        (.brown, "Brown")
    ]

    private let columns = [
        GridItem(.adaptive(minimum: 44, maximum: 56), spacing: 12)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Color")
                .font(.headline)

            // System colors grid
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(systemColors, id: \.1) { color, name in
                    ColorButton(
                        color: color,
                        name: name,
                        isSelected: selectedColor == color
                    ) {
                        selectedColor = color
                        onColorChange?(color)
                    }
                }
            }

            // Custom color picker
            HStack {
                Text("Custom")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                ColorPicker("", selection: $selectedColor, supportsOpacity: false)
                    .labelsHidden()
                    .onChange(of: selectedColor) { _, newColor in
                        onColorChange?(newColor)
                    }
            }
            .padding(.top, 4)
        }
    }
}

// MARK: - Color Button
struct ColorButton: View {
    let color: Color
    let name: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
        }) {
            ZStack {
                Circle()
                    .fill(color == .primary ? Color(.label) : color)
                    .frame(width: 44, height: 44)

                if isSelected {
                    Circle()
                        .strokeBorder(Color.white, lineWidth: 2)
                        .frame(width: 36, height: 36)

                    Image(symbol: .checkmark)
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                }
            }
            .shadow(color: color.opacity(0.4), radius: isSelected ? 6 : 2, y: isSelected ? 3 : 1)
        }
        .buttonStyle(.plain)
        .accessibilityLabel(name)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

// MARK: - Premium Symbol Color Picker
struct PremiumSymbolColorPicker: View {
    @Binding var selectedColor: Color
    var onColorChange: ((Color) -> Void)?

    private let systemColors: [(Color, String)] = [
        (.primary, "Default"),
        (.red, "Red"),
        (.orange, "Orange"),
        (.yellow, "Yellow"),
        (.green, "Green"),
        (.mint, "Mint"),
        (.teal, "Teal"),
        (.cyan, "Cyan"),
        (.blue, "Blue"),
        (.indigo, "Indigo"),
        (.purple, "Purple"),
        (.pink, "Pink"),
        (.brown, "Brown")
    ]

    private let columns = [
        GridItem(.adaptive(minimum: 48, maximum: 60), spacing: 12)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: DesignSystem.Spacing.md) {
            Text("Color")
                .font(.headline)

            // System colors grid with premium styling
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(systemColors, id: \.1) { color, name in
                    PremiumColorButton(
                        color: color,
                        name: name,
                        isSelected: selectedColor == color
                    ) {
                        withAnimation(DesignSystem.Animation.snappy) {
                            selectedColor = color
                        }
                        onColorChange?(color)
                        HapticManager.shared.selection()
                    }
                }
            }

            // Custom color picker row
            HStack {
                Text("Custom Color")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                ColorPicker("", selection: $selectedColor, supportsOpacity: false)
                    .labelsHidden()
                    .onChange(of: selectedColor) { _, newColor in
                        onColorChange?(newColor)
                        HapticManager.shared.lightTap()
                    }
            }
            .padding(.vertical, DesignSystem.Spacing.sm)
            .padding(.horizontal, DesignSystem.Spacing.md)
            .background(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                    .fill(Color.secondary.opacity(0.1))
            )
        }
        .padding()
        .glassEffect()
    }
}

// MARK: - Premium Color Button
struct PremiumColorButton: View {
    let color: Color
    let name: String
    let isSelected: Bool
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button(action: action) {
            ZStack {
                // Outer ring for selection
                Circle()
                    .strokeBorder(
                        isSelected ? color : Color.clear,
                        lineWidth: 3
                    )
                    .frame(width: 52, height: 52)

                // Color circle
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                color == .primary ? Color(.label) : color,
                                (color == .primary ? Color(.label) : color).opacity(0.8)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 44, height: 44)
                    .shadow(color: color.opacity(isSelected ? 0.5 : 0.2), radius: isSelected ? 8 : 4, y: isSelected ? 4 : 2)

                // Checkmark for selection
                if isSelected {
                    Image(symbol: .checkmark)
                        .font(.caption.bold())
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.3), radius: 1, y: 1)
                }
            }
            .scaleEffect(isPressed ? 0.9 : (isSelected ? 1.05 : 1.0))
        }
        .buttonStyle(.plain)
        .accessibilityLabel(name)
        .accessibilityAddTraits(isSelected ? .isSelected : [])
        .onLongPressGesture(minimumDuration: 0.5, pressing: { pressing in
            withAnimation(DesignSystem.Animation.snappy) {
                isPressed = pressing
            }
        }, perform: {})
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var color: Color = .blue

        var body: some View {
            VStack {
                SymbolColorPicker(selectedColor: $color)
                    .padding()

                Divider()

                Image(systemName: "heart.fill")
                    .font(.largeTitle)
                    .foregroundStyle(color)
            }
        }
    }

    return PreviewWrapper()
}

#Preview("Premium") {
    struct PreviewWrapper: View {
        @State private var color: Color = .blue

        var body: some View {
            VStack {
                PremiumSymbolColorPicker(selectedColor: $color)

                Spacer()

                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .foregroundStyle(color)
            }
            .padding()
            .background(Color(.systemGroupedBackground))
        }
    }

    return PreviewWrapper()
}
