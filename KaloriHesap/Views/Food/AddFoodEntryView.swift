import SwiftUI

struct AddFoodEntryView: View {
    let foodItem: FoodItem
    let mealType: MealType
    let onAdd: (FoodItem, Portion, Double, MealType) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var selectedPortion: Portion
    @State private var quantity: Double = 1.0
    @State private var quantityText: String = "1"

    init(foodItem: FoodItem, mealType: MealType, onAdd: @escaping (FoodItem, Portion, Double, MealType) -> Void) {
        self.foodItem = foodItem
        self.mealType = mealType
        self.onAdd = onAdd
        _selectedPortion = State(initialValue: foodItem.availablePortions.first ?? Portion.oneGram)
    }

    // MARK: - Hesaplanan değerler
    private var totalGrams: Double   { selectedPortion.gramsEquivalent * quantity }
    private var totalCalories: Double { (totalGrams * foodItem.caloriesPer100g) / 100 }
    private var totalProtein: Double  { (totalGrams * foodItem.proteinPer100g)  / 100 }
    private var totalCarbs: Double    { (totalGrams * foodItem.carbsPer100g)    / 100 }
    private var totalFat: Double      { (totalGrams * foodItem.fatPer100g)      / 100 }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    // Yiyecek başlığı
                    VStack(spacing: 4) {
                        Text(foodItem.category.icon)
                            .font(.largeTitle)
                        Text(foodItem.name)
                            .font(.title2.bold())
                        Text(foodItem.category.rawValue)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top)

                    // Kalori büyük gösterge
                    VStack(spacing: 4) {
                        Text("\(Int(totalCalories))")
                            .font(.system(size: 64, weight: .bold, design: .rounded))
                            .foregroundStyle(.orange)
                            .contentTransition(.numericText())
                            .animation(.easeInOut(duration: 0.2), value: totalCalories)
                        Text("kcal")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }

                    // Makro özeti
                    HStack(spacing: 24) {
                        MacroChip(label: "Protein", value: totalProtein, color: .blue)
                        MacroChip(label: "Karb",    value: totalCarbs,   color: .orange)
                        MacroChip(label: "Yağ",     value: totalFat,     color: .yellow)
                    }

                    Divider()

                    // ─── Porsiyon Seçimi ───────────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Porsiyon Seçin", systemImage: "scalemass.fill")
                            .font(.headline)
                            .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(foodItem.availablePortions) { portion in
                                    PortionChip(
                                        portion: portion,
                                        isSelected: selectedPortion.id == portion.id
                                    ) {
                                        withAnimation(.spring(response: 0.3)) {
                                            selectedPortion = portion
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                    }

                    // ─── Miktar Giriş ──────────────────────────────────
                    VStack(alignment: .leading, spacing: 12) {
                        Label("Miktar", systemImage: "number.circle.fill")
                            .font(.headline)
                            .padding(.horizontal)

                        HStack(spacing: 16) {
                            // Azalt
                            Button {
                                if quantity > 0.5 {
                                    quantity = max(quantity - 0.5, 0.5)
                                    quantityText = formatQuantity(quantity)
                                }
                            } label: {
                                Image(systemName: "minus.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(.orange)
                            }

                            // Manuel giriş
                            TextField("Miktar", text: $quantityText)
                                .keyboardType(.decimalPad)
                                .multilineTextAlignment(.center)
                                .font(.system(.title2, design: .rounded, weight: .semibold))
                                .frame(width: 80)
                                .padding(.vertical, 10)
                                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
                                .onChange(of: quantityText) { _, newVal in
                                    let cleaned = newVal.replacingOccurrences(of: ",", with: ".")
                                    if let parsed = Double(cleaned), parsed > 0 {
                                        quantity = parsed
                                    }
                                }

                            // Artır
                            Button {
                                quantity += 0.5
                                quantityText = formatQuantity(quantity)
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .font(.title)
                                    .foregroundStyle(.orange)
                            }
                        }
                        .frame(maxWidth: .infinity)

                        // Toplam gram bilgisi
                        Text("\(String(localized: "Toplam: "))\(String(format: "%.0f", totalGrams)) g / ml")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .frame(maxWidth: .infinity)
                    }

                    Divider()

                    // 100g başına tablo
                    Per100gTable(foodItem: foodItem)
                        .padding(.horizontal)
                }
                .padding(.bottom, 100)
            }
            .navigationTitle("Yemek Ekle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        onAdd(foodItem, selectedPortion, quantity, mealType)
                        dismiss()
                    } label: {
                        Text("Ekle")
                            .bold()
                    }
                    .disabled(quantity <= 0)
                }
            }
            .safeAreaInset(edge: .bottom) {
                // Sabit alt buton
                Button {
                    onAdd(foodItem, selectedPortion, quantity, mealType)
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("\(String(localized: "Ekle — "))\(Int(totalCalories)) kcal")
                            .bold()
                    }
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

    private func formatQuantity(_ v: Double) -> String {
        v.truncatingRemainder(dividingBy: 1) == 0 ? "\(Int(v))" : String(format: "%.1f", v)
    }
}

// MARK: - Yardımcı bileşenler

private struct PortionChip: View {
    let portion: Portion
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: portion.unit.icon)
                    .font(.title3)
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
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.orange : Color.clear, lineWidth: 2)
            )
        }
    }
}

private struct MacroChip: View {
    let label: LocalizedStringKey
    let value: Double
    let color: Color

    var body: some View {
        VStack(spacing: 2) {
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
            Text("\(String(format: "%.1f", value))g")
                .font(.system(.subheadline, design: .rounded, weight: .semibold))
                .foregroundStyle(color)
        }
        .frame(minWidth: 60)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))
    }
}

private struct Per100gTable: View {
    let foodItem: FoodItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("100g Besin Değerleri")
                .font(.subheadline.bold())
                .foregroundStyle(.secondary)

            Grid(alignment: .leading, horizontalSpacing: 16, verticalSpacing: 4) {
                GridRow {
                    Text("Kalori").foregroundStyle(.secondary)
                    Spacer()
                    Text("\(Int(foodItem.caloriesPer100g)) kcal").bold()
                }
                Divider()
                GridRow {
                    Text("Protein").foregroundStyle(.secondary)
                    Spacer()
                    Text("\(String(format: "%.1f", foodItem.proteinPer100g)) g")
                }
                GridRow {
                    Text("Karbonhidrat").foregroundStyle(.secondary)
                    Spacer()
                    Text("\(String(format: "%.1f", foodItem.carbsPer100g)) g")
                }
                GridRow {
                    Text("Yağ").foregroundStyle(.secondary)
                    Spacer()
                    Text("\(String(format: "%.1f", foodItem.fatPer100g)) g")
                }
                GridRow {
                    Text("Lif").foregroundStyle(.secondary)
                    Spacer()
                    Text("\(String(format: "%.1f", foodItem.fiberPer100g)) g")
                }
            }
            .font(.subheadline)
            .padding()
            .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
        }
    }
}
