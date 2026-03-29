import Foundation

// MARK: - Öğün tipi
enum MealType: String, CaseIterable, Codable, Identifiable {
    case kahvalti    = "Kahvaltı"
    case ogleYemegi  = "Öğle Yemeği"
    case aksamYemegi = "Akşam Yemeği"
    case atistirma   = "Atıştırmalık"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .kahvalti:    return "sunrise.fill"
        case .ogleYemegi:  return "sun.max.fill"
        case .aksamYemegi: return "moon.fill"
        case .atistirma:   return "leaf.fill"
        }
    }

    var color: String {
        switch self {
        case .kahvalti:    return "orange"
        case .ogleYemegi:  return "yellow"
        case .aksamYemegi: return "indigo"
        case .atistirma:   return "green"
        }
    }
}

// MARK: - Besin kategorisi
enum FoodCategory: String, CaseIterable, Codable {
    case tahil       = "Tahıllar & Ekmek"
    case sebze       = "Sebzeler"
    case meyve       = "Meyveler"
    case et          = "Et & Tavuk & Balık"
    case sut         = "Süt Ürünleri & Yumurta"
    case baklagil    = "Baklagiller"
    case icecek      = "İçecekler"
    case tatli        = "Tatlılar"
    case atistirmalik = "Atıştırmalıklar & Kuruyemiş"
    case kahvaltilik  = "Kahvaltılık"
    case yagSos       = "Yağ & Sos & Baharat"
    case hazirYemek   = "Hazır Yemek & Fast Food"
    case diger        = "Diğer"

    var icon: String {
        switch self {
        case .tahil:      return "🌾"
        case .sebze:      return "🥦"
        case .meyve:      return "🍎"
        case .et:         return "🍖"
        case .sut:        return "🥛"
        case .baklagil:   return "🫘"
        case .icecek:     return "☕️"
        case .tatli:        return "🍫"
        case .atistirmalik: return "🥜"
        case .kahvaltilik:  return "🍳"
        case .yagSos:       return "🫙"
        case .hazirYemek:   return "🍔"
        case .diger:        return "🍽️"
        }
    }
}

// MARK: - Besin (veritabanı ürünü)
struct FoodItem: Identifiable, Codable, Hashable {
    let id: UUID
    var name: String
    var category: FoodCategory

    // Tüm değerler 100g / 100ml başına
    var caloriesPer100g: Double
    var proteinPer100g: Double
    var carbsPer100g: Double
    var fatPer100g: Double
    var fiberPer100g: Double

    /// Bu besine uygun porsiyon seçenekleri
    var availablePortions: [Portion]

    /// Kullanıcı tarafından eklendi mi?
    var isCustom: Bool

    init(
        id: UUID = UUID(),
        name: String,
        category: FoodCategory,
        caloriesPer100g: Double,
        proteinPer100g: Double = 0,
        carbsPer100g: Double = 0,
        fatPer100g: Double = 0,
        fiberPer100g: Double = 0,
        availablePortions: [Portion],
        isCustom: Bool = false
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.caloriesPer100g = caloriesPer100g
        self.proteinPer100g = proteinPer100g
        self.carbsPer100g = carbsPer100g
        self.fatPer100g = fatPer100g
        self.fiberPer100g = fiberPer100g
        self.availablePortions = availablePortions
        self.isCustom = isCustom
    }

    func hash(into hasher: inout Hasher) { hasher.combine(id) }
    static func == (lhs: FoodItem, rhs: FoodItem) -> Bool { lhs.id == rhs.id }
}

// MARK: - FoodItem Coding Keys (Portion içinde UUID otomatik üretildiği için)
extension FoodItem {
    enum CodingKeys: String, CodingKey {
        case id, name, category
        case caloriesPer100g, proteinPer100g, carbsPer100g, fatPer100g, fiberPer100g
        case availablePortions, isCustom
    }
}
