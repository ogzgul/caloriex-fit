import SwiftUI

struct MealSectionView: View {
    let mealType: MealType
    let entries: [FoodEntry]
    let totalCalories: Double
    let onDelete: (FoodEntry) -> Void
    let onEdit: (FoodEntry) -> Void
    let onAdd: () -> Void

    @State private var isExpanded: Bool = true
    @State private var entryToDelete: FoodEntry?
    @State private var showDeleteConfirm = false

    private var mealColor: Color {
        switch mealType {
        case .kahvalti:    return .orange
        case .ogleYemegi:  return .yellow
        case .aksamYemegi: return .indigo
        case .atistirma:   return .green
        }
    }

    var body: some View {
        Section {
            if isExpanded {
                ForEach(entries) { entry in
                    FoodEntryRow(entry: entry)
                        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                            Button {
                                entryToDelete = entry
                                showDeleteConfirm = true
                            } label: {
                                Label("Sil", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button {
                                onEdit(entry)
                            } label: {
                                Label("Düzenle", systemImage: "pencil")
                            }
                            .tint(.orange)
                        }
                }

                // Ekle butonu
                Button(action: onAdd) {
                    Label("Yemek Ekle", systemImage: "plus.circle.fill")
                        .font(.subheadline)
                        .foregroundStyle(mealColor)
                }
            }
        } header: {
            Button {
                withAnimation(.spring(response: 0.35)) { isExpanded.toggle() }
            } label: {
                HStack(spacing: 6) {
                    Image(systemName: mealType.icon)
                        .foregroundStyle(mealColor)
                        .frame(width: 20)
                    Text(LocalizedStringKey(mealType.rawValue))
                        .font(.headline)
                        .foregroundStyle(Color.primary)
                    Spacer()
                    if totalCalories > 0 {
                        Text("\(Int(totalCalories)) kcal")
                            .font(.subheadline)
                            .foregroundStyle(mealColor)
                    }
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundStyle(Color.secondary)
                }
                .padding(.vertical, 2)
            }
            .buttonStyle(.plain)
            .textCase(nil)
        }
        .confirmationDialog(
            "Bu yemeği silmek istiyor musun?",
            isPresented: $showDeleteConfirm,
            titleVisibility: .visible
        ) {
            Button("Sil", role: .destructive) {
                if let e = entryToDelete { onDelete(e) }
                entryToDelete = nil
            }
            Button("İptal", role: .cancel) { entryToDelete = nil }
        }
    }
}

// MARK: - Satır

struct FoodEntryRow: View {
    let entry: FoodEntry

    var body: some View {
        HStack(spacing: 12) {
            // Miktar badge
            VStack(spacing: 1) {
                Text(String(format: entry.quantity.truncatingRemainder(dividingBy: 1) == 0
                            ? "%.0f" : "%.1f", entry.quantity))
                    .font(.system(.caption, design: .rounded, weight: .semibold))
                Text(entry.portionUnitEnum.rawValue)
                    .font(.system(size: 8))
                    .foregroundStyle(.secondary)
            }
            .frame(width: 40)
            .padding(.vertical, 4)
            .background(Color(.systemGray5), in: RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 2) {
                Text(entry.foodName)
                    .font(.subheadline)
                    .lineLimit(1)
                Text(entry.portionLabel)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                Text("\(Int(entry.totalCalories))")
                    .font(.subheadline.bold())
                Text("kcal")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}
