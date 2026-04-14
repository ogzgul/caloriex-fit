import SwiftUI

struct ManualCalorieEntryView: View {
    let initialMealType: MealType
    let onAdd: (String, Double, Double, Double, Double, MealType) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var selectedMealType: MealType
    @State private var foodName: String = ""
    @State private var caloriesText: String = ""
    @State private var proteinText: String = ""
    @State private var carbsText: String = ""
    @State private var fatText: String = ""
    @State private var showMacros: Bool = false

    init(mealType: MealType, onAdd: @escaping (String, Double, Double, Double, Double, MealType) -> Void) {
        self.initialMealType = mealType
        self.onAdd = onAdd
        _selectedMealType = State(initialValue: mealType)
    }

    private var calories: Double { Double(caloriesText.replacingOccurrences(of: ",", with: ".")) ?? 0 }
    private var protein: Double  { Double(proteinText.replacingOccurrences(of: ",", with: ".")) ?? 0 }
    private var carbs: Double    { Double(carbsText.replacingOccurrences(of: ",", with: ".")) ?? 0 }
    private var fat: Double      { Double(fatText.replacingOccurrences(of: ",", with: ".")) ?? 0 }

    private var canAdd: Bool {
        !foodName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty && calories > 0
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {

                    // Başlık
                    VStack(spacing: 6) {
                        Text("✏️")
                            .font(.largeTitle)
                        Text("Manuel Kalori Girişi")
                            .font(.title2.bold())
                        Text("Listede bulamadığın yiyeceği buradan ekle")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top)

                    // Kalori göstergesi
                    VStack(spacing: 4) {
                        Text(calories > 0 ? "\(Int(calories))" : "—")
                            .font(.system(size: 64, weight: .bold, design: .rounded))
                            .foregroundStyle(.orange)
                            .contentTransition(.numericText())
                            .animation(.easeInOut(duration: 0.2), value: calories)
                        Text("kcal")
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }

                    Divider()

                    // Form alanları
                    VStack(spacing: 16) {

                        // Öğün seçici
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Öğün", systemImage: "clock.fill")
                                .font(.headline)
                                .padding(.horizontal)

                            HStack(spacing: 8) {
                                ForEach(MealType.allCases) { meal in
                                    Button {
                                        withAnimation(.spring(response: 0.25)) {
                                            selectedMealType = meal
                                        }
                                    } label: {
                                        VStack(spacing: 3) {
                                            Image(systemName: meal.icon)
                                                .font(.title3)
                                            Text(LocalizedStringKey(meal.rawValue))
                                                .font(.caption2)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.7)
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 10)
                                        .background(selectedMealType == meal ? Color.orange : Color(.systemGray6))
                                        .foregroundStyle(selectedMealType == meal ? .white : .primary)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }

                        // Yiyecek adı
                        VStack(alignment: .leading, spacing: 6) {
                            Label("Yiyecek Adı", systemImage: "fork.knife")
                                .font(.headline)
                            TextField("Örn: Ev Yapımı Kek, Karışık Tabak...", text: $foodName)
                                .padding(12)
                                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
                        }
                        .padding(.horizontal)

                        // Kalori (zorunlu)
                        VStack(alignment: .leading, spacing: 6) {
                            Label("Kalori (kcal) *", systemImage: "flame.fill")
                                .font(.headline)
                            HStack {
                                TextField("0", text: $caloriesText)
                                    .keyboardType(.decimalPad)
                                    .padding(12)
                                    .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
                                Text("kcal")
                                    .foregroundStyle(.secondary)
                                    .frame(width: 40)
                            }
                        }
                        .padding(.horizontal)

                        // Makrolar (opsiyonel)
                        VStack(alignment: .leading, spacing: 10) {
                            Button {
                                withAnimation(.spring(response: 0.3)) {
                                    showMacros.toggle()
                                }
                            } label: {
                                HStack {
                                    Label("Makro Bilgileri (İsteğe Bağlı)", systemImage: "chart.bar.fill")
                                        .font(.headline)
                                    Spacer()
                                    Image(systemName: showMacros ? "chevron.up" : "chevron.down")
                                        .foregroundStyle(.orange)
                                        .font(.caption.bold())
                                }
                            }
                            .buttonStyle(.plain)
                            .padding(.horizontal)

                            if showMacros {
                                VStack(spacing: 12) {
                                    MacroField(label: "Protein (g)", systemImage: "p.circle.fill",
                                               color: .blue, text: $proteinText)
                                    MacroField(label: "Karbonhidrat (g)", systemImage: "c.circle.fill",
                                               color: .orange, text: $carbsText)
                                    MacroField(label: "Yağ (g)", systemImage: "y.circle.fill",
                                               color: .yellow, text: $fatText)
                                }
                                .padding(.horizontal)
                                .transition(.opacity.combined(with: .move(edge: .top)))
                            }
                        }
                    }

                    Divider()

                    Text("* Kalori alanı zorunludur. Makrolar bilinmiyorsa boş bırakılabilir.")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                }
                .padding(.bottom, 100)
            }
            .navigationTitle(LocalizedStringKey(selectedMealType.rawValue))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") { dismiss() }
                }
            }
            .safeAreaInset(edge: .bottom) {
                Button {
                    let name = foodName.trimmingCharacters(in: .whitespacesAndNewlines)
                    onAdd(name, calories, protein, carbs, fat, selectedMealType)
                    dismiss()
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text(calories > 0 ? "Ekle — \(Int(calories)) kcal" : "Kalori Gir")
                            .bold()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(canAdd ? Color.orange : Color.gray)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                }
                .disabled(!canAdd)
                .background(.ultraThinMaterial)
            }
        }
    }
}

// MARK: - Makro Giriş Alanı
private struct MacroField: View {
    let label: String
    let systemImage: String
    let color: Color
    @Binding var text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: systemImage)
                .foregroundStyle(color)
                .frame(width: 24)
            Text(label)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .frame(minWidth: 120, alignment: .leading)
            Spacer()
            TextField("0", text: $text)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.trailing)
                .frame(width: 70)
                .padding(.vertical, 8)
                .padding(.horizontal, 10)
                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))
            Text("g")
                .foregroundStyle(.secondary)
                .frame(width: 16)
        }
    }
}
