import SwiftUI
import SwiftData
import StoreKit

struct DashboardView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.requestReview) private var requestReview
    @State private var viewModel: DashboardViewModel?
    @State private var activeMealType: MealType? = nil
    @State private var editingEntry: FoodEntry? = nil
    @StateObject private var stepService = StepCounterService()

    var body: some View {
        Group {
            if let vm = viewModel {
                mainContent(vm: vm)
            } else {
                ProgressView()
                    .onAppear { viewModel = DashboardViewModel(modelContext: modelContext) }
            }
        }
        .sheet(item: $activeMealType) { meal in
            FoodSearchView(mealType: meal) { food, portion, qty, mealType in
                viewModel?.addEntry(foodItem: food, portion: portion, quantity: qty, mealType: mealType)
                maybeRequestReview()
            }
        }
        .sheet(item: $editingEntry) { entry in
            EditFoodEntryView(entry: entry) {
                viewModel?.objectDidChange()
            }
        }
    }

    private func maybeRequestReview() {
        let date = viewModel?.selectedDate ?? Date()
        if ReviewManager.recordEntryAdded(on: date) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                requestReview()
                ReviewManager.markReviewRequested()
            }
        }
    }

    @ViewBuilder
    private func mainContent(vm: DashboardViewModel) -> some View {
        NavigationStack {
            List {

                // ─── Tarih Navigasyonu ───────────────────────
                Section {
                    HStack {
                        Button { vm.goToPreviousDay() } label: {
                            Image(systemName: "chevron.left.circle.fill")
                                .font(.title2)
                                .foregroundStyle(Color.orange)
                        }
                        .buttonStyle(.plain)

                        Spacer()
                        Text(vm.dateLabel).font(.title3.bold())
                        Spacer()

                        Button { vm.goToNextDay() } label: {
                            Image(systemName: "chevron.right.circle.fill")
                                .font(.title2)
                                .foregroundStyle(vm.isToday ? Color.secondary : Color.orange)
                        }
                        .buttonStyle(.plain)
                        .disabled(vm.isToday)
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }

                // ─── Kalori Halkası ──────────────────────────
                Section {
                    CalorieRingView(
                        consumed: vm.totalCalories,
                        goal: vm.calorieGoal,
                        size: 180
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                    HStack(spacing: 0) {
                        StatCell(title: "Tüketilen", value: "\(Int(vm.totalCalories))", unit: "kcal", color: .orange)
                        Divider().frame(height: 40)
                        StatCell(title: "Hedef", value: "\(Int(vm.calorieGoal))", unit: "kcal", color: .primary)
                        Divider().frame(height: 40)
                        StatCell(title: "Kalan", value: "\(Int(max(vm.remainingCalories, 0)))", unit: "kcal", color: .green)
                    }
                    .padding(.vertical, 8)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                    MacroBarView(
                        protein: vm.totalProtein,
                        carbs: vm.totalCarbs,
                        fat: vm.totalFat,
                        proteinGoal: vm.proteinGoal,
                        carbsGoal: vm.carbsGoal,
                        fatGoal: vm.fatGoal
                    )
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)

                    StepStatRow(
                        steps: stepService.todaySteps,
                        stepGoal: stepService.stepGoal,
                        distanceKm: stepService.distanceKm,
                        caloriesBurned: stepService.caloriesBurned(weightKg: vm.profile?.weightKg ?? 70)
                    )
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }

                // ─── Öğün Bölümleri ──────────────────────────
                ForEach(MealType.allCases) { meal in
                    MealSectionView(
                        mealType: meal,
                        entries: vm.entries(for: meal),
                        totalCalories: vm.calories(for: meal),
                        onDelete: { vm.deleteEntry($0) },
                        onEdit: { editingEntry = $0 },
                        onAdd: { activeMealType = meal }
                    )
                }

                // ─── Su Takibi ───────────────────────────────
                Section {
                    WaterTrackerView(
                        waterMl: vm.currentLog?.waterMl ?? 0,
                        onAdd: { vm.addWater($0) }
                    )
                    .buttonStyle(.borderless)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                }

                // ─── Adım Sayar ──────────────────────────────
                Section {
                    StepCounterView(
                        service: stepService,
                        weightKg: vm.profile?.weightKg ?? 70
                    )
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Kalori Takibi")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { stepService.start() }
            .onDisappear { stepService.stop() }
        }
    }
}

// MARK: - Yardımcı

private struct StatCell: View {
    let title: LocalizedStringKey
    let value: String
    let unit: String
    let color: Color

    var body: some View {
        VStack(spacing: 2) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.system(.title3, design: .rounded, weight: .bold)).foregroundStyle(color)
            Text(unit).font(.caption2).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct WaterTrackerView: View {
    let waterMl: Int
    let onAdd: (Int) -> Void

    private let goalMl = 2000
    private let glassSize = 200

    private var glasses: Int { waterMl / glassSize }
    private var goalGlasses: Int { goalMl / glassSize }
    private var progress: Double { min(Double(waterMl) / Double(goalMl), 1.0) }
    private var remaining: Int { max(goalMl - waterMl, 0) }

    var body: some View {
        VStack(spacing: 14) {

            HStack {
                Label("Su Takibi", systemImage: "drop.fill")
                    .font(.headline)
                    .foregroundStyle(.blue)
                Spacer()
                Text(remaining > 0
                     ? "\(remaining) ml \(String(localized: "kaldı"))"
                     : String(localized: "Hedef tamamlandı 🎉"))
                    .font(.caption.bold())
                    .foregroundStyle(remaining > 0 ? Color.secondary : Color.blue)
            }

            HStack(spacing: 0) {
                ForEach(0..<goalGlasses, id: \.self) { i in
                    Image(systemName: i < glasses ? "cup.and.saucer.fill" : "cup.and.saucer")
                        .font(.title3)
                        .foregroundStyle(i < glasses ? .blue : Color(.systemGray4))
                        .frame(maxWidth: .infinity)
                }
            }

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color(.systemGray5)).frame(height: 8)
                    Capsule()
                        .fill(LinearGradient(
                            colors: [.cyan, .blue],
                            startPoint: .leading, endPoint: .trailing))
                        .frame(width: geo.size.width * progress, height: 8)
                        .animation(.easeInOut(duration: 0.4), value: progress)
                }
            }
            .frame(height: 8)

            HStack {
                Text("\(waterMl) ml")
                    .font(.system(.title3, design: .rounded, weight: .bold))
                    .foregroundStyle(.blue)
                    .contentTransition(.numericText())
                    .animation(.easeInOut, value: waterMl)
                Text("·  \(glasses) / \(goalGlasses) \(String(localized: "bardak"))")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Spacer()
            }

            HStack {
                Label("Ekle", systemImage: "plus.circle.fill")
                    .font(.caption.bold())
                    .foregroundStyle(.blue)
                Spacer()
                if waterMl > 0 {
                    Label("Geri Al", systemImage: "minus.circle.fill")
                        .font(.caption.bold())
                        .foregroundStyle(.red.opacity(0.7))
                }
            }

            HStack(spacing: 8) {
                WaterAddButton(icon: "cup.and.saucer.fill", label: "1 Bardak",   sublabel: "200 ml",     isAdd: true)  { onAdd(200)  }
                WaterAddButton(icon: "cup.and.saucer.fill", label: "1.5 Bardak", sublabel: "300 ml",     isAdd: true)  { onAdd(300)  }
                WaterAddButton(icon: "drop.fill",           label: "500 ml",     sublabel: "2.5 bardak", isAdd: true)  { onAdd(500)  }
            }

            if waterMl > 0 {
                HStack(spacing: 8) {
                    WaterAddButton(icon: "cup.and.saucer",  label: "1 Bardak",   sublabel: "200 ml",     isAdd: false) { onAdd(-200) }
                    WaterAddButton(icon: "cup.and.saucer",  label: "1.5 Bardak", sublabel: "300 ml",     isAdd: false) { onAdd(-300) }
                    WaterAddButton(icon: "drop",            label: "Sıfırla",    sublabel: "tümünü sil", isAdd: false) { onAdd(-waterMl) }
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }

            HStack {
                Image(systemName: "arrow.clockwise").font(.caption2)
                Text("Her gün gece yarısı otomatik sıfırlanır").font(.caption2)
            }
            .foregroundStyle(Color(.systemGray3))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

private struct WaterAddButton: View {
    let icon: String
    let label: LocalizedStringKey
    let sublabel: LocalizedStringKey
    let isAdd: Bool
    let action: () -> Void

    private var tint: Color { isAdd ? .blue : .red }

    var body: some View {
        Button(action: action) {
            VStack(spacing: 3) {
                Image(systemName: icon).font(.title3).foregroundStyle(tint)
                Text(label).font(.caption.bold()).foregroundStyle(.primary)
                Text(sublabel).font(.caption2).foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .background(tint.opacity(0.08))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
