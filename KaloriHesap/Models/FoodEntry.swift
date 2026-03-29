import Foundation
import SwiftData

// MARK: - Günlük yemek kaydı (SwiftData)
@Model
final class FoodEntry {
    var id: UUID
    var foodItemID: UUID
    var foodName: String
    var mealType: String          // MealType.rawValue
    var date: Date

    // Seçilen porsiyon bilgisi
    var portionUnitRaw: String    // PortionUnit.rawValue
    var portionLabel: String
    var portionGramsEquivalent: Double
    var quantity: Double          // kaç porsiyon (örn: 2 bardak)

    // Hesaplanan değerler (anlık snapshot — besin DB değişse bile kayıt doğru kalır)
    var totalCalories: Double
    var totalProtein: Double
    var totalCarbs: Double
    var totalFat: Double
    var totalFiber: Double

    @Relationship(deleteRule: .nullify) var dailyLog: DailyLog?

    init(
        foodItem: FoodItem,
        portion: Portion,
        quantity: Double,
        mealType: MealType,
        date: Date = Date()
    ) {
        self.id = UUID()
        self.foodItemID = foodItem.id
        self.foodName = foodItem.name
        self.mealType = mealType.rawValue
        self.date = date

        self.portionUnitRaw = portion.unit.rawValue
        self.portionLabel = portion.label
        self.portionGramsEquivalent = portion.gramsEquivalent
        self.quantity = quantity

        let totalGrams = portion.gramsEquivalent * quantity
        self.totalCalories = (totalGrams * foodItem.caloriesPer100g) / 100.0
        self.totalProtein  = (totalGrams * foodItem.proteinPer100g)  / 100.0
        self.totalCarbs    = (totalGrams * foodItem.carbsPer100g)    / 100.0
        self.totalFat      = (totalGrams * foodItem.fatPer100g)      / 100.0
        self.totalFiber    = (totalGrams * foodItem.fiberPer100g)    / 100.0
    }

    var mealTypeEnum: MealType {
        MealType(rawValue: mealType) ?? .atistirma
    }

    var portionUnitEnum: PortionUnit {
        PortionUnit(rawValue: portionUnitRaw) ?? .gram
    }

    /// Toplam gram / ml
    var totalGrams: Double {
        portionGramsEquivalent * quantity
    }
}
