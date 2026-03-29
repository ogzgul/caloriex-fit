import Foundation

// MARK: - Portion Unit (ölçü birimi)
enum PortionUnit: String, CaseIterable, Codable, Identifiable {
    case gram       = "g"
    case ml         = "ml"
    case adet       = "Adet"
    case bardak     = "Bardak"
    case cayKasigi  = "Çay Kaşığı"
    case yemekKasigi = "Yemek Kaşığı"
    case dilim      = "Dilim"
    case kase       = "Kase"
    case porsiyon   = "Porsiyon"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .gram:        return "scalemass"
        case .ml:          return "drop"
        case .adet:        return "number.circle"
        case .bardak:      return "cup.and.saucer"
        case .cayKasigi:   return "spoon"
        case .yemekKasigi: return "fork.knife"
        case .dilim:       return "triangle"
        case .kase:        return "bowl.fill"
        case .porsiyon:    return "square.and.arrow.up"
        }
    }
}

// MARK: - Portion (miktar + birim)
struct Portion: Codable, Identifiable, Equatable {
    let id: UUID
    let unit: PortionUnit
    /// Bu porsiyon kaç gram / ml'ye eşit (besin değerleri 100g üzerinden hesaplanır)
    let gramsEquivalent: Double
    /// Kullanıcıya gösterilecek label  →  "1 Bardak (240 ml)"
    let label: String

    init(unit: PortionUnit, gramsEquivalent: Double, label: String? = nil) {
        self.id = UUID()
        self.unit = unit
        self.gramsEquivalent = gramsEquivalent
        self.label = label ?? "\(unit.rawValue)"
    }

    // MARK: - Standart porsiyon tanımları
    static let oneGram        = Portion(unit: .gram,        gramsEquivalent: 1,    label: "1 g")
    static let oneMl          = Portion(unit: .ml,          gramsEquivalent: 1,    label: "1 ml")
    static let onePiece       = Portion(unit: .adet,        gramsEquivalent: 100,  label: "1 Adet (~100 g)")
    static let oneCup         = Portion(unit: .bardak,      gramsEquivalent: 240,  label: "1 Bardak (240 ml)")
    static let smallCup       = Portion(unit: .bardak,      gramsEquivalent: 200,  label: "1 Su Bardağı (200 ml)")
    static let teaspoon       = Portion(unit: .cayKasigi,   gramsEquivalent: 5,    label: "1 Çay Kaşığı (5 g)")
    static let tablespoon     = Portion(unit: .yemekKasigi, gramsEquivalent: 15,   label: "1 Yemek Kaşığı (15 g)")
    static let oneSlice       = Portion(unit: .dilim,       gramsEquivalent: 25,   label: "1 Dilim (~25 g)")
    static let oneBowl        = Portion(unit: .kase,        gramsEquivalent: 300,  label: "1 Kase (300 g)")
    static let oneServing     = Portion(unit: .porsiyon,    gramsEquivalent: 150,  label: "1 Porsiyon (150 g)")
}

// MARK: - Kalori Hesaplama
extension Portion {
    /// caloriesPer100g  →  bu porsiyon için kalori
    func calories(caloriesPer100g: Double) -> Double {
        (gramsEquivalent * caloriesPer100g) / 100.0
    }

    func protein(proteinPer100g: Double) -> Double {
        (gramsEquivalent * proteinPer100g) / 100.0
    }

    func carbs(carbsPer100g: Double) -> Double {
        (gramsEquivalent * carbsPer100g) / 100.0
    }

    func fat(fatPer100g: Double) -> Double {
        (gramsEquivalent * fatPer100g) / 100.0
    }
}
