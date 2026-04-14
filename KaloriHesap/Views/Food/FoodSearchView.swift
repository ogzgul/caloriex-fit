import SwiftUI

struct FoodSearchView: View {
    let mealType: MealType
    let onAdd: (FoodItem, Portion, Double, MealType) -> Void
    let onAddManual: (String, Double, Double, Double, Double, MealType) -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = FoodSearchViewModel()
    @State private var selectedFood: FoodItem? = nil
    @State private var showManualEntry = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                // Kategori filtresi
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        CategoryFilterChip(
                            label: "Tümü",
                            icon: "🍽️",
                            isSelected: viewModel.selectedCategory == nil
                        ) { viewModel.selectedCategory = nil }

                        ForEach(FoodCategory.allCases, id: \.self) { cat in
                            CategoryFilterChip(
                                label: LocalizedStringKey(cat.rawValue),
                                icon: cat.icon,
                                isSelected: viewModel.selectedCategory == cat
                            ) { viewModel.selectedCategory = cat }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }

                Divider()

                // Sonuç listesi
                if viewModel.results.isEmpty {
                    VStack(spacing: 20) {
                        ContentUnavailableView(
                            "Sonuç Bulunamadı",
                            systemImage: "magnifyingglass",
                            description: Text("'\(viewModel.searchText)' için besin bulunamadı")
                        )
                        Button {
                            showManualEntry = true
                        } label: {
                            Label("Manuel Kalori Gir", systemImage: "pencil.circle.fill")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 14))
                                .padding(.horizontal, 32)
                        }
                    }
                } else {
                    List {
                        ForEach(viewModel.results) { food in
                            FoodListRow(food: food) {
                                selectedFood = food
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(LocalizedStringKey(mealType.rawValue))
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Besin ara..."
            )
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Kapat") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showManualEntry = true
                    } label: {
                        Label("Manuel", systemImage: "pencil.circle")
                            .labelStyle(.iconOnly)
                            .font(.title3)
                    }
                }
            }
            .sheet(item: $selectedFood) { food in
                AddFoodEntryView(foodItem: food, mealType: mealType) { item, portion, qty, meal in
                    onAdd(item, portion, qty, meal)
                    selectedFood = nil
                }
            }
            .sheet(isPresented: $showManualEntry) {
                ManualCalorieEntryView(mealType: mealType) { name, cal, prot, carbs, fat, meal in
                    onAddManual(name, cal, prot, carbs, fat, meal)
                    showManualEntry = false
                }
            }
        }
    }
}

// MARK: - Yardımcı

private struct FoodListRow: View {
    let food: FoodItem
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Text(food.category.icon)
                    .font(.title2)
                    .frame(width: 40)

                VStack(alignment: .leading, spacing: 2) {
                    Text(food.name)
                        .font(.body)
                        .foregroundStyle(.primary)
                    Text(LocalizedStringKey(food.category.rawValue))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(Int(food.caloriesPer100g))")
                        .font(.headline)
                        .foregroundStyle(.orange)
                    Text("kcal/100g")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

private struct CategoryFilterChip: View {
    let label: LocalizedStringKey
    let icon: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 4) {
                Text(icon).font(.caption)
                Text(label).font(.caption.bold())
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 7)
            .background(isSelected ? Color.orange : Color(.systemGray6))
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(Capsule())
        }
    }
}
