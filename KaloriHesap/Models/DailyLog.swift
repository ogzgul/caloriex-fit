import Foundation
import SwiftData

@Model
final class DailyLog {
    var id: UUID
    var date: Date          // günün başlangıcı (00:00:00)
    var waterMl: Int        // içilen su (ml)

    @Relationship(deleteRule: .cascade) var entries: [FoodEntry]

    init(date: Date) {
        self.id = UUID()
        self.date = Calendar.current.startOfDay(for: date)
        self.waterMl = 0
        self.entries = []
    }

    // MARK: - Hesaplamalar
    var totalCalories: Double { entries.reduce(0) { $0 + $1.totalCalories } }
    var totalProtein: Double  { entries.reduce(0) { $0 + $1.totalProtein  } }
    var totalCarbs: Double    { entries.reduce(0) { $0 + $1.totalCarbs    } }
    var totalFat: Double      { entries.reduce(0) { $0 + $1.totalFat      } }

    func calories(for mealType: MealType) -> Double {
        entries
            .filter { $0.mealType == mealType.rawValue }
            .reduce(0) { $0 + $1.totalCalories }
    }

    func entries(for mealType: MealType) -> [FoodEntry] {
        entries.filter { $0.mealType == mealType.rawValue }
    }
}
