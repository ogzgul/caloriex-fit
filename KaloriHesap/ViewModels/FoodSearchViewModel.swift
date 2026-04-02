import Foundation
import Observation

@Observable
final class FoodSearchViewModel {

    var searchText: String = ""
    var selectedCategory: FoodCategory? = nil

    private let database = FoodDatabase.shared

    var results: [FoodItem] {
        let trimmedQuery = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        var items = trimmedQuery.isEmpty ? database.items : database.search(trimmedQuery)

        if let cat = selectedCategory {
            items = items.filter { $0.category == cat }
        }

        return items
    }

    var categories: [FoodCategory] { FoodCategory.allCases }
}
