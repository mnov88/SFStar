import SwiftUI

/// Sheet view for filtering symbols by category
struct CategoryFilterView: View {
    @Binding var selectedCategory: SymbolCategory?
    let viewModel: SymbolGridViewModel

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                ForEach(SymbolCategory.allCases) { category in
                    CategoryRow(
                        category: category,
                        count: viewModel.categoryCount(for: category),
                        isSelected: isSelected(category)
                    ) {
                        selectCategory(category)
                    }
                }
            }
            .navigationTitle("Categories")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .cancellationAction) {
                    if selectedCategory != nil {
                        Button("Clear") {
                            selectedCategory = nil
                            dismiss()
                        }
                    }
                }
            }
        }
    }

    private func isSelected(_ category: SymbolCategory) -> Bool {
        if category == .all {
            return selectedCategory == nil
        }
        return selectedCategory == category
    }

    private func selectCategory(_ category: SymbolCategory) {
        if category == .all {
            selectedCategory = nil
        } else {
            selectedCategory = category
        }

        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()

        dismiss()
    }
}

// MARK: - Category Row
struct CategoryRow: View {
    let category: SymbolCategory
    let count: Int
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: category.systemImage)
                    .font(.title3)
                    .foregroundStyle(isSelected ? Color.accentColor : .secondary)
                    .frame(width: 32)

                VStack(alignment: .leading, spacing: 2) {
                    Text(category.rawValue)
                        .foregroundStyle(.primary)

                    Text("\(count) symbols")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(Color.accentColor)
                        .fontWeight(.semibold)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(category.rawValue), \(count) symbols")
        .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var category: SymbolCategory? = nil

        var body: some View {
            CategoryFilterView(
                selectedCategory: $category,
                viewModel: SymbolGridViewModel()
            )
        }
    }

    return PreviewWrapper()
}
