import SwiftUI

struct EditFoodEntryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    let entry: FoodEntry
    let onSave: () -> Void

    // Besin veritabanından bul — yoksa portionları entry'den oluştur
    private var foodItem: FoodItem? {
        FoodDatabase.shared.items.first { $0.id == entry.foodItemID }
    }

    private var availablePortions: [Portion] {
        if let f = foodItem { return f.availablePortions }
        // Orijinal porsiyon bulunamazsa tek seçenek olarak sun
        return [Portion(unit: entry.portionUnitEnum,
                        gramsEquivalent: entry.portionGramsEquivalent,
                        label: entry.portionLabel)]
    }

    @State private var selectedPortion: Portion
    @State private var quantity: Double
    @State private var quantityText: String

    init(entry: FoodEntry, onSave: @escaping () -> Void) {
        self.entry = entry
        self.onSave = onSave

        let initPortion = Portion(unit: entry.portionUnitEnum,
                                  gramsEquivalent: entry.portionGramsEquivalent,
                                  label: entry.portionLabel)
        _selectedPortion = State(initialValue: initPortion)
        _quantity        = State(initialValue: entry.quantity)
        _quantityText    = State(initialValue: Self.fmt(entry.quantity))
    }

    private static func fmt(_ v: Double) -> String {
        v.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(v))" : String(format: "%.1f", v)
    }

    // Anlık hesap
    private var totalGrams: Double   { selectedPortion.gramsEquivalent * quantity }
    private var totalCalories: Double {
        guard let f = foodItem else {
            let orig = entry.portionGramsEquivalent * entry.quantity
            return orig > 0 ? entry.totalCalories * (totalGrams / orig) : entry.totalCalories
        }
        return (totalGrams * f.caloriesPer100g) / 100
    }
    private var totalProtein: Double {
        guard let f = foodItem else { return entry.totalProtein }
        return (totalGrams * f.proteinPer100g) / 100
    }
    private var totalCarbs: Double {
        guard let f = foodItem else { return entry.totalCarbs }
        return (totalGrams * f.carbsPer100g) / 100
    }
    private var totalFat: Double {
        guard let f = foodItem else { return entry.totalFat }
        return (totalGrams * f.fatPer100g) / 100
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    // ─── Başlık ───────────────────────────────
                    VStack(spacing: 4) {
                        Text(foodItem?.category.icon ?? "🍽️")
                            .font(.largeTitle)
                        Text(entry.foodName)
                            .font(.title2.bold())
                        Text(entry.mealTypeEnum.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top)

                    // ─── Kalori ───────────────────────────────
                    VStack(spacing: 4) {
                        Text("\(Int(totalCalories))")
                            .font(.system(size: 60, weight: .bold, design: .rounded))
                            .foregroundStyle(.orange)
                            .contentTransition(.numericText())
                            .animation(.easeInOut(duration: 0.2), value: totalCalories)
                        Text("kcal")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }

                    // ─── Makro ────────────────────────────────
                    HStack(spacing: 24) {
                        MiniMacro(label: "Protein", value: totalProtein, color: .blue)
                        MiniMacro(label: "Karb",    value: totalCarbs,   color: .orange)
                        MiniMacro(label: "Yağ",     value: totalFat,     color: .yellow)
                    }

                    Divider()

                    // ─── Porsiyon ─────────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Porsiyon", systemImage: "scalemass.fill")
                            .font(.headline)
                            .padding(.horizontal)

                        // Eşleşen porsiyon vurgula
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(availablePortions) { p in
                                    PortionChipEdit(
                                        portion: p,
                                        isSelected: selectedPortion.label == p.label
                                    ) {
                                        withAnimation(.spring(response: 0.3)) {
                                            selectedPortion = p
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // ─── Miktar ───────────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Miktar", systemImage: "number.circle.fill")
                            .font(.headline)
                            .padding(.horizontal)

                        HStack(spacing: 16) {
                            Button {
                                if quantity > 0.5 {
                                    quantity = max(quantity - 0.5, 0.5)
                                    quantityText = Self.fmt(quantity)
                                }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(.orange)
                            }

                            TextField("Miktar", text: $quantityText)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.center)
                                .font(.system(.title2, design: .rounded, weight: .semibold))
                                .frame(width: 80)
                                .padding(.vertical, 10)
                                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                                .onChange(of: quantityText) { _, v in
                                    let c = v.replacingOccurrences(of: ",", with: ".")
                                    if let p = Double(c), p > 0 { quantity = p }
                                }

                            Button {
                                quantity += 0.5
                                quantityText = Self.fmt(quantity)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(.orange)
                            }
                        }
                        .frame(maxWidth: .infinity)

                        Text("\(String(localized: "Toplam: "))\(String(format: "%.0f", totalGrams)) g")
                            .font(.caption).foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.bottom, 100)
            }
            .navigationTitle("Düzenle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") { dismiss() }
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    saveChanges()
                    dismiss()
                } label: {
                    Text("\(String(localized: "Kaydet — "))\(Int(totalCalories)) kcal")
                        .font(.body.bold())
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                }
                .background(.ultraThinMaterial)
            }
        }
    }

    private func saveChanges() {
        let totalG = selectedPortion.gramsEquivalent * quantity
        entry.portionUnitRaw           = selectedPortion.unit.rawValue
        entry.portionLabel             = selectedPortion.label
        entry.portionGramsEquivalent   = selectedPortion.gramsEquivalent
        entry.quantity                 = quantity
        entry.totalCalories            = (totalG * (foodItem?.caloriesPer100g ?? entry.totalCalories / max(entry.totalGrams, 1) * 100)) / 100
        entry.totalProtein             = totalProtein
        entry.totalCarbs               = totalCarbs
        entry.totalFat                 = totalFat
        try? modelContext.save()
        onSave()
    }
}

private struct PortionChipEdit: View {
    let portion: Portion
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: portion.unit.icon).font(.title3)
                Text(portion.label)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 10)
            .frame(width: 90)
            .background(isSelected ? Color.orange : Color(.systemGray6))
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

private struct MiniMacro: View {
    let label: LocalizedStringKey
    let value: Double
    let color: Color
    var body: some View {
        VStack(spacing: 2) {
            Text(label).font(.caption2).foregroundStyle(.secondary)
            Text("\(String(format: "%.1f", value))g")
                .font(.system(.subheadline, design: .rounded, weight: .semibold))
                .foregroundStyle(color)
        }
        .padding(.vertical, 8).padding(.horizontal, 12)
        .background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
    }
}
