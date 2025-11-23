import SwiftUI

/// Horizontal selector for font weights
struct WeightSelectorView: View {
    @Binding var selectedWeight: Font.Weight

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Weight")
                    .font(.headline)

                Spacer()

                Text(selectedWeight.displayName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            if horizontalSizeClass == .regular {
                // iPad: Full labels
                fullLabelsSelector
            } else {
                // iPhone: Abbreviated labels
                abbreviatedSelector
            }
        }
    }

    // MARK: - Abbreviated Selector (iPhone)
    private var abbreviatedSelector: some View {
        HStack(spacing: 4) {
            ForEach(Font.Weight.allWeights, id: \.self) { weight in
                WeightButton(
                    label: weight.shortName,
                    isSelected: selectedWeight == weight
                ) {
                    withAnimation(.spring(response: 0.3)) {
                        selectedWeight = weight
                    }
                    provideFeedback()
                }
            }
        }
    }

    // MARK: - Full Labels Selector (iPad)
    private var fullLabelsSelector: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                ForEach(Font.Weight.allWeights, id: \.self) { weight in
                    WeightButton(
                        label: weight.displayName,
                        isSelected: selectedWeight == weight,
                        style: .large
                    ) {
                        withAnimation(.spring(response: 0.3)) {
                            selectedWeight = weight
                        }
                        provideFeedback()
                    }
                }
            }
        }
    }

    private func provideFeedback() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}

// MARK: - Weight Button
struct WeightButton: View {
    let label: String
    let isSelected: Bool
    var style: Style = .compact
    let action: () -> Void

    enum Style {
        case compact
        case large
    }

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(style == .compact ? .caption2 : .caption)
                .fontWeight(isSelected ? .semibold : .regular)
                .foregroundStyle(isSelected ? .white : .primary)
                .padding(.horizontal, style == .compact ? 8 : 12)
                .padding(.vertical, style == .compact ? 8 : 10)
                .frame(minWidth: style == .compact ? 32 : 60)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected ? Color.accentColor : Color(.tertiarySystemBackground))
                )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(label) weight")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var weight: Font.Weight = .regular

        var body: some View {
            VStack(spacing: 40) {
                WeightSelectorView(selectedWeight: $weight)
                    .padding()

                Image(systemName: "heart.fill")
                    .font(.system(size: 60))
                    .fontWeight(weight)
            }
        }
    }

    return PreviewWrapper()
}
