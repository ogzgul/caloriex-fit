import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var profiles: [UserProfile]

    private var needsOnboarding: Bool {
        profiles.isEmpty || !(profiles.first?.onboardingCompleted ?? false)
    }

    @State private var onboardingDone = false

    var body: some View {
        Group {
            if needsOnboarding && !onboardingDone {
                OnboardingView { onboardingDone = true }
            } else {
                MainTabView()
            }
        }
        .onChange(of: profiles.isEmpty) { _, isEmpty in
            if isEmpty { onboardingDone = false }
        }
    }
}

struct MainTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Günlük", systemImage: "flame.fill")
                }

            FoodSearchTabView()
                .tabItem {
                    Label("Ara", systemImage: "magnifyingglass")
                }

            SummaryView()
                .tabItem {
                    Label("Özet", systemImage: "chart.bar.fill")
                }

            ProfileView()
                .tabItem {
                    Label("Profil", systemImage: "person.fill")
                }
        }
        .tint(.orange)
    }
}

// Arama sekmesi (standalone, öğün seçilerek ekleme)
struct FoodSearchTabView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = FoodSearchViewModel()
    @State private var selectedFood: FoodItem? = nil
    @State private var mealType: MealType = .kahvalti

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Öğün seçici
                Picker("Öğün", selection: $mealType) {
                    ForEach(MealType.allCases) { m in
                        Label(LocalizedStringKey(m.rawValue), systemImage: m.icon).tag(m)
                    }
                }
                .pickerStyle(.menu)
                .padding(.horizontal)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity, alignment: .leading)

                Divider()

                // Kategori filtresi
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        CategoryChip(label: "Tümü", icon: "🍽️",
                                     isSelected: viewModel.selectedCategory == nil) {
                            viewModel.selectedCategory = nil
                        }
                        ForEach(FoodCategory.allCases, id: \.self) { cat in
                            CategoryChip(label: LocalizedStringKey(cat.rawValue), icon: cat.icon,
                                         isSelected: viewModel.selectedCategory == cat) {
                                viewModel.selectedCategory = cat
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                }

                Divider()

                List(viewModel.results) { food in
                    Button { selectedFood = food } label: {
                        HStack {
                            Text(food.category.icon).font(.title2).frame(width: 36)
                            VStack(alignment: .leading) {
                                Text(food.name).font(.body).foregroundStyle(.primary)
                                Text(LocalizedStringKey(food.category.rawValue)).font(.caption).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Text("\(Int(food.caloriesPer100g)) kcal/100g")
                                .font(.caption.bold()).foregroundStyle(.orange)
                        }
                    }
                    .buttonStyle(.plain)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Besin Ara")
            .searchable(text: $viewModel.searchText, prompt: "Besin ara...")
        }
        .sheet(item: $selectedFood) { food in
            AddFoodEntryView(foodItem: food, mealType: mealType) { item, portion, qty, meal in
                let dashVM = DashboardViewModel(modelContext: modelContext)
                dashVM.addEntry(foodItem: item, portion: portion, quantity: qty, mealType: meal)
                selectedFood = nil
            }
        }
    }
}

private struct CategoryChip: View {
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
            .padding(.horizontal, 12).padding(.vertical, 7)
            .background(isSelected ? Color.orange : Color(.systemGray6))
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(Capsule())
        }
    }
}
