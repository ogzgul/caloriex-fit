import Foundation
import Observation

@Observable
final class FoodSearchViewModel {

    var searchText: String = ""
    var selectedCategory: FoodCategory? = nil

    private let database = FoodDatabase.shared

    var results: [FoodItem] {
        var items = database.items

        if let cat = selectedCategory {
            items = items.filter { $0.category == cat }
        }

        if searchText.isEmpty { return items }

        let q = searchText.lowercased(with: Locale(identifier: "tr_TR"))
        return items.filter {
            $0.name.lowercased(with: Locale(identifier: "tr_TR")).contains(q)
        }
    }

    var categories: [FoodCategory] { FoodCategory.allCases }
}
