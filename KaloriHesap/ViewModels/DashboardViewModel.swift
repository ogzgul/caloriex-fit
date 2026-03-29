import Foundation
import SwiftData
import Observation

@Observable
final class DashboardViewModel {

    var selectedDate: Date = Calendar.current.startOfDay(for: Date())
    var currentLog: DailyLog?
    var profile: UserProfile?

    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        loadProfile()
        loadOrCreateLog(for: selectedDate)
    }

    // MARK: - Hedefler
    var calorieGoal: Double    { profile?.dailyCalorieGoal ?? 2000 }
    var proteinGoal: Double    { profile?.proteinGoalG ?? 120 }
    var carbsGoal: Double      { profile?.carbsGoalG ?? 250 }
    var fatGoal: Double        { profile?.fatGoalG ?? 65 }

    // MARK: - Günlük toplamlar
    var totalCalories: Double  { currentLog?.totalCalories ?? 0 }
    var totalProtein: Double   { currentLog?.totalProtein ?? 0 }
    var totalCarbs: Double     { currentLog?.totalCarbs ?? 0 }
    var totalFat: Double       { currentLog?.totalFat ?? 0 }

    var remainingCalories: Double { calorieGoal - totalCalories }
    var calorieProgress: Double   { min(totalCalories / calorieGoal, 1.0) }

    // MARK: - Tarih navigasyonu
    func goToPreviousDay() {
        selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
        loadOrCreateLog(for: selectedDate)
    }

    func goToNextDay() {
        let next = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
        if next <= Date() {
            selectedDate = next
            loadOrCreateLog(for: selectedDate)
        }
    }

    var isToday: Bool {
        Calendar.current.isDateInToday(selectedDate)
    }

    var dateLabel: String {
        if isToday { return String(localized: "Bugün") }
        if Calendar.current.isDateInYesterday(selectedDate) { return String(localized: "Dün") }
        let fmt = DateFormatter()
        fmt.locale = Locale.current
        fmt.dateFormat = "d MMMM"
        return fmt.string(from: selectedDate)
    }

    // MARK: - Öğün verileri
    func entries(for mealType: MealType) -> [FoodEntry] {
        currentLog?.entries(for: mealType) ?? []
    }

    func calories(for mealType: MealType) -> Double {
        currentLog?.calories(for: mealType) ?? 0
    }

    // MARK: - Yemek ekleme
    func addEntry(foodItem: FoodItem, portion: Portion, quantity: Double, mealType: MealType) {
        guard let log = currentLog else { return }
        let entry = FoodEntry(foodItem: foodItem, portion: portion, quantity: quantity,
                              mealType: mealType, date: selectedDate)
        entry.dailyLog = log
        log.entries.append(entry)
        modelContext.insert(entry)
        try? modelContext.save()
    }

    // MARK: - Yemek silme
    func deleteEntry(_ entry: FoodEntry) {
        modelContext.delete(entry)
        try? modelContext.save()
    }

    // MARK: - Su
    func addWater(_ ml: Int) {
        guard let log = currentLog else { return }
        log.waterMl = max(0, log.waterMl + ml)
        try? modelContext.save()
    }

    // MARK: - Private
    private func loadProfile() {
        let descriptor = FetchDescriptor<UserProfile>()
        profile = try? modelContext.fetch(descriptor).first
    }

    private func loadOrCreateLog(for date: Date) {
        let startOfDay = Calendar.current.startOfDay(for: date)
        var descriptor = FetchDescriptor<DailyLog>(
            predicate: #Predicate { $0.date == startOfDay }
        )
        descriptor.fetchLimit = 1

        if let existing = try? modelContext.fetch(descriptor).first {
            currentLog = existing
        } else {
            let newLog = DailyLog(date: startOfDay)
            modelContext.insert(newLog)
            try? modelContext.save()
            currentLog = newLog
            pruneOldLogs()
        }
    }

    // Son 30 günü tutar, daha eskilerini siler
    private func pruneOldLogs() {
        var descriptor = FetchDescriptor<DailyLog>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        guard let all = try? modelContext.fetch(descriptor), all.count > 30 else { return }
        for log in all.dropFirst(30) {
            modelContext.delete(log)   // cascade ile FoodEntry'ler de silinir
        }
        try? modelContext.save()
    }

    func refreshProfile() { loadProfile() }

    func objectDidChange() {
        // @Observable otomatik günceller, manuel tetikleme gerekmez
        try? modelContext.save()
    }

    func updateEntry(_ entry: FoodEntry, portion: Portion, quantity: Double) {
        let totalGrams = portion.gramsEquivalent * quantity
        entry.portionUnitRaw = portion.unit.rawValue
        entry.portionLabel = portion.label
        entry.portionGramsEquivalent = portion.gramsEquivalent
        entry.quantity = quantity

        // Besin değerlerini güncelle
        if let food = FoodDatabase.shared.items.first(where: { $0.id == entry.foodItemID }) {
            entry.totalCalories = (totalGrams * food.caloriesPer100g) / 100
            entry.totalProtein  = (totalGrams * food.proteinPer100g)  / 100
            entry.totalCarbs    = (totalGrams * food.carbsPer100g)    / 100
            entry.totalFat      = (totalGrams * food.fatPer100g)      / 100
            entry.totalFiber    = (totalGrams * food.fiberPer100g)    / 100
        } else {
            // Besin DB'de yoksa (custom) oranla güncelle
            let oldGrams = entry.portionGramsEquivalent * entry.quantity
            let ratio = oldGrams > 0 ? totalGrams / oldGrams : 1
            entry.totalCalories *= ratio
            entry.totalProtein  *= ratio
            entry.totalCarbs    *= ratio
            entry.totalFat      *= ratio
            entry.totalFiber    *= ratio
        }
        try? modelContext.save()
    }
}
