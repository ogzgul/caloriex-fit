import Foundation

// MARK: - Yerleşik Türkçe Besin Veritabanı
struct FoodDatabase {

    static let shared = FoodDatabase()
    private(set) var items: [FoodItem] = []

    private init() {
        items = Self.buildDatabase()
    }

    func search(_ query: String) -> [FoodItem] {
        let q = Self.normalizedSearchText(query)
        guard !q.isEmpty else { return items }
        return items.filter {
            Self.normalizedSearchText($0.name).contains(q)
        }
    }

    func items(for category: FoodCategory) -> [FoodItem] {
        items.filter { $0.category == category }
    }

    // MARK: - Veritabanı
    private static func buildDatabase() -> [FoodItem] {
        var list: [FoodItem] = []
        list += tahillar()
        list += sebzeler()
        list += meyveler()
        list += etler()
        list += denizUrunleri()
        list += sutUrunleri()
        list += baklagiller()
        list += icecekler()
        list += tatlilar()
        list += yagSoslar()
        list += salatalar()
        list += fastFood()
        list += turkYemekleri()
        list += pilavlar()
        list += corbalar()
        list += zeytinyaglilar()
        list += sokakYemekleri()
        list += kahvaltilik()
        list += atistirmalik()
        list += ekstraTurkYemekleri()
        list += internationalFoods()
        return list
    }

    private static func normalizedSearchText(_ text: String) -> String {
        var normalized = text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased(with: Locale(identifier: "tr_TR"))

        let replacements = [
            "ı": "i",
            "ğ": "g",
            "ü": "u",
            "ş": "s",
            "ö": "o",
            "ç": "c"
        ]

        for (source, target) in replacements {
            normalized = normalized.replacingOccurrences(of: source, with: target)
        }

        return normalized.folding(
            options: [.diacriticInsensitive, .widthInsensitive],
            locale: Locale(identifier: "tr_TR")
        )
    }

    // MARK: - TAHILLAR & EKMEK
    private static func tahillar() -> [FoodItem] {[
        FoodItem(name: "Halk Ekmeği", category: .tahil,
            caloriesPer100g: 262, proteinPer100g: 8.5, carbsPer100g: 50.0, fatPer100g: 2.8, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 25, label: "1 İnce Dilim (25 g)"),
                Portion(unit: .dilim, gramsEquivalent: 35, label: "1 Kalın Dilim (35 g)"),
                Portion(unit: .adet, gramsEquivalent: 170, label: "1 Halk Ekmeği (170 g)")
            ]),
        FoodItem(name: "Beyaz Ekmek", category: .tahil,
            caloriesPer100g: 265, proteinPer100g: 8.9, carbsPer100g: 49.0, fatPer100g: 3.2, fiberPer100g: 2.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 25, label: "1 İnce Dilim (25 g)"),
                Portion(unit: .dilim, gramsEquivalent: 35, label: "1 Kalın Dilim (35 g)"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Somun (200 g)")
            ]),
        FoodItem(name: "Kepek Ekmeği", category: .tahil,
            caloriesPer100g: 240, proteinPer100g: 9.5, carbsPer100g: 42.0, fatPer100g: 3.0, fiberPer100g: 8.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 30, label: "1 Dilim (30 g)"),
                Portion(unit: .adet, gramsEquivalent: 180, label: "1 Somun (180 g)")
            ]),
        FoodItem(name: "Mısır Ekmeği", category: .tahil,
            caloriesPer100g: 245, proteinPer100g: 6.0, carbsPer100g: 50.0, fatPer100g: 3.0, fiberPer100g: 3.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 40, label: "1 Dilim (40 g)"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Somun (200 g)")
            ]),
        FoodItem(name: "Lavaş", category: .tahil,
            caloriesPer100g: 277, proteinPer100g: 8.0, carbsPer100g: 56.0, fatPer100g: 2.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 30, label: "1 Küçük (30 g)"),
                Portion(unit: .adet, gramsEquivalent: 60, label: "1 Büyük (60 g)")
            ]),
        FoodItem(name: "Bazlama", category: .tahil,
            caloriesPer100g: 258, proteinPer100g: 8.0, carbsPer100g: 48.0, fatPer100g: 4.0, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 90, label: "1 Adet (90 g)")
            ]),
        FoodItem(name: "Tam Buğday Ekmek", category: .tahil,
            caloriesPer100g: 247, proteinPer100g: 10.7, carbsPer100g: 41.0, fatPer100g: 3.4, fiberPer100g: 6.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 25, label: "1 İnce Dilim (25 g)"),
                Portion(unit: .dilim, gramsEquivalent: 35, label: "1 Kalın Dilim (35 g)")
            ]),
        FoodItem(name: "Çavdar Ekmeği", category: .tahil,
            caloriesPer100g: 259, proteinPer100g: 8.5, carbsPer100g: 48.0, fatPer100g: 3.3, fiberPer100g: 6.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 30, label: "1 Dilim (30 g)")
            ]),
        FoodItem(name: "Pide", category: .tahil,
            caloriesPer100g: 271, proteinPer100g: 9.0, carbsPer100g: 53.0, fatPer100g: 2.1, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 80, label: "1 Dilim (80 g)"),
                Portion(unit: .adet, gramsEquivalent: 320, label: "1 Adet Pide (320 g)")
            ]),
        FoodItem(name: "Simit", category: .tahil,
            caloriesPer100g: 296, proteinPer100g: 9.5, carbsPer100g: 56.0, fatPer100g: 4.0, fiberPer100g: 2.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Adet Simit (120 g)")
            ]),
        FoodItem(name: "Poğaça (Sade)", category: .tahil,
            caloriesPer100g: 340, proteinPer100g: 8.2, carbsPer100g: 42.0, fatPer100g: 16.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 80, label: "1 Adet (80 g)"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Büyük Adet (120 g)")
            ]),
        FoodItem(name: "Hamburger Ekmeği", category: .tahil,
            caloriesPer100g: 270, proteinPer100g: 9.0, carbsPer100g: 50.0, fatPer100g: 4.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 55, label: "1 Standart Ekmek (55 g)"),
                Portion(unit: .adet, gramsEquivalent: 80, label: "1 Büyük Ekmek (80 g)")
            ]),
        FoodItem(name: "Tortilla / Dürüm Ekmeği", category: .tahil,
            caloriesPer100g: 306, proteinPer100g: 8.3, carbsPer100g: 52.0, fatPer100g: 7.5, fiberPer100g: 3.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 45, label: "1 Küçük (45 g)"),
                Portion(unit: .adet, gramsEquivalent: 70, label: "1 Büyük (70 g)")
            ]),
        FoodItem(name: "Pirinç (Pişmiş)", category: .tahil,
            caloriesPer100g: 130, proteinPer100g: 2.7, carbsPer100g: 28.2, fatPer100g: 0.3, fiberPer100g: 0.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Makarna (Pişmiş)", category: .tahil,
            caloriesPer100g: 158, proteinPer100g: 5.8, carbsPer100g: 30.9, fatPer100g: 0.9, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 20, label: "1 Yemek Kaşığı (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Spagetti (Pişmiş)", category: .tahil,
            caloriesPer100g: 158, proteinPer100g: 5.8, carbsPer100g: 30.9, fatPer100g: 0.9, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Yulaf Ezmesi", category: .tahil,
            caloriesPer100g: 367, proteinPer100g: 13.0, carbsPer100g: 60.0, fatPer100g: 6.9, fiberPer100g: 10.1,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 12, label: "1 Yemek Kaşığı (12 g)"),
                Portion(unit: .bardak, gramsEquivalent: 90, label: "1 Su Bardağı (90 g)")
            ]),
        FoodItem(name: "Bulgur (Pişmiş)", category: .tahil,
            caloriesPer100g: 83, proteinPer100g: 3.1, carbsPer100g: 18.6, fatPer100g: 0.2, fiberPer100g: 4.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 180, label: "1 Porsiyon (180 g)")
            ]),
        FoodItem(name: "Mısır Gevreği (Corn Flakes)", category: .tahil,
            caloriesPer100g: 357, proteinPer100g: 7.5, carbsPer100g: 84.0, fatPer100g: 0.9, fiberPer100g: 3.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 30, label: "1 Bardak (30 g)")
            ]),
        FoodItem(name: "Pizza Hamuru (Pişmiş)", category: .tahil,
            caloriesPer100g: 266, proteinPer100g: 8.0, carbsPer100g: 54.0, fatPer100g: 2.0, fiberPer100g: 2.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 70, label: "1 Dilim (70 g)")
            ]),
    ]}

    // MARK: - SEBZELER
    private static func sebzeler() -> [FoodItem] {[
        FoodItem(name: "Domates", category: .sebze,
            caloriesPer100g: 18, proteinPer100g: 0.9, carbsPer100g: 3.9, fatPer100g: 0.2, fiberPer100g: 1.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Orta Boy (120 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (doğranmış, 15 g)")
            ]),
        FoodItem(name: "Salatalık", category: .sebze,
            caloriesPer100g: 15, proteinPer100g: 0.7, carbsPer100g: 3.6, fatPer100g: 0.1, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Orta Boy (200 g)"),
                Portion(unit: .dilim, gramsEquivalent: 10, label: "1 Dilim (10 g)")
            ]),
        FoodItem(name: "Marul", category: .sebze,
            caloriesPer100g: 15, proteinPer100g: 1.4, carbsPer100g: 2.9, fatPer100g: 0.2, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 47, label: "1 Bardak Doğranmış (47 g)"),
                Portion(unit: .adet, gramsEquivalent: 300, label: "1 Baş (300 g)")
            ]),
        FoodItem(name: "Roka", category: .sebze,
            caloriesPer100g: 25, proteinPer100g: 2.6, carbsPer100g: 3.7, fatPer100g: 0.7, fiberPer100g: 1.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 20, label: "1 Bardak (20 g)")
            ]),
        FoodItem(name: "Lahana (Beyaz)", category: .sebze,
            caloriesPer100g: 25, proteinPer100g: 1.3, carbsPer100g: 5.8, fatPer100g: 0.1, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 89, label: "1 Bardak Doğranmış (89 g)")
            ]),
        FoodItem(name: "Soğan", category: .sebze,
            caloriesPer100g: 40, proteinPer100g: 1.1, carbsPer100g: 9.3, fatPer100g: 0.1, fiberPer100g: 1.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 100, label: "1 Orta Boy (100 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 10, label: "1 Yemek Kaşığı (kıyılmış, 10 g)")
            ]),
        FoodItem(name: "Patates", category: .sebze,
            caloriesPer100g: 77, proteinPer100g: 2.0, carbsPer100g: 17.0, fatPer100g: 0.1, fiberPer100g: 2.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 150, label: "1 Orta Boy (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Ispanak", category: .sebze,
            caloriesPer100g: 23, proteinPer100g: 2.9, carbsPer100g: 3.6, fatPer100g: 0.4, fiberPer100g: 2.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 30, label: "1 Bardak Çiğ (30 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 180, label: "1 Porsiyon Pişmiş (180 g)")
            ]),
        FoodItem(name: "Brokoli", category: .sebze,
            caloriesPer100g: 34, proteinPer100g: 2.8, carbsPer100g: 7.0, fatPer100g: 0.4, fiberPer100g: 2.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 91, label: "1 Bardak (91 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Havuç", category: .sebze,
            caloriesPer100g: 41, proteinPer100g: 0.9, carbsPer100g: 9.6, fatPer100g: 0.2, fiberPer100g: 2.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 80, label: "1 Orta Boy (80 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 10, label: "1 Yemek Kaşığı (rendelenmiş, 10 g)")
            ]),
        FoodItem(name: "Biber (Dolmalık)", category: .sebze,
            caloriesPer100g: 31, proteinPer100g: 1.0, carbsPer100g: 7.3, fatPer100g: 0.2, fiberPer100g: 1.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Adet (120 g)")
            ]),
        FoodItem(name: "Patlıcan", category: .sebze,
            caloriesPer100g: 25, proteinPer100g: 1.0, carbsPer100g: 5.9, fatPer100g: 0.2, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 300, label: "1 Orta Boy (300 g)"),
                Portion(unit: .dilim, gramsEquivalent: 40, label: "1 Dilim (40 g)")
            ]),
        FoodItem(name: "Kabak", category: .sebze,
            caloriesPer100g: 17, proteinPer100g: 1.2, carbsPer100g: 3.1, fatPer100g: 0.3, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Orta Boy (200 g)")
            ]),
        FoodItem(name: "Mantar", category: .sebze,
            caloriesPer100g: 22, proteinPer100g: 3.1, carbsPer100g: 3.3, fatPer100g: 0.3, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 18, label: "1 Adet (18 g)"),
                Portion(unit: .bardak, gramsEquivalent: 70, label: "1 Bardak Dilimli (70 g)")
            ]),
        FoodItem(name: "Mısır (Haşlanmış)", category: .sebze,
            caloriesPer100g: 96, proteinPer100g: 3.4, carbsPer100g: 21.0, fatPer100g: 1.5, fiberPer100g: 2.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 90, label: "1 Koçan (90 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)")
            ]),
        FoodItem(name: "Sarımsak", category: .sebze,
            caloriesPer100g: 149, proteinPer100g: 6.4, carbsPer100g: 33.1, fatPer100g: 0.5, fiberPer100g: 2.1,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 3, label: "1 Diş (3 g)")
            ]),
        FoodItem(name: "Kuşkonmaz", category: .sebze,
            caloriesPer100g: 20, proteinPer100g: 2.2, carbsPer100g: 3.9, fatPer100g: 0.1, fiberPer100g: 2.1,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 20, label: "1 Çubuk (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "1 Porsiyon (100 g)")
            ]),
    ]}

    // MARK: - MEYVELER
    private static func meyveler() -> [FoodItem] {[
        FoodItem(name: "Elma", category: .meyve,
            caloriesPer100g: 52, proteinPer100g: 0.3, carbsPer100g: 13.8, fatPer100g: 0.2, fiberPer100g: 2.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 180, label: "1 Orta Boy (180 g)"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Küçük Boy (120 g)")
            ]),
        FoodItem(name: "Muz", category: .meyve,
            caloriesPer100g: 89, proteinPer100g: 1.1, carbsPer100g: 22.8, fatPer100g: 0.3, fiberPer100g: 2.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Orta Boy (120 g)"),
                Portion(unit: .adet, gramsEquivalent: 80, label: "1 Küçük Boy (80 g)")
            ]),
        FoodItem(name: "Portakal", category: .meyve,
            caloriesPer100g: 47, proteinPer100g: 0.9, carbsPer100g: 11.8, fatPer100g: 0.1, fiberPer100g: 2.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 180, label: "1 Orta Boy (180 g)")
            ]),
        FoodItem(name: "Üzüm", category: .meyve,
            caloriesPer100g: 67, proteinPer100g: 0.6, carbsPer100g: 17.2, fatPer100g: 0.4, fiberPer100g: 0.9,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 150, label: "1 Bardak (150 g)"),
                Portion(unit: .adet, gramsEquivalent: 5, label: "1 Tane (5 g)")
            ]),
        FoodItem(name: "Çilek", category: .meyve,
            caloriesPer100g: 32, proteinPer100g: 0.7, carbsPer100g: 7.7, fatPer100g: 0.3, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 152, label: "1 Bardak (152 g)"),
                Portion(unit: .adet, gramsEquivalent: 12, label: "1 Adet (12 g)")
            ]),
        FoodItem(name: "Karpuz", category: .meyve,
            caloriesPer100g: 30, proteinPer100g: 0.6, carbsPer100g: 7.6, fatPer100g: 0.2, fiberPer100g: 0.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 300, label: "1 Dilim (300 g)"),
                Portion(unit: .bardak, gramsEquivalent: 154, label: "1 Bardak Küp (154 g)")
            ]),
        FoodItem(name: "Kavun", category: .meyve,
            caloriesPer100g: 34, proteinPer100g: 0.8, carbsPer100g: 8.2, fatPer100g: 0.2, fiberPer100g: 0.9,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 200, label: "1 Dilim (200 g)")
            ]),
        FoodItem(name: "Armut", category: .meyve,
            caloriesPer100g: 57, proteinPer100g: 0.4, carbsPer100g: 15.2, fatPer100g: 0.1, fiberPer100g: 3.1,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 180, label: "1 Orta Boy (180 g)")
            ]),
        FoodItem(name: "Mandalina", category: .meyve,
            caloriesPer100g: 53, proteinPer100g: 0.8, carbsPer100g: 13.3, fatPer100g: 0.3, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 75, label: "1 Adet (75 g)")
            ]),
        FoodItem(name: "Kiraz", category: .meyve,
            caloriesPer100g: 63, proteinPer100g: 1.1, carbsPer100g: 16.0, fatPer100g: 0.2, fiberPer100g: 2.1,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 138, label: "1 Bardak (138 g)"),
                Portion(unit: .adet, gramsEquivalent: 8, label: "1 Adet (8 g)")
            ]),
        FoodItem(name: "Şeftali", category: .meyve,
            caloriesPer100g: 39, proteinPer100g: 0.9, carbsPer100g: 9.5, fatPer100g: 0.3, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 150, label: "1 Orta Boy (150 g)")
            ]),
        FoodItem(name: "Avokado", category: .meyve,
            caloriesPer100g: 160, proteinPer100g: 2.0, carbsPer100g: 8.5, fatPer100g: 14.7, fiberPer100g: 6.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 150, label: "1 Orta Boy (150 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)")
            ]),
    ]}

    // MARK: - ET & TAVUK & BALIK
    private static func etler() -> [FoodItem] {[
        FoodItem(name: "Tavuk Göğsü (Izgara)", category: .et,
            caloriesPer100g: 165, proteinPer100g: 31.0, carbsPer100g: 0, fatPer100g: 3.6, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Fileto (200 g)")
            ]),
        FoodItem(name: "Tavuk But (Kaplamasız)", category: .et,
            caloriesPer100g: 209, proteinPer100g: 24.0, carbsPer100g: 0, fatPer100g: 12.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Adet But (120 g)")
            ]),
        FoodItem(name: "Kıyma (Orta Yağlı)", category: .et,
            caloriesPer100g: 254, proteinPer100g: 17.2, carbsPer100g: 0, fatPer100g: 20.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "1 Porsiyon (100 g)")
            ]),
        FoodItem(name: "Biftek (Orta Pişmiş)", category: .et,
            caloriesPer100g: 271, proteinPer100g: 26.3, carbsPer100g: 0, fatPer100g: 18.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)"),
                Portion(unit: .adet, gramsEquivalent: 250, label: "1 Büyük Biftek (250 g)")
            ]),
        FoodItem(name: "Somon (Izgara)", category: .et,
            caloriesPer100g: 208, proteinPer100g: 20.0, carbsPer100g: 0, fatPer100g: 13.4, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Fileto (200 g)")
            ]),
        FoodItem(name: "Köfte (Izgara)", category: .et,
            caloriesPer100g: 229, proteinPer100g: 20.5, carbsPer100g: 5.5, fatPer100g: 14.2, fiberPer100g: 0.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 35, label: "1 Adet (35 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 140, label: "1 Porsiyon (4 adet, 140 g)")
            ]),
        FoodItem(name: "Ton Balığı (Konserve, Süzülmüş)", category: .et,
            caloriesPer100g: 128, proteinPer100g: 29.1, carbsPer100g: 0, fatPer100g: 0.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .adet, gramsEquivalent: 160, label: "1 Kutu (160 g)")
            ]),
        FoodItem(name: "Sucuk", category: .et,
            caloriesPer100g: 450, proteinPer100g: 22.0, carbsPer100g: 2.5, fatPer100g: 39.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 10, label: "1 Dilim (10 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 50, label: "1 Porsiyon (5 dilim, 50 g)")
            ]),
        FoodItem(name: "Sosis", category: .et,
            caloriesPer100g: 301, proteinPer100g: 11.7, carbsPer100g: 2.7, fatPer100g: 26.8, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Adet (50 g)")
            ]),
        FoodItem(name: "Pastırma", category: .et,
            caloriesPer100g: 290, proteinPer100g: 32.0, carbsPer100g: 1.0, fatPer100g: 18.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 8, label: "1 Dilim (8 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 40, label: "1 Porsiyon (40 g)")
            ]),
        FoodItem(name: "Hindi Göğsü (Dilimli)", category: .et,
            caloriesPer100g: 109, proteinPer100g: 22.7, carbsPer100g: 1.7, fatPer100g: 1.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 20, label: "1 Dilim (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 80, label: "1 Porsiyon (80 g)")
            ]),
        FoodItem(name: "Hindi Füme (Dilimli)", category: .et,
            caloriesPer100g: 104, proteinPer100g: 20.0, carbsPer100g: 1.5, fatPer100g: 1.8, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 15, label: "1 İnce Dilim (15 g)"),
                Portion(unit: .dilim, gramsEquivalent: 25, label: "1 Kalın Dilim (25 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 75, label: "1 Porsiyon (75 g)")
            ]),
        FoodItem(name: "Jambon (Hindi)", category: .et,
            caloriesPer100g: 120, proteinPer100g: 17.5, carbsPer100g: 2.5, fatPer100g: 4.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 20, label: "1 Dilim (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 80, label: "1 Porsiyon (80 g)")
            ]),
        FoodItem(name: "Jambon (Dana)", category: .et,
            caloriesPer100g: 148, proteinPer100g: 15.0, carbsPer100g: 3.5, fatPer100g: 8.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 20, label: "1 Dilim (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 80, label: "1 Porsiyon (80 g)")
            ]),
        FoodItem(name: "Salam (Dana)", category: .et,
            caloriesPer100g: 282, proteinPer100g: 14.0, carbsPer100g: 2.0, fatPer100g: 24.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 10, label: "1 Dilim (10 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 50, label: "1 Porsiyon (50 g)")
            ]),
        FoodItem(name: "Sucuk (Dilimli)", category: .et,
            caloriesPer100g: 348, proteinPer100g: 18.0, carbsPer100g: 2.5, fatPer100g: 29.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 10, label: "1 Dilim (10 g)"),
                Portion(unit: .adet, gramsEquivalent: 60, label: "1 Porsiyon (60 g)")
            ]),
        FoodItem(name: "Pastırma", category: .et,
            caloriesPer100g: 278, proteinPer100g: 28.0, carbsPer100g: 2.5, fatPer100g: 17.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 8, label: "1 İnce Dilim (8 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 40, label: "1 Porsiyon (40 g)")
            ]),
        FoodItem(name: "Kavurma (Kuzu)", category: .et,
            caloriesPer100g: 295, proteinPer100g: 22.0, carbsPer100g: 0, fatPer100g: 23.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 20, label: "1 Yemek Kaşığı (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "1 Porsiyon (100 g)")
            ]),
    ]}

    // MARK: - SÜT ÜRÜNLERİ & YUMURTA
    private static func sutUrunleri() -> [FoodItem] {[
        FoodItem(name: "Süt (Tam Yağlı)", category: .sut,
            caloriesPer100g: 61, proteinPer100g: 3.2, carbsPer100g: 4.8, fatPer100g: 3.3, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Su Bardağı (200 ml)"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 ml)")
            ]),
        FoodItem(name: "Süt (Yarım Yağlı)", category: .sut,
            caloriesPer100g: 46, proteinPer100g: 3.4, carbsPer100g: 4.8, fatPer100g: 1.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)")
            ]),
        FoodItem(name: "Laktozsuz Süt", category: .sut,
            caloriesPer100g: 47, proteinPer100g: 3.3, carbsPer100g: 5.0, fatPer100g: 1.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Su Bardağı (200 ml)"),
                Portion(unit: .adet, gramsEquivalent: 250, label: "1 Kutu (250 ml)")
            ]),
        FoodItem(name: "Yoğurt (Tam Yağlı)", category: .sut,
            caloriesPer100g: 61, proteinPer100g: 3.5, carbsPer100g: 4.7, fatPer100g: 3.3, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 g)")
            ]),
        FoodItem(name: "Yoğurt (Light)", category: .sut,
            caloriesPer100g: 36, proteinPer100g: 3.5, carbsPer100g: 4.9, fatPer100g: 0.2, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)")
            ]),
        FoodItem(name: "Probiyotik Yoğurt", category: .sut,
            caloriesPer100g: 62, proteinPer100g: 3.9, carbsPer100g: 5.0, fatPer100g: 3.1, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 125, label: "1 Küçük Kap (125 g)"),
                Portion(unit: .kase, gramsEquivalent: 180, label: "1 Kase (180 g)")
            ]),
        FoodItem(name: "Laktozsuz Yoğurt", category: .sut,
            caloriesPer100g: 58, proteinPer100g: 3.8, carbsPer100g: 4.8, fatPer100g: 3.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .kase, gramsEquivalent: 180, label: "1 Kase (180 g)")
            ]),
        FoodItem(name: "Protein Yoğurt", category: .sut,
            caloriesPer100g: 76, proteinPer100g: 10.0, carbsPer100g: 4.7, fatPer100g: 1.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 160, label: "1 Kap (160 g)"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)")
            ]),
        FoodItem(name: "Skyr", category: .sut,
            caloriesPer100g: 63, proteinPer100g: 11.0, carbsPer100g: 3.9, fatPer100g: 0.2, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 170, label: "1 Kap (170 g)"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)")
            ]),
        FoodItem(name: "Beyaz Peynir", category: .sut,
            caloriesPer100g: 264, proteinPer100g: 14.9, carbsPer100g: 2.7, fatPer100g: 21.3, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 20, label: "1 Yemek Kaşığı (20 g)"),
                Portion(unit: .dilim, gramsEquivalent: 30, label: "1 Dilim (30 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 60, label: "1 Porsiyon (60 g)")
            ]),
        FoodItem(name: "Kaşar Peyniri", category: .sut,
            caloriesPer100g: 370, proteinPer100g: 25.0, carbsPer100g: 1.3, fatPer100g: 29.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 20, label: "1 Dilim (20 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 10, label: "1 Yemek Kaşığı (rendelenmiş, 10 g)")
            ]),
        FoodItem(name: "Lor Peyniri", category: .sut,
            caloriesPer100g: 98, proteinPer100g: 11.0, carbsPer100g: 3.3, fatPer100g: 4.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)")
            ]),
        FoodItem(name: "Süzme Peynir", category: .sut,
            caloriesPer100g: 72, proteinPer100g: 11.5, carbsPer100g: 3.0, fatPer100g: 1.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 20, label: "1 Yemek Kaşığı (20 g)"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Kase (150 g)"),
                Portion(unit: .kase, gramsEquivalent: 300, label: "Büyük Kase (300 g)")
            ]),
        FoodItem(name: "Süzme Yoğurt", category: .sut,
            caloriesPer100g: 97, proteinPer100g: 9.0, carbsPer100g: 4.0, fatPer100g: 5.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 25, label: "1 Yemek Kaşığı (25 g)"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Kase (150 g)"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "Büyük Kase (200 g)")
            ]),
        FoodItem(name: "Kefir", category: .sut,
            caloriesPer100g: 52, proteinPer100g: 3.4, carbsPer100g: 4.8, fatPer100g: 1.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 250, label: "1 Bardak (250 ml)"),
                Portion(unit: .adet, gramsEquivalent: 500, label: "1 Şişe (500 ml)")
            ]),
        FoodItem(name: "Çökelek", category: .sut,
            caloriesPer100g: 105, proteinPer100g: 14.0, carbsPer100g: 2.5, fatPer100g: 4.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 25, label: "1 Yemek Kaşığı (25 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "1 Porsiyon (100 g)")
            ]),
        FoodItem(name: "Yumurta", category: .sut,
            caloriesPer100g: 155, proteinPer100g: 13.0, carbsPer100g: 1.1, fatPer100g: 10.6, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 55, label: "1 Orta Boy (55 g)"),
                Portion(unit: .adet, gramsEquivalent: 65, label: "1 Büyük Boy (65 g)")
            ]),
        FoodItem(name: "Tereyağı", category: .sut,
            caloriesPer100g: 717, proteinPer100g: 0.9, carbsPer100g: 0.1, fatPer100g: 81.1, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 14, label: "1 Yemek Kaşığı (14 g)")
            ]),
        FoodItem(name: "Krem Peynir", category: .sut,
            caloriesPer100g: 342, proteinPer100g: 6.2, carbsPer100g: 4.1, fatPer100g: 34.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)")
            ]),
        FoodItem(name: "Taze Kaşar Peyniri", category: .sut,
            caloriesPer100g: 356, proteinPer100g: 25.0, carbsPer100g: 2.0, fatPer100g: 27.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 30, label: "1 Dilim (30 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 60, label: "1 Porsiyon (60 g)")
            ]),
        FoodItem(name: "Ayran", category: .sut,
            caloriesPer100g: 30, proteinPer100g: 1.8, carbsPer100g: 3.0, fatPer100g: 1.1, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Su Bardağı (200 ml)"),
                Portion(unit: .adet, gramsEquivalent: 250, label: "1 Kutu (250 ml)")
            ]),
        FoodItem(name: "Keçi Sütü", category: .sut,
            caloriesPer100g: 69, proteinPer100g: 3.6, carbsPer100g: 4.5, fatPer100g: 4.1, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)")
            ]),
        FoodItem(name: "Badem Sütü (Şekersiz)", category: .sut,
            caloriesPer100g: 15, proteinPer100g: 0.5, carbsPer100g: 0.5, fatPer100g: 1.2, fiberPer100g: 0.3,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)")
            ]),
        FoodItem(name: "Yulaf Sütü", category: .sut,
            caloriesPer100g: 47, proteinPer100g: 1.0, carbsPer100g: 8.0, fatPer100g: 1.5, fiberPer100g: 0.8,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)")
            ]),
        FoodItem(name: "Soya Sütü", category: .sut,
            caloriesPer100g: 33, proteinPer100g: 2.9, carbsPer100g: 1.8, fatPer100g: 1.8, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)")
            ]),
        FoodItem(name: "Hindistan Cevizi Sütü (İçecek)", category: .sut,
            caloriesPer100g: 22, proteinPer100g: 0.2, carbsPer100g: 2.8, fatPer100g: 1.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)")
            ]),
        FoodItem(name: "Labne Peyniri", category: .sut,
            caloriesPer100g: 170, proteinPer100g: 7.0, carbsPer100g: 4.0, fatPer100g: 14.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 20, label: "1 Yemek Kaşığı (20 g)")
            ]),
        FoodItem(name: "Provolone Peyniri", category: .sut,
            caloriesPer100g: 352, proteinPer100g: 25.6, carbsPer100g: 2.1, fatPer100g: 26.6, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 28, label: "1 Dilim (28 g)")
            ]),
    ]}

    // MARK: - BAKLAGİLLER
    private static func baklagiller() -> [FoodItem] {[
        FoodItem(name: "Kırmızı Mercimek (Pişmiş)", category: .baklagil,
            caloriesPer100g: 116, proteinPer100g: 9.0, carbsPer100g: 20.0, fatPer100g: 0.4, fiberPer100g: 7.9,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 180, label: "1 Porsiyon (180 g)")
            ]),
        FoodItem(name: "Mercimek Çorbası", category: .baklagil,
            caloriesPer100g: 57, proteinPer100g: 3.8, carbsPer100g: 8.4, fatPer100g: 1.1, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .kase, gramsEquivalent: 300, label: "1 Kase (300 ml)"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)")
            ]),
        FoodItem(name: "Nohut (Pişmiş)", category: .baklagil,
            caloriesPer100g: 164, proteinPer100g: 8.9, carbsPer100g: 27.4, fatPer100g: 2.6, fiberPer100g: 7.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .bardak, gramsEquivalent: 164, label: "1 Bardak (164 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 120, label: "1 Porsiyon (120 g)")
            ]),
        FoodItem(name: "Kuru Fasulye (Pişmiş)", category: .baklagil,
            caloriesPer100g: 127, proteinPer100g: 8.7, carbsPer100g: 22.8, fatPer100g: 0.5, fiberPer100g: 6.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 180, label: "1 Porsiyon (180 g)")
            ]),
        FoodItem(name: "Humus", category: .baklagil,
            caloriesPer100g: 166, proteinPer100g: 7.9, carbsPer100g: 14.3, fatPer100g: 9.6, fiberPer100g: 6.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .bardak, gramsEquivalent: 246, label: "1 Bardak (246 g)")
            ]),
    ]}

    // MARK: - İÇECEKLER
    private static func icecekler() -> [FoodItem] {[
        FoodItem(name: "Su", category: .icecek,
            caloriesPer100g: 0, proteinPer100g: 0, carbsPer100g: 0, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Su Bardağı (200 ml)"),
                Portion(unit: .adet, gramsEquivalent: 500, label: "1 Şişe (500 ml)")
            ]),
        FoodItem(name: "Çay (Şekersiz)", category: .icecek,
            caloriesPer100g: 1, proteinPer100g: 0, carbsPer100g: 0.2, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Bardak (200 ml)"),
                Portion(unit: .adet, gramsEquivalent: 100, label: "1 İnce Bardak (100 ml)")
            ]),
        FoodItem(name: "Türk Kahvesi (Şekersiz)", category: .icecek,
            caloriesPer100g: 2, proteinPer100g: 0.3, carbsPer100g: 0, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .adet, gramsEquivalent: 60, label: "1 Fincan (60 ml)")
            ]),
        FoodItem(name: "Filtre Kahve (Sade)", category: .icecek,
            caloriesPer100g: 2, proteinPer100g: 0.3, carbsPer100g: 0, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)")
            ]),
        FoodItem(name: "Sütlü Kahve (Latte)", category: .icecek,
            caloriesPer100g: 54, proteinPer100g: 3.0, carbsPer100g: 5.5, fatPer100g: 2.4, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 360, label: "1 Orta Boy (360 ml)")
            ]),
        FoodItem(name: "Portakal Suyu (Taze)", category: .icecek,
            caloriesPer100g: 45, proteinPer100g: 0.7, carbsPer100g: 10.4, fatPer100g: 0.2, fiberPer100g: 0.2,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Su Bardağı (200 ml)")
            ]),
        FoodItem(name: "Kola", category: .icecek,
            caloriesPer100g: 42, proteinPer100g: 0, carbsPer100g: 10.6, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)"),
                Portion(unit: .adet, gramsEquivalent: 330, label: "1 Kutu (330 ml)"),
                Portion(unit: .adet, gramsEquivalent: 500, label: "1 Şişe (500 ml)")
            ]),
        FoodItem(name: "Light Kola", category: .icecek,
            caloriesPer100g: 1, proteinPer100g: 0, carbsPer100g: 0.1, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .adet, gramsEquivalent: 330, label: "1 Kutu (330 ml)"),
                Portion(unit: .adet, gramsEquivalent: 500, label: "1 Şişe (500 ml)")
            ]),
        FoodItem(name: "Enerji İçeceği (Red Bull vb.)", category: .icecek,
            caloriesPer100g: 45, proteinPer100g: 0.4, carbsPer100g: 11.0, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .adet, gramsEquivalent: 250, label: "1 Kutu (250 ml)")
            ]),
        FoodItem(name: "Taze Sıkılmış Limonata", category: .icecek,
            caloriesPer100g: 25, proteinPer100g: 0.2, carbsPer100g: 6.4, fatPer100g: 0.1, fiberPer100g: 0.1,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 300, label: "1 Bardak (300 ml)")
            ]),
        FoodItem(name: "Smoothie (Meyve)", category: .icecek,
            caloriesPer100g: 62, proteinPer100g: 0.7, carbsPer100g: 15.0, fatPer100g: 0.2, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 300, label: "1 Bardak (300 ml)")
            ]),
        FoodItem(name: "Kombucha", category: .icecek,
            caloriesPer100g: 13, proteinPer100g: 0, carbsPer100g: 3.0, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .adet, gramsEquivalent: 330, label: "1 Şişe (330 ml)"),
                Portion(unit: .adet, gramsEquivalent: 480, label: "1 Büyük Şişe (480 ml)")
            ]),
        FoodItem(name: "Probiyotik İçecek (Yakult tarzı)", category: .icecek,
            caloriesPer100g: 70, proteinPer100g: 1.2, carbsPer100g: 15.7, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .adet, gramsEquivalent: 65, label: "1 Şişecik (65 ml)")
            ]),
        FoodItem(name: "Bitki Çayı (Şekersiz)", category: .icecek,
            caloriesPer100g: 1, proteinPer100g: 0, carbsPer100g: 0.2, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Bardak (200 ml)")
            ]),
        FoodItem(name: "Hindistan Cevizi Suyu", category: .icecek,
            caloriesPer100g: 19, proteinPer100g: 0.7, carbsPer100g: 3.7, fatPer100g: 0.2, fiberPer100g: 1.1,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .adet, gramsEquivalent: 250, label: "1 Kutu (250 ml)"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)")
            ]),
        FoodItem(name: "Maden Suyu (Sade)", category: .icecek,
            caloriesPer100g: 0, proteinPer100g: 0, carbsPer100g: 0, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Şişe (200 ml)"),
                Portion(unit: .adet, gramsEquivalent: 500, label: "1 Büyük Şişe (500 ml)")
            ]),
        FoodItem(name: "Taze Meyve Suyu (Karışık)", category: .icecek,
            caloriesPer100g: 48, proteinPer100g: 0.5, carbsPer100g: 11.0, fatPer100g: 0.1, fiberPer100g: 0.3,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 240, label: "1 Bardak (240 ml)")
            ]),
    ]}

    // MARK: - TATLILAR
    private static func tatlilar() -> [FoodItem] {[
        FoodItem(name: "Baklava", category: .tatli,
            caloriesPer100g: 428, proteinPer100g: 7.2, carbsPer100g: 40.0, fatPer100g: 27.2, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 60, label: "1 Dilim (60 g)")
            ]),
        FoodItem(name: "Sütlaç", category: .tatli,
            caloriesPer100g: 124, proteinPer100g: 3.5, carbsPer100g: 22.0, fatPer100g: 3.0, fiberPer100g: 0.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)")
            ]),
        FoodItem(name: "Çikolatalı Kek", category: .tatli,
            caloriesPer100g: 371, proteinPer100g: 5.5, carbsPer100g: 52.0, fatPer100g: 16.5, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 80, label: "1 Dilim (80 g)")
            ]),
        FoodItem(name: "Sütlü Çikolata", category: .tatli,
            caloriesPer100g: 535, proteinPer100g: 7.3, carbsPer100g: 59.4, fatPer100g: 29.7, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 10, label: "1 Kare (10 g)"),
                Portion(unit: .adet, gramsEquivalent: 40, label: "1 Bar (40 g)")
            ]),
        FoodItem(name: "Dondurma (Top)", category: .tatli,
            caloriesPer100g: 207, proteinPer100g: 3.5, carbsPer100g: 25.0, fatPer100g: 10.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 65, label: "1 Top (65 g)")
            ]),
        FoodItem(name: "Kurabiye (Bisküvi)", category: .tatli,
            caloriesPer100g: 480, proteinPer100g: 5.9, carbsPer100g: 65.0, fatPer100g: 22.0, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 12, label: "1 Adet (12 g)")
            ]),
        FoodItem(name: "Helva (Tahin)", category: .tatli,
            caloriesPer100g: 469, proteinPer100g: 12.7, carbsPer100g: 52.0, fatPer100g: 25.0, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 40, label: "1 Dilim (40 g)")
            ]),
    ]}

    // MARK: - YAĞ & SOS & BAHARAT
    private static func yagSoslar() -> [FoodItem] {[
        FoodItem(name: "Zeytinyağı", category: .yagSos,
            caloriesPer100g: 884, proteinPer100g: 0, carbsPer100g: 0, fatPer100g: 100.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 ml)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 14, label: "1 Yemek Kaşığı (14 ml)")
            ]),
        FoodItem(name: "Ayçiçek Yağı", category: .yagSos,
            caloriesPer100g: 884, proteinPer100g: 0, carbsPer100g: 0, fatPer100g: 100.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 ml)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 14, label: "1 Yemek Kaşığı (14 ml)")
            ]),
        FoodItem(name: "Ketçap", category: .yagSos,
            caloriesPer100g: 101, proteinPer100g: 1.0, carbsPer100g: 25.0, fatPer100g: 0.1, fiberPer100g: 0.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 17, label: "1 Yemek Kaşığı (17 g)")
            ]),
        FoodItem(name: "Mayonez", category: .yagSos,
            caloriesPer100g: 680, proteinPer100g: 1.0, carbsPer100g: 0.6, fatPer100g: 75.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 14, label: "1 Yemek Kaşığı (14 g)")
            ]),
        FoodItem(name: "Hardal", category: .yagSos,
            caloriesPer100g: 66, proteinPer100g: 4.4, carbsPer100g: 6.9, fatPer100g: 3.3, fiberPer100g: 3.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)")
            ]),
        FoodItem(name: "Bal", category: .yagSos,
            caloriesPer100g: 304, proteinPer100g: 0.3, carbsPer100g: 82.4, fatPer100g: 0, fiberPer100g: 0.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 7, label: "1 Çay Kaşığı (7 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 21, label: "1 Yemek Kaşığı (21 g)")
            ]),
        FoodItem(name: "Reçel", category: .yagSos,
            caloriesPer100g: 250, proteinPer100g: 0.4, carbsPer100g: 65.0, fatPer100g: 0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 7, label: "1 Çay Kaşığı (7 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 20, label: "1 Yemek Kaşığı (20 g)")
            ]),
        FoodItem(name: "Tahin", category: .yagSos,
            caloriesPer100g: 595, proteinPer100g: 17.0, carbsPer100g: 21.2, fatPer100g: 53.8, fiberPer100g: 9.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)")
            ]),
        FoodItem(name: "Şeker", category: .yagSos,
            caloriesPer100g: 400, proteinPer100g: 0, carbsPer100g: 100.0, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 4, label: "1 Çay Kaşığı (4 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 12, label: "1 Yemek Kaşığı (12 g)"),
                Portion(unit: .adet, gramsEquivalent: 5, label: "1 Kesme Şeker (5 g)")
            ]),
        FoodItem(name: "Fıstık Ezmesi", category: .yagSos,
            caloriesPer100g: 590, proteinPer100g: 25.0, carbsPer100g: 20.0, fatPer100g: 50.0, fiberPer100g: 6.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 16, label: "1 Yemek Kaşığı (16 g)")
            ]),
        FoodItem(name: "Nar Ekşisi", category: .yagSos,
            caloriesPer100g: 268, proteinPer100g: 0.8, carbsPer100g: 68.0, fatPer100g: 0.1, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 ml)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 ml)")
            ]),
        FoodItem(name: "Soya Sosu", category: .yagSos,
            caloriesPer100g: 60, proteinPer100g: 10.0, carbsPer100g: 5.6, fatPer100g: 0.1, fiberPer100g: 0.8,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 ml)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 ml)")
            ]),
        FoodItem(name: "BBQ / Barbekü Sosu", category: .yagSos,
            caloriesPer100g: 172, proteinPer100g: 1.0, carbsPer100g: 40.0, fatPer100g: 0.5, fiberPer100g: 0.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 17, label: "1 Yemek Kaşığı (17 g)")
            ]),
        FoodItem(name: "Acı Sos (Tabasco)", category: .yagSos,
            caloriesPer100g: 12, proteinPer100g: 0.6, carbsPer100g: 1.0, fatPer100g: 0.2, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 ml)")
            ]),
        FoodItem(name: "Sirke (Üzüm)", category: .yagSos,
            caloriesPer100g: 18, proteinPer100g: 0, carbsPer100g: 0.6, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 ml)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 ml)")
            ]),
        FoodItem(name: "Elma Sirkesi", category: .yagSos,
            caloriesPer100g: 22, proteinPer100g: 0, carbsPer100g: 0.9, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 ml)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 ml)")
            ]),
        FoodItem(name: "Pekmez (Üzüm)", category: .yagSos,
            caloriesPer100g: 280, proteinPer100g: 0.5, carbsPer100g: 72.0, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 7, label: "1 Çay Kaşığı (7 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 21, label: "1 Yemek Kaşığı (21 g)")
            ]),
        FoodItem(name: "Dut Pekmezi", category: .yagSos,
            caloriesPer100g: 258, proteinPer100g: 1.0, carbsPer100g: 66.0, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 7, label: "1 Çay Kaşığı (7 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 21, label: "1 Yemek Kaşığı (21 g)")
            ]),
        FoodItem(name: "Sarımsaklı Yoğurt Sosu", category: .yagSos,
            caloriesPer100g: 78, proteinPer100g: 4.5, carbsPer100g: 5.5, fatPer100g: 4.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "1 Yemek Kaşığı (30 g)"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Küçük Kase (150 g)")
            ]),
        FoodItem(name: "Tahin Sosu (Seyreltilmiş)", category: .yagSos,
            caloriesPer100g: 230, proteinPer100g: 7.0, carbsPer100g: 12.0, fatPer100g: 18.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "1 Yemek Kaşığı (30 g)")
            ]),
        FoodItem(name: "Tereyağı", category: .yagSos,
            caloriesPer100g: 717, proteinPer100g: 0.9, carbsPer100g: 0.1, fatPer100g: 81.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 14, label: "1 Yemek Kaşığı (14 g)")
            ]),
        FoodItem(name: "Margarin", category: .yagSos,
            caloriesPer100g: 720, proteinPer100g: 0.1, carbsPer100g: 0.4, fatPer100g: 80.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 14, label: "1 Yemek Kaşığı (14 g)")
            ]),
        FoodItem(name: "Nutella / Çikolatalı Fındık Ezmesi", category: .yagSos,
            caloriesPer100g: 539, proteinPer100g: 6.3, carbsPer100g: 57.5, fatPer100g: 30.9, fiberPer100g: 3.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 7, label: "1 Çay Kaşığı (7 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)")
            ]),
        FoodItem(name: "Ranch Sosu", category: .yagSos,
            caloriesPer100g: 321, proteinPer100g: 1.3, carbsPer100g: 6.0, fatPer100g: 33.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "2 Yemek Kaşığı (30 g)")
            ]),
        FoodItem(name: "Domates Sosu (Ev Yapımı)", category: .yagSos,
            caloriesPer100g: 45, proteinPer100g: 1.5, carbsPer100g: 7.5, fatPer100g: 1.2, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "1 Yemek Kaşığı (30 g)"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Kase (150 g)")
            ]),
        FoodItem(name: "Salça (Domates)", category: .yagSos,
            caloriesPer100g: 82, proteinPer100g: 3.5, carbsPer100g: 14.0, fatPer100g: 0.4, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)")
            ]),
        FoodItem(name: "Salça (Biber)", category: .yagSos,
            caloriesPer100g: 90, proteinPer100g: 3.0, carbsPer100g: 16.0, fatPer100g: 1.5, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)")
            ]),
        FoodItem(name: "Burger Sosu", category: .yagSos,
            caloriesPer100g: 358, proteinPer100g: 1.5, carbsPer100g: 14.0, fatPer100g: 33.0, fiberPer100g: 0.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 20, label: "1 Yemek Kaşığı (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 30, label: "1 Paket (30 g)")
            ]),
        FoodItem(name: "Acı Biber Ezmesi (Harissa)", category: .yagSos,
            caloriesPer100g: 132, proteinPer100g: 4.5, carbsPer100g: 9.0, fatPer100g: 9.0, fiberPer100g: 4.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)")
            ]),
        FoodItem(name: "Tzatziki / Cacık Sosu", category: .yagSos,
            caloriesPer100g: 72, proteinPer100g: 4.0, carbsPer100g: 4.5, fatPer100g: 4.0, fiberPer100g: 0.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "1 Yemek Kaşığı (30 g)"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Kase (150 g)")
            ]),
        FoodItem(name: "Sriracha Sosu", category: .yagSos,
            caloriesPer100g: 93, proteinPer100g: 2.3, carbsPer100g: 18.0, fatPer100g: 0.9, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 ml)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 17, label: "1 Yemek Kaşığı (17 ml)")
            ]),
        FoodItem(name: "Teriyaki Sosu", category: .yagSos,
            caloriesPer100g: 89, proteinPer100g: 5.2, carbsPer100g: 15.5, fatPer100g: 0.1, fiberPer100g: 0.1,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 18, label: "1 Yemek Kaşığı (18 ml)")
            ]),
        FoodItem(name: "Ekşi Krema (Sour Cream)", category: .yagSos,
            caloriesPer100g: 193, proteinPer100g: 2.4, carbsPer100g: 4.6, fatPer100g: 19.4, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "1 Yemek Kaşığı (30 g)")
            ]),
        FoodItem(name: "Guacamole", category: .yagSos,
            caloriesPer100g: 157, proteinPer100g: 2.0, carbsPer100g: 8.5, fatPer100g: 13.5, fiberPer100g: 6.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "1 Yemek Kaşığı (30 g)")
            ]),
        FoodItem(name: "Humus", category: .yagSos,
            caloriesPer100g: 166, proteinPer100g: 8.0, carbsPer100g: 14.3, fatPer100g: 9.6, fiberPer100g: 6.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "1 Yemek Kaşığı (30 g)"),
                Portion(unit: .kase, gramsEquivalent: 100, label: "1 Küçük Kase (100 g)")
            ]),
        FoodItem(name: "Zeytinyağlı & Limon Sos", category: .yagSos,
            caloriesPer100g: 476, proteinPer100g: 0.2, carbsPer100g: 1.5, fatPer100g: 52.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 ml)")
            ]),
    ]}

    // MARK: - SALATALAR (Hazır / Restoran)
    private static func salatalar() -> [FoodItem] {[
        FoodItem(name: "Çoban Salata", category: .sebze,
            caloriesPer100g: 52, proteinPer100g: 1.5, carbsPer100g: 6.5, fatPer100g: 2.5, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Büyük Kase (250 g)")
            ]),
        FoodItem(name: "Mevsim Salata (Zeytinyağlı)", category: .sebze,
            caloriesPer100g: 58, proteinPer100g: 1.4, carbsPer100g: 5.8, fatPer100g: 3.3, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)"),
                Portion(unit: .kase, gramsEquivalent: 300, label: "1 Büyük Kase (300 g)")
            ]),
        FoodItem(name: "Sezar Salata (Soslu)", category: .sebze,
            caloriesPer100g: 142, proteinPer100g: 5.5, carbsPer100g: 8.0, fatPer100g: 10.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Ton Balıklı Salata", category: .sebze,
            caloriesPer100g: 110, proteinPer100g: 11.0, carbsPer100g: 5.0, fatPer100g: 5.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Izgara Tavuklu Salata", category: .sebze,
            caloriesPer100g: 105, proteinPer100g: 12.5, carbsPer100g: 5.0, fatPer100g: 4.2, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Avokadolu Salata", category: .sebze,
            caloriesPer100g: 130, proteinPer100g: 2.5, carbsPer100g: 7.0, fatPer100g: 10.5, fiberPer100g: 3.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Tabule Salata", category: .sebze,
            caloriesPer100g: 78, proteinPer100g: 2.5, carbsPer100g: 14.5, fatPer100g: 1.5, fiberPer100g: 2.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Piyaz", category: .sebze,
            caloriesPer100g: 120, proteinPer100g: 5.5, carbsPer100g: 16.0, fatPer100g: 4.0, fiberPer100g: 4.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Semizotu Salatası", category: .sebze,
            caloriesPer100g: 68, proteinPer100g: 2.0, carbsPer100g: 4.5, fatPer100g: 4.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
    ]}

    // MARK: - FAST FOOD
    private static func fastFood() -> [FoodItem] {[
        FoodItem(name: "Hamburger (Standart)", category: .hazirYemek,
            caloriesPer100g: 254, proteinPer100g: 13.5, carbsPer100g: 24.0, fatPer100g: 11.5, fiberPer100g: 1.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 150, label: "1 Standart Hamburger (150 g)"),
                Portion(unit: .adet, gramsEquivalent: 220, label: "1 Büyük Hamburger (220 g)")
            ]),
        FoodItem(name: "Cheeseburger", category: .hazirYemek,
            caloriesPer100g: 275, proteinPer100g: 14.8, carbsPer100g: 24.0, fatPer100g: 13.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 170, label: "1 Adet (170 g)")
            ]),
        FoodItem(name: "Big Mac / Büyük Burger", category: .hazirYemek,
            caloriesPer100g: 257, proteinPer100g: 13.0, carbsPer100g: 25.0, fatPer100g: 12.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 210, label: "1 Adet (210 g)")
            ]),
        FoodItem(name: "Tavuk Burger", category: .hazirYemek,
            caloriesPer100g: 240, proteinPer100g: 13.0, carbsPer100g: 26.0, fatPer100g: 9.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 180, label: "1 Adet (180 g)")
            ]),
        FoodItem(name: "Pizza (Peynirli, 1 Dilim)", category: .hazirYemek,
            caloriesPer100g: 266, proteinPer100g: 11.4, carbsPer100g: 33.0, fatPer100g: 10.4, fiberPer100g: 2.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 107, label: "1 Dilim (107 g)"),
                Portion(unit: .adet, gramsEquivalent: 856, label: "1 Orta Pizza (8 dilim, ~856 g)")
            ]),
        FoodItem(name: "Pizza (Karışık)", category: .hazirYemek,
            caloriesPer100g: 285, proteinPer100g: 12.5, carbsPer100g: 32.0, fatPer100g: 12.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 107, label: "1 Dilim (107 g)")
            ]),
        FoodItem(name: "Patates Kızartması (Fast Food)", category: .hazirYemek,
            caloriesPer100g: 312, proteinPer100g: 3.4, carbsPer100g: 41.0, fatPer100g: 15.0, fiberPer100g: 3.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 117, label: "1 Küçük Porsiyon (117 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 154, label: "1 Orta Porsiyon (154 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 194, label: "1 Büyük Porsiyon (194 g)")
            ]),
        FoodItem(name: "Tavuk Nugget (6'lı)", category: .hazirYemek,
            caloriesPer100g: 296, proteinPer100g: 15.0, carbsPer100g: 17.0, fatPer100g: 18.5, fiberPer100g: 0.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 16, label: "1 Adet Nugget (16 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 96, label: "6'lı Porsiyon (96 g)")
            ]),
        FoodItem(name: "Hotdog / Sosisli Sandviç", category: .hazirYemek,
            caloriesPer100g: 290, proteinPer100g: 11.5, carbsPer100g: 24.0, fatPer100g: 16.5, fiberPer100g: 1.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 100, label: "1 Adet (100 g)")
            ]),
        FoodItem(name: "Wrap / Dürüm (Tavuklu)", category: .hazirYemek,
            caloriesPer100g: 218, proteinPer100g: 13.0, carbsPer100g: 23.5, fatPer100g: 7.5, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 250, label: "1 Adet Dürüm (250 g)")
            ]),
    ]}

    // MARK: - TÜRK YEMEKLERİ
    private static func turkYemekleri() -> [FoodItem] {[
        FoodItem(name: "Döner (Tavuk, Ekmeksiz)", category: .et,
            caloriesPer100g: 218, proteinPer100g: 22.5, carbsPer100g: 4.1, fatPer100g: 12.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)"),
                Portion(unit: .adet, gramsEquivalent: 350, label: "1 Yarım Ekmek Döner (350 g)")
            ]),
        FoodItem(name: "Döner (Et, Ekmeksiz)", category: .et,
            caloriesPer100g: 268, proteinPer100g: 20.0, carbsPer100g: 3.5, fatPer100g: 19.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)"),
                Portion(unit: .adet, gramsEquivalent: 350, label: "1 Yarım Ekmek Döner (350 g)")
            ]),
        FoodItem(name: "İskender Kebap", category: .et,
            caloriesPer100g: 195, proteinPer100g: 13.5, carbsPer100g: 12.0, fatPer100g: 10.0, fiberPer100g: 0.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 350, label: "1 Porsiyon (350 g)")
            ]),
        FoodItem(name: "Adana Kebap", category: .et,
            caloriesPer100g: 280, proteinPer100g: 19.5, carbsPer100g: 2.0, fatPer100g: 22.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Lahmacun", category: .tahil,
            caloriesPer100g: 230, proteinPer100g: 10.5, carbsPer100g: 28.0, fatPer100g: 8.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 130, label: "1 Adet (130 g)"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Büyük Adet (200 g)")
            ]),
        FoodItem(name: "Pide (Kaşarlı)", category: .tahil,
            caloriesPer100g: 285, proteinPer100g: 12.5, carbsPer100g: 35.0, fatPer100g: 10.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 100, label: "1 Dilim (100 g)"),
                Portion(unit: .adet, gramsEquivalent: 400, label: "1 Adet Pide (400 g)")
            ]),
        FoodItem(name: "Pide (Kıymalı)", category: .tahil,
            caloriesPer100g: 270, proteinPer100g: 13.0, carbsPer100g: 30.0, fatPer100g: 10.5, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 100, label: "1 Dilim (100 g)"),
                Portion(unit: .adet, gramsEquivalent: 400, label: "1 Adet Pide (400 g)")
            ]),
        FoodItem(name: "İmambayıldı", category: .sebze,
            caloriesPer100g: 152, proteinPer100g: 2.5, carbsPer100g: 14.5, fatPer100g: 9.5, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Karnıyarık", category: .diger,
            caloriesPer100g: 142, proteinPer100g: 6.5, carbsPer100g: 11.0, fatPer100g: 8.5, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 250, label: "1 Adet (250 g)")
            ]),
        FoodItem(name: "Mantı (Yoğurtlu)", category: .diger,
            caloriesPer100g: 198, proteinPer100g: 8.5, carbsPer100g: 24.0, fatPer100g: 7.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Dolma (Zeytinyağlı Yaprak)", category: .diger,
            caloriesPer100g: 170, proteinPer100g: 3.5, carbsPer100g: 22.5, fatPer100g: 7.5, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 20, label: "1 Adet (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 120, label: "1 Porsiyon (6 adet, 120 g)")
            ]),
        FoodItem(name: "Çorba (Sebze)", category: .diger,
            caloriesPer100g: 45, proteinPer100g: 1.8, carbsPer100g: 7.5, fatPer100g: 1.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .kase, gramsEquivalent: 300, label: "1 Kase (300 ml)")
            ]),
        FoodItem(name: "Domates Çorbası", category: .diger,
            caloriesPer100g: 55, proteinPer100g: 1.5, carbsPer100g: 9.0, fatPer100g: 1.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .kase, gramsEquivalent: 300, label: "1 Kase (300 ml)")
            ]),
        FoodItem(name: "Tavuk Çorbası", category: .diger,
            caloriesPer100g: 62, proteinPer100g: 5.5, carbsPer100g: 5.5, fatPer100g: 2.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .kase, gramsEquivalent: 300, label: "1 Kase (300 ml)")
            ]),
        FoodItem(name: "Türlü (Sebze Yemeği)", category: .sebze,
            caloriesPer100g: 82, proteinPer100g: 2.5, carbsPer100g: 11.0, fatPer100g: 3.5, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Pilav Üstü Tavuk", category: .diger,
            caloriesPer100g: 148, proteinPer100g: 11.0, carbsPer100g: 17.5, fatPer100g: 3.8, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 350, label: "1 Porsiyon (350 g)")
            ]),
        FoodItem(name: "Börek (Peynirli)", category: .tahil,
            caloriesPer100g: 310, proteinPer100g: 10.5, carbsPer100g: 28.0, fatPer100g: 17.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 100, label: "1 Dilim (100 g)"),
                Portion(unit: .adet, gramsEquivalent: 80, label: "1 Rulo (80 g)")
            ]),
        FoodItem(name: "Börek (Kıymalı)", category: .tahil,
            caloriesPer100g: 295, proteinPer100g: 11.5, carbsPer100g: 27.0, fatPer100g: 15.5, fiberPer100g: 1.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 100, label: "1 Dilim (100 g)")
            ]),
        FoodItem(name: "Gözleme (Peynirli)", category: .tahil,
            caloriesPer100g: 260, proteinPer100g: 10.0, carbsPer100g: 30.0, fatPer100g: 11.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Adet (200 g)")
            ]),
        FoodItem(name: "Menemen", category: .kahvaltilik,
            caloriesPer100g: 128, proteinPer100g: 6.5, carbsPer100g: 7.5, fatPer100g: 8.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
    ]}

    // MARK: - KAHVALTILIK
    private static func kahvaltilik() -> [FoodItem] {[
        FoodItem(name: "Yumurta (Sahanda)", category: .kahvaltilik,
            caloriesPer100g: 185, proteinPer100g: 13.6, carbsPer100g: 0.5, fatPer100g: 14.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 55, label: "1 Yumurta (55 g)")
            ]),
        FoodItem(name: "Yumurta (Haşlanmış)", category: .kahvaltilik,
            caloriesPer100g: 155, proteinPer100g: 13.0, carbsPer100g: 1.1, fatPer100g: 10.6, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 55, label: "1 Yumurta (55 g)")
            ]),
        FoodItem(name: "Omlet (Sade)", category: .kahvaltilik,
            caloriesPer100g: 154, proteinPer100g: 10.5, carbsPer100g: 0.5, fatPer100g: 12.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 110, label: "1 Adet (2 yumurta, 110 g)")
            ]),
        FoodItem(name: "Zeytin (Siyah)", category: .kahvaltilik,
            caloriesPer100g: 115, proteinPer100g: 0.8, carbsPer100g: 6.3, fatPer100g: 10.9, fiberPer100g: 3.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 4, label: "1 Adet (4 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 30, label: "1 Porsiyon (~8 adet, 30 g)")
            ]),
        FoodItem(name: "Zeytin (Yeşil)", category: .kahvaltilik,
            caloriesPer100g: 145, proteinPer100g: 1.0, carbsPer100g: 3.8, fatPer100g: 15.3, fiberPer100g: 3.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 4, label: "1 Adet (4 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 30, label: "1 Porsiyon (~8 adet, 30 g)")
            ]),
        FoodItem(name: "Domates (Kahvaltılık)", category: .kahvaltilik,
            caloriesPer100g: 18, proteinPer100g: 0.9, carbsPer100g: 3.9, fatPer100g: 0.2, fiberPer100g: 1.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Orta Boy (120 g)"),
                Portion(unit: .dilim, gramsEquivalent: 30, label: "1 Dilim (30 g)")
            ]),
        FoodItem(name: "Çay (Şekerli)", category: .kahvaltilik,
            caloriesPer100g: 17, proteinPer100g: 0, carbsPer100g: 4.5, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Bardak (200 ml)"),
                Portion(unit: .adet, gramsEquivalent: 100, label: "1 İnce Bardak (100 ml)")
            ]),
    ]}

    // MARK: - ATISTIRMALIK
    private static func atistirmalik() -> [FoodItem] {[
        FoodItem(name: "Cips (Patates)", category: .tatli,
            caloriesPer100g: 536, proteinPer100g: 7.0, carbsPer100g: 53.0, fatPer100g: 34.6, fiberPer100g: 4.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 30, label: "1 Küçük Paket (30 g)"),
                Portion(unit: .adet, gramsEquivalent: 150, label: "1 Büyük Paket (150 g)")
            ]),
        FoodItem(name: "Popcorn (Tuzlu)", category: .tatli,
            caloriesPer100g: 387, proteinPer100g: 13.0, carbsPer100g: 78.0, fatPer100g: 4.5, fiberPer100g: 14.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 8, label: "1 Bardak (8 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 30, label: "1 Porsiyon (30 g)")
            ]),
        FoodItem(name: "Fındık", category: .atistirmalik,
            caloriesPer100g: 628, proteinPer100g: 15.0, carbsPer100g: 16.7, fatPer100g: 60.8, fiberPer100g: 9.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .bardak, gramsEquivalent: 135, label: "1 Bardak (135 g)")
            ]),
        FoodItem(name: "Badem", category: .atistirmalik,
            caloriesPer100g: 579, proteinPer100g: 21.2, carbsPer100g: 21.6, fatPer100g: 49.9, fiberPer100g: 12.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 1.2, label: "1 Adet (1.2 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 Avuç (~23 adet, 28 g)")
            ]),
        FoodItem(name: "Ceviz", category: .atistirmalik,
            caloriesPer100g: 654, proteinPer100g: 15.2, carbsPer100g: 13.7, fatPer100g: 65.2, fiberPer100g: 6.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 7, label: "1 İç Ceviz (7 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 Avuç (28 g)")
            ]),
        FoodItem(name: "Kuru Üzüm", category: .atistirmalik,
            caloriesPer100g: 299, proteinPer100g: 3.1, carbsPer100g: 79.2, fatPer100g: 0.5, fiberPer100g: 3.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .bardak, gramsEquivalent: 165, label: "1 Bardak (165 g)")
            ]),
        FoodItem(name: "Granola Bar", category: .atistirmalik,
            caloriesPer100g: 471, proteinPer100g: 8.5, carbsPer100g: 64.0, fatPer100g: 20.0, fiberPer100g: 3.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 40, label: "1 Bar (40 g)")
            ]),
        FoodItem(name: "Protein Bar", category: .atistirmalik,
            caloriesPer100g: 380, proteinPer100g: 30.0, carbsPer100g: 40.0, fatPer100g: 10.0, fiberPer100g: 5.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 60, label: "1 Bar (60 g)")
            ]),
        FoodItem(name: "Antep Fıstığı", category: .atistirmalik,
            caloriesPer100g: 560, proteinPer100g: 20.0, carbsPer100g: 28.0, fatPer100g: 45.0, fiberPer100g: 10.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 1, label: "1 Adet (1 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 Avuç (28 g)")
            ]),
        FoodItem(name: "Ay Çekirdeği (Çiğ)", category: .atistirmalik,
            caloriesPer100g: 584, proteinPer100g: 20.8, carbsPer100g: 20.0, fatPer100g: 51.5, fiberPer100g: 8.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 14, label: "1 Yemek Kaşığı (14 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 Avuç (28 g)")
            ]),
        FoodItem(name: "Kabak Çekirdeği", category: .atistirmalik,
            caloriesPer100g: 559, proteinPer100g: 30.2, carbsPer100g: 10.7, fatPer100g: 49.1, fiberPer100g: 6.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 14, label: "1 Yemek Kaşığı (14 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 Avuç (28 g)")
            ]),
        FoodItem(name: "Leblebi", category: .atistirmalik,
            caloriesPer100g: 364, proteinPer100g: 19.0, carbsPer100g: 60.0, fatPer100g: 5.0, fiberPer100g: 17.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 50, label: "1 Porsiyon (50 g)")
            ]),
        FoodItem(name: "Bitter Çikolata", category: .atistirmalik,
            caloriesPer100g: 545, proteinPer100g: 5.0, carbsPer100g: 60.0, fatPer100g: 31.0, fiberPer100g: 7.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 10, label: "1 Kare (10 g)"),
                Portion(unit: .adet, gramsEquivalent: 40, label: "1 Bar (40 g)")
            ]),
        FoodItem(name: "Pirinç Galeti", category: .atistirmalik,
            caloriesPer100g: 387, proteinPer100g: 7.5, carbsPer100g: 81.0, fatPer100g: 3.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 9, label: "1 Adet (9 g)")
            ]),
        FoodItem(name: "Chia Tohumu", category: .atistirmalik,
            caloriesPer100g: 486, proteinPer100g: 16.5, carbsPer100g: 42.1, fatPer100g: 30.7, fiberPer100g: 34.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 12, label: "1 Yemek Kaşığı (12 g)")
            ]),
        FoodItem(name: "Keten Tohumu", category: .atistirmalik,
            caloriesPer100g: 534, proteinPer100g: 18.3, carbsPer100g: 28.9, fatPer100g: 42.2, fiberPer100g: 27.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 10, label: "1 Yemek Kaşığı (10 g)")
            ]),
        FoodItem(name: "Susam", category: .atistirmalik,
            caloriesPer100g: 573, proteinPer100g: 17.7, carbsPer100g: 23.5, fatPer100g: 49.7, fiberPer100g: 11.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 10, label: "1 Yemek Kaşığı (10 g)")
            ]),
        FoodItem(name: "Spirulina Tozu", category: .atistirmalik,
            caloriesPer100g: 290, proteinPer100g: 57.5, carbsPer100g: 23.9, fatPer100g: 7.7, fiberPer100g: 3.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 3, label: "1 Çay Kaşığı (3 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 7, label: "1 Yemek Kaşığı (7 g)")
            ]),
        FoodItem(name: "Whey Protein Tozu", category: .atistirmalik,
            caloriesPer100g: 380, proteinPer100g: 74.0, carbsPer100g: 10.0, fatPer100g: 6.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 30, label: "1 Ölçek (30 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 35, label: "1 Büyük Ölçek (35 g)")
            ]),
        FoodItem(name: "Hindistan Cevizi Yağı", category: .atistirmalik,
            caloriesPer100g: 862, proteinPer100g: 0, carbsPer100g: 0, fatPer100g: 100.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 5, label: "1 Çay Kaşığı (5 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 14, label: "1 Yemek Kaşığı (14 g)")
            ]),
        FoodItem(name: "Kaju Fıstığı", category: .atistirmalik,
            caloriesPer100g: 553, proteinPer100g: 18.2, carbsPer100g: 30.2, fatPer100g: 43.9, fiberPer100g: 3.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 2, label: "1 Adet (~2 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 Avuç (28 g)")
            ]),
        FoodItem(name: "Macadamia Fıstığı", category: .atistirmalik,
            caloriesPer100g: 718, proteinPer100g: 7.9, carbsPer100g: 13.8, fatPer100g: 75.8, fiberPer100g: 8.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 Avuç (28 g)")
            ]),
        FoodItem(name: "Muz Cipsi", category: .atistirmalik,
            caloriesPer100g: 519, proteinPer100g: 2.3, carbsPer100g: 58.4, fatPer100g: 33.6, fiberPer100g: 7.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 30, label: "1 Avuç (30 g)")
            ]),
        FoodItem(name: "Kuru İncir", category: .atistirmalik,
            caloriesPer100g: 249, proteinPer100g: 3.3, carbsPer100g: 63.9, fatPer100g: 0.9, fiberPer100g: 9.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 20, label: "1 Adet (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 50, label: "1 Porsiyon (50 g)")
            ]),
        FoodItem(name: "Kuru Kayısı", category: .atistirmalik,
            caloriesPer100g: 241, proteinPer100g: 3.4, carbsPer100g: 62.6, fatPer100g: 0.5, fiberPer100g: 7.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 9, label: "1 Adet (9 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 40, label: "1 Porsiyon (40 g)")
            ]),
        FoodItem(name: "Yerfıstığı (Kavrulmuş)", category: .atistirmalik,
            caloriesPer100g: 587, proteinPer100g: 25.8, carbsPer100g: 21.5, fatPer100g: 49.7, fiberPer100g: 8.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 15, label: "1 Yemek Kaşığı (15 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 Avuç (28 g)")
            ]),
        FoodItem(name: "Fıstık Ezmesi", category: .atistirmalik,
            caloriesPer100g: 588, proteinPer100g: 25.1, carbsPer100g: 20.1, fatPer100g: 49.9, fiberPer100g: 6.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 8, label: "1 Çay Kaşığı (8 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 16, label: "1 Yemek Kaşığı (16 g)")
            ]),
        FoodItem(name: "Tahin", category: .atistirmalik,
            caloriesPer100g: 595, proteinPer100g: 17.0, carbsPer100g: 21.2, fatPer100g: 53.8, fiberPer100g: 9.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .cayKasigi, gramsEquivalent: 8, label: "1 Çay Kaşığı (8 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 16, label: "1 Yemek Kaşığı (16 g)")
            ]),
    ]}

    // MARK: - PİLAVLAR
    private static func pilavlar() -> [FoodItem] {[
        FoodItem(name: "Pirinç Pilavı (Tereyağlı)", category: .tahil,
            caloriesPer100g: 155, proteinPer100g: 2.8, carbsPer100g: 28.0, fatPer100g: 3.8, fiberPer100g: 0.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 25, label: "1 Yemek Kaşığı (25 g)"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Küçük Kase (150 g)"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Büyük Kase (250 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Şehriyeli Pilav", category: .tahil,
            caloriesPer100g: 160, proteinPer100g: 3.2, carbsPer100g: 29.0, fatPer100g: 4.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 25, label: "1 Yemek Kaşığı (25 g)"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Küçük Kase (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Bulgur Pilavı", category: .tahil,
            caloriesPer100g: 140, proteinPer100g: 4.0, carbsPer100g: 26.0, fatPer100g: 2.8, fiberPer100g: 4.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 25, label: "1 Yemek Kaşığı (25 g)"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Küçük Kase (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Nohutlu Pilav", category: .tahil,
            caloriesPer100g: 162, proteinPer100g: 4.5, carbsPer100g: 29.0, fatPer100g: 3.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Küçük Kase (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Mercimek Pilavı", category: .tahil,
            caloriesPer100g: 150, proteinPer100g: 5.5, carbsPer100g: 26.0, fatPer100g: 3.0, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Küçük Kase (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "İç Pilav", category: .tahil,
            caloriesPer100g: 175, proteinPer100g: 4.0, carbsPer100g: 28.0, fatPer100g: 5.5, fiberPer100g: 1.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Küçük Kase (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Makarna (Sade, Tereyağlı)", category: .tahil,
            caloriesPer100g: 168, proteinPer100g: 5.5, carbsPer100g: 29.0, fatPer100g: 3.5, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Küçük Kase (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Makarna (Domatesli Soslu)", category: .tahil,
            caloriesPer100g: 155, proteinPer100g: 5.0, carbsPer100g: 27.0, fatPer100g: 3.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Küçük Kase (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Lazanya", category: .tahil,
            caloriesPer100g: 195, proteinPer100g: 10.0, carbsPer100g: 20.0, fatPer100g: 8.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 250, label: "1 Dilim (250 g)")
            ]),
    ]}

    // MARK: - DENİZ ÜRÜNLERİ
    private static func denizUrunleri() -> [FoodItem] {[
        FoodItem(name: "Hamsi (Tava)", category: .et,
            caloriesPer100g: 185, proteinPer100g: 20.0, carbsPer100g: 8.0, fatPer100g: 8.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 8, label: "1 Adet (8 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Hamsi (Izgara)", category: .et,
            caloriesPer100g: 131, proteinPer100g: 20.0, carbsPer100g: 0.0, fatPer100g: 5.8, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 8, label: "1 Adet (8 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Çipura (Izgara)", category: .et,
            caloriesPer100g: 115, proteinPer100g: 20.5, carbsPer100g: 0.0, fatPer100g: 3.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 300, label: "1 Adet (300 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Levrek (Izgara)", category: .et,
            caloriesPer100g: 97, proteinPer100g: 18.5, carbsPer100g: 0.0, fatPer100g: 2.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 350, label: "1 Adet (350 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Palamut (Izgara)", category: .et,
            caloriesPer100g: 172, proteinPer100g: 22.0, carbsPer100g: 0.0, fatPer100g: 9.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 80, label: "1 Dilim (80 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Lüfer (Izgara)", category: .et,
            caloriesPer100g: 158, proteinPer100g: 20.5, carbsPer100g: 0.0, fatPer100g: 8.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 250, label: "1 Adet (250 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Karides (Haşlanmış)", category: .et,
            caloriesPer100g: 99, proteinPer100g: 20.9, carbsPer100g: 0.0, fatPer100g: 1.7, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 12, label: "1 Adet Büyük (12 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Karides Güveç", category: .et,
            caloriesPer100g: 130, proteinPer100g: 16.0, carbsPer100g: 5.0, fatPer100g: 5.5, fiberPer100g: 0.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Midye Dolma", category: .et,
            caloriesPer100g: 145, proteinPer100g: 7.5, carbsPer100g: 15.0, fatPer100g: 6.0, fiberPer100g: 0.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 25, label: "1 Adet (25 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Kalamar (Tava)", category: .et,
            caloriesPer100g: 195, proteinPer100g: 14.0, carbsPer100g: 12.0, fatPer100g: 9.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Sardalya (Izgara)", category: .et,
            caloriesPer100g: 208, proteinPer100g: 24.6, carbsPer100g: 0.0, fatPer100g: 11.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 40, label: "1 Adet (40 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Sardalya (Konserve)", category: .et,
            caloriesPer100g: 208, proteinPer100g: 24.6, carbsPer100g: 0.0, fatPer100g: 11.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 125, label: "1 Kutu (125 g)")
            ]),
        FoodItem(name: "Alabalık (Izgara)", category: .et,
            caloriesPer100g: 148, proteinPer100g: 20.8, carbsPer100g: 0.0, fatPer100g: 7.2, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 250, label: "1 Adet (250 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
    ]}

    // MARK: - ÇORBALAR
    private static func corbalar() -> [FoodItem] {[
        FoodItem(name: "Ezogelin Çorbası", category: .diger,
            caloriesPer100g: 65, proteinPer100g: 3.5, carbsPer100g: 11.0, fatPer100g: 1.2, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)"),
                Portion(unit: .kase, gramsEquivalent: 400, label: "1 Büyük Kase (400 g)")
            ]),
        FoodItem(name: "Tarhana Çorbası", category: .diger,
            caloriesPer100g: 70, proteinPer100g: 3.0, carbsPer100g: 12.0, fatPer100g: 1.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)"),
                Portion(unit: .kase, gramsEquivalent: 400, label: "1 Büyük Kase (400 g)")
            ]),
        FoodItem(name: "İşkembe Çorbası", category: .diger,
            caloriesPer100g: 75, proteinPer100g: 7.0, carbsPer100g: 4.0, fatPer100g: 3.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)"),
                Portion(unit: .kase, gramsEquivalent: 400, label: "1 Büyük Kase (400 g)")
            ]),
        FoodItem(name: "Yayla Çorbası", category: .diger,
            caloriesPer100g: 68, proteinPer100g: 3.5, carbsPer100g: 8.5, fatPer100g: 2.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)"),
                Portion(unit: .kase, gramsEquivalent: 400, label: "1 Büyük Kase (400 g)")
            ]),
        FoodItem(name: "Düğün Çorbası", category: .diger,
            caloriesPer100g: 90, proteinPer100g: 6.0, carbsPer100g: 6.0, fatPer100g: 4.5, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)"),
                Portion(unit: .kase, gramsEquivalent: 400, label: "1 Büyük Kase (400 g)")
            ]),
        FoodItem(name: "Paça Çorbası", category: .diger,
            caloriesPer100g: 80, proteinPer100g: 8.0, carbsPer100g: 3.0, fatPer100g: 4.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)")
            ]),
        FoodItem(name: "Kremalı Mantar Çorbası", category: .diger,
            caloriesPer100g: 88, proteinPer100g: 2.5, carbsPer100g: 7.0, fatPer100g: 5.5, fiberPer100g: 0.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)")
            ]),
        FoodItem(name: "Soğan Çorbası", category: .diger,
            caloriesPer100g: 55, proteinPer100g: 1.5, carbsPer100g: 8.0, fatPer100g: 2.0, fiberPer100g: 0.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)")
            ]),
        FoodItem(name: "Patates Çorbası", category: .diger,
            caloriesPer100g: 72, proteinPer100g: 2.0, carbsPer100g: 11.0, fatPer100g: 2.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)")
            ]),
    ]}

    // MARK: - ZEYTİNYAĞLILAR & SEBZE YEMEKLERİ
    private static func zeytinyaglilar() -> [FoodItem] {[
        FoodItem(name: "Zeytinyağlı Taze Fasulye", category: .sebze,
            caloriesPer100g: 85, proteinPer100g: 2.0, carbsPer100g: 8.5, fatPer100g: 5.0, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Zeytinyağlı Pırasa", category: .sebze,
            caloriesPer100g: 90, proteinPer100g: 1.5, carbsPer100g: 9.0, fatPer100g: 5.5, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Zeytinyağlı Enginar", category: .sebze,
            caloriesPer100g: 95, proteinPer100g: 2.5, carbsPer100g: 7.0, fatPer100g: 6.5, fiberPer100g: 3.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 150, label: "1 Adet (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Zeytinyağlı Kereviz", category: .sebze,
            caloriesPer100g: 88, proteinPer100g: 1.8, carbsPer100g: 8.5, fatPer100g: 5.5, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Ispanak Yemeği (Kıymalı)", category: .hazirYemek,
            caloriesPer100g: 110, proteinPer100g: 8.0, carbsPer100g: 6.0, fatPer100g: 6.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Etli Bezelye", category: .hazirYemek,
            caloriesPer100g: 120, proteinPer100g: 8.5, carbsPer100g: 10.0, fatPer100g: 5.5, fiberPer100g: 3.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Etli Bamya", category: .hazirYemek,
            caloriesPer100g: 115, proteinPer100g: 7.5, carbsPer100g: 7.0, fatPer100g: 6.0, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Kapuska", category: .hazirYemek,
            caloriesPer100g: 95, proteinPer100g: 6.0, carbsPer100g: 7.0, fatPer100g: 4.5, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Patates Oturtma", category: .hazirYemek,
            caloriesPer100g: 130, proteinPer100g: 7.0, carbsPer100g: 13.0, fatPer100g: 5.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Güveç (Et ve Sebze)", category: .hazirYemek,
            caloriesPer100g: 140, proteinPer100g: 10.0, carbsPer100g: 9.0, fatPer100g: 7.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 350, label: "1 Porsiyon (350 g)")
            ]),
        FoodItem(name: "Kabak Mücver", category: .hazirYemek,
            caloriesPer100g: 150, proteinPer100g: 7.0, carbsPer100g: 12.0, fatPer100g: 8.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Adet (50 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Kısır", category: .hazirYemek,
            caloriesPer100g: 145, proteinPer100g: 4.0, carbsPer100g: 22.0, fatPer100g: 5.0, fiberPer100g: 3.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "1 Yemek Kaşığı (30 g)"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Kase (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "İçli Köfte", category: .hazirYemek,
            caloriesPer100g: 195, proteinPer100g: 9.0, carbsPer100g: 20.0, fatPer100g: 9.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 60, label: "1 Adet (60 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 180, label: "3 Adet (180 g)")
            ]),
        FoodItem(name: "Arnavut Ciğeri", category: .hazirYemek,
            caloriesPer100g: 175, proteinPer100g: 18.0, carbsPer100g: 8.0, fatPer100g: 8.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Tas Kebabı", category: .hazirYemek,
            caloriesPer100g: 155, proteinPer100g: 12.0, carbsPer100g: 7.0, fatPer100g: 9.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Tavuk Şiş (Izgara)", category: .hazirYemek,
            caloriesPer100g: 165, proteinPer100g: 25.0, carbsPer100g: 2.0, fatPer100g: 6.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 100, label: "1 Şiş (100 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "2 Şiş (250 g)")
            ]),
        FoodItem(name: "Et Şiş (Izgara)", category: .hazirYemek,
            caloriesPer100g: 210, proteinPer100g: 22.0, carbsPer100g: 1.0, fatPer100g: 13.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 100, label: "1 Şiş (100 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "2 Şiş (250 g)")
            ]),
        FoodItem(name: "Fırın Tavuk (Bütün)", category: .hazirYemek,
            caloriesPer100g: 185, proteinPer100g: 25.5, carbsPer100g: 0.0, fatPer100g: 9.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 120, label: "1 But/Kanat (120 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Kadın Budu Köfte", category: .hazirYemek,
            caloriesPer100g: 190, proteinPer100g: 14.0, carbsPer100g: 10.0, fatPer100g: 10.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 80, label: "1 Adet (80 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Urfa Kebabı", category: .hazirYemek,
            caloriesPer100g: 235, proteinPer100g: 18.0, carbsPer100g: 3.0, fatPer100g: 17.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Şiş (120 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Çiğ Köfte (Dürüm)", category: .hazirYemek,
            caloriesPer100g: 165, proteinPer100g: 4.5, carbsPer100g: 30.0, fatPer100g: 3.5, fiberPer100g: 4.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 180, label: "1 Dürüm (180 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "Tabak (100 g)")
            ]),
        FoodItem(name: "Kadayıf (Tel)", category: .tatli,
            caloriesPer100g: 310, proteinPer100g: 5.0, carbsPer100g: 45.0, fatPer100g: 12.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 100, label: "1 Dilim (100 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Künefe", category: .tatli,
            caloriesPer100g: 355, proteinPer100g: 8.0, carbsPer100g: 38.0, fatPer100g: 19.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "Büyük Porsiyon (250 g)")
            ]),
        FoodItem(name: "Revani", category: .tatli,
            caloriesPer100g: 295, proteinPer100g: 4.5, carbsPer100g: 52.0, fatPer100g: 8.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 80, label: "1 Dilim (80 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 120, label: "1 Porsiyon (120 g)")
            ]),
        FoodItem(name: "Muhallebi", category: .tatli,
            caloriesPer100g: 120, proteinPer100g: 3.5, carbsPer100g: 20.0, fatPer100g: 3.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Kase (150 g)"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "Büyük Kase (250 g)")
            ]),
        FoodItem(name: "Kazandibi", category: .tatli,
            caloriesPer100g: 155, proteinPer100g: 4.5, carbsPer100g: 25.0, fatPer100g: 4.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 120, label: "1 Dilim (120 g)")
            ]),
        FoodItem(name: "Aşure", category: .tatli,
            caloriesPer100g: 145, proteinPer100g: 3.5, carbsPer100g: 28.0, fatPer100g: 2.5, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 200, label: "1 Kase (200 g)")
            ]),
        FoodItem(name: "Lokum", category: .tatli,
            caloriesPer100g: 320, proteinPer100g: 0.5, carbsPer100g: 78.0, fatPer100g: 0.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 15, label: "1 Adet (15 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 45, label: "3 Adet (45 g)")
            ]),
        FoodItem(name: "Tulumba", category: .tatli,
            caloriesPer100g: 340, proteinPer100g: 3.5, carbsPer100g: 50.0, fatPer100g: 14.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 35, label: "1 Adet (35 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 105, label: "3 Adet (105 g)")
            ]),
        FoodItem(name: "Şekerpare", category: .tatli,
            caloriesPer100g: 360, proteinPer100g: 5.0, carbsPer100g: 52.0, fatPer100g: 15.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Adet (50 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "2 Adet (100 g)")
            ]),
        FoodItem(name: "Salep", category: .icecek,
            caloriesPer100g: 65, proteinPer100g: 2.5, carbsPer100g: 12.0, fatPer100g: 1.2, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 250, label: "1 Bardak (250 ml)"),
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml")
            ]),
        FoodItem(name: "Boza", category: .icecek,
            caloriesPer100g: 75, proteinPer100g: 1.5, carbsPer100g: 16.0, fatPer100g: 0.5, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 250, label: "1 Bardak (250 ml)"),
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml")
            ]),
        FoodItem(name: "Şalgam Suyu", category: .icecek,
            caloriesPer100g: 18, proteinPer100g: 0.5, carbsPer100g: 4.0, fatPer100g: 0.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 250, label: "1 Bardak (250 ml)")
            ]),
        FoodItem(name: "Maden Suyu", category: .icecek,
            caloriesPer100g: 0, proteinPer100g: 0.0, carbsPer100g: 0.0, fatPer100g: 0.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Bardak (200 ml)"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Küçük Şişe (200 ml)"),
                Portion(unit: .adet, gramsEquivalent: 500, label: "1 Büyük Şişe (500 ml)")
            ]),
        FoodItem(name: "Kefir", category: .icecek,
            caloriesPer100g: 52, proteinPer100g: 3.4, carbsPer100g: 4.5, fatPer100g: 1.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 250, label: "1 Bardak (250 ml)"),
                Portion(unit: .adet, gramsEquivalent: 500, label: "1 Şişe (500 ml)")
            ]),
        FoodItem(name: "Elma Suyu (Kutulu)", category: .icecek,
            caloriesPer100g: 45, proteinPer100g: 0.1, carbsPer100g: 11.0, fatPer100g: 0.0, fiberPer100g: 0.1,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Bardak (200 ml)"),
                Portion(unit: .adet, gramsEquivalent: 330, label: "1 Kutu (330 ml)")
            ]),
        FoodItem(name: "Vişne Suyu", category: .icecek,
            caloriesPer100g: 50, proteinPer100g: 0.5, carbsPer100g: 12.0, fatPer100g: 0.0, fiberPer100g: 0.2,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .bardak, gramsEquivalent: 200, label: "1 Bardak (200 ml)")
            ]),
        FoodItem(name: "Labne", category: .kahvaltilik,
            caloriesPer100g: 175, proteinPer100g: 7.5, carbsPer100g: 3.5, fatPer100g: 15.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "1 Yemek Kaşığı (30 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 60, label: "1 Porsiyon (60 g)")
            ]),
        FoodItem(name: "Kaymak", category: .kahvaltilik,
            caloriesPer100g: 335, proteinPer100g: 2.5, carbsPer100g: 3.0, fatPer100g: 35.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 20, label: "1 Yemek Kaşığı (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 50, label: "1 Porsiyon (50 g)")
            ]),
        FoodItem(name: "Çökelek", category: .kahvaltilik,
            caloriesPer100g: 105, proteinPer100g: 14.0, carbsPer100g: 2.0, fatPer100g: 5.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 25, label: "1 Yemek Kaşığı (25 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "1 Porsiyon (100 g)")
            ]),
        FoodItem(name: "Tulum Peyniri", category: .kahvaltilik,
            caloriesPer100g: 295, proteinPer100g: 19.0, carbsPer100g: 2.0, fatPer100g: 24.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 30, label: "1 Dilim (30 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 50, label: "1 Porsiyon (50 g)")
            ]),
        FoodItem(name: "Dil Peyniri", category: .kahvaltilik,
            caloriesPer100g: 280, proteinPer100g: 20.0, carbsPer100g: 2.0, fatPer100g: 22.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 20, label: "1 İnce Dilim (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 50, label: "1 Porsiyon (50 g)")
            ]),
        FoodItem(name: "Sucuklu Yumurta", category: .kahvaltilik,
            caloriesPer100g: 230, proteinPer100g: 14.0, carbsPer100g: 1.5, fatPer100g: 19.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "Büyük Porsiyon (200 g)")
            ]),
        FoodItem(name: "Nar", category: .meyve,
            caloriesPer100g: 83, proteinPer100g: 1.7, carbsPer100g: 18.7, fatPer100g: 1.2, fiberPer100g: 4.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 280, label: "1 Adet (280 g)")
            ]),
        FoodItem(name: "Taze İncir", category: .meyve,
            caloriesPer100g: 74, proteinPer100g: 0.75, carbsPer100g: 19.2, fatPer100g: 0.3, fiberPer100g: 2.9,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Adet (50 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "3 Adet (150 g)")
            ]),
        FoodItem(name: "Kuru İncir", category: .meyve,
            caloriesPer100g: 249, proteinPer100g: 3.3, carbsPer100g: 63.9, fatPer100g: 0.9, fiberPer100g: 9.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 20, label: "1 Adet (20 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 60, label: "3 Adet (60 g)")
            ]),
        FoodItem(name: "Kayısı (Taze)", category: .meyve,
            caloriesPer100g: 48, proteinPer100g: 1.4, carbsPer100g: 11.1, fatPer100g: 0.4, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 35, label: "1 Adet (35 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 140, label: "4 Adet (140 g)")
            ]),
        FoodItem(name: "Kuru Kayısı", category: .meyve,
            caloriesPer100g: 241, proteinPer100g: 3.4, carbsPer100g: 62.6, fatPer100g: 0.5, fiberPer100g: 7.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 10, label: "1 Adet (10 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 50, label: "5 Adet (50 g)")
            ]),
        FoodItem(name: "Erik", category: .meyve,
            caloriesPer100g: 46, proteinPer100g: 0.7, carbsPer100g: 11.4, fatPer100g: 0.3, fiberPer100g: 1.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 40, label: "1 Adet (40 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 160, label: "4 Adet (160 g)")
            ]),
        FoodItem(name: "Vişne", category: .meyve,
            caloriesPer100g: 50, proteinPer100g: 1.0, carbsPer100g: 12.2, fatPer100g: 0.3, fiberPer100g: 1.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Kase (150 g)")
            ]),
        FoodItem(name: "Dut", category: .meyve,
            caloriesPer100g: 43, proteinPer100g: 1.4, carbsPer100g: 9.8, fatPer100g: 0.4, fiberPer100g: 1.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Kase (150 g)")
            ]),
        FoodItem(name: "Limon", category: .meyve,
            caloriesPer100g: 29, proteinPer100g: 1.1, carbsPer100g: 9.3, fatPer100g: 0.3, fiberPer100g: 2.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 85, label: "1 Adet (85 g)"),
                Portion(unit: .dilim, gramsEquivalent: 10, label: "1 Dilim (10 g)")
            ]),
        FoodItem(name: "Pırasa", category: .sebze,
            caloriesPer100g: 61, proteinPer100g: 1.5, carbsPer100g: 14.2, fatPer100g: 0.3, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 150, label: "1 Adet (150 g)")
            ]),
        FoodItem(name: "Taze Fasulye", category: .sebze,
            caloriesPer100g: 31, proteinPer100g: 1.8, carbsPer100g: 7.1, fatPer100g: 0.1, fiberPer100g: 3.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 100, label: "1 Kase (100 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Bezelye (Taze)", category: .sebze,
            caloriesPer100g: 81, proteinPer100g: 5.4, carbsPer100g: 14.5, fatPer100g: 0.4, fiberPer100g: 5.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 20, label: "1 Yemek Kaşığı (20 g)"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Kase (150 g)")
            ]),
        FoodItem(name: "Karnabahar", category: .sebze,
            caloriesPer100g: 25, proteinPer100g: 1.9, carbsPer100g: 5.0, fatPer100g: 0.3, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Bamya", category: .sebze,
            caloriesPer100g: 33, proteinPer100g: 1.9, carbsPer100g: 7.5, fatPer100g: 0.2, fiberPer100g: 3.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 150, label: "1 Kase (150 g)")
            ]),
        FoodItem(name: "Pancar", category: .sebze,
            caloriesPer100g: 43, proteinPer100g: 1.6, carbsPer100g: 9.6, fatPer100g: 0.2, fiberPer100g: 2.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 80, label: "1 Orta Boy (80 g)")
            ]),
        FoodItem(name: "Kereviz (Sap)", category: .sebze,
            caloriesPer100g: 16, proteinPer100g: 0.7, carbsPer100g: 3.0, fatPer100g: 0.2, fiberPer100g: 1.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 40, label: "1 Sap (40 g)")
            ]),
        FoodItem(name: "Enginar", category: .sebze,
            caloriesPer100g: 47, proteinPer100g: 3.3, carbsPer100g: 10.5, fatPer100g: 0.2, fiberPer100g: 5.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Adet (120 g)")
            ]),
        FoodItem(name: "Semizotu", category: .sebze,
            caloriesPer100g: 20, proteinPer100g: 2.0, carbsPer100g: 3.4, fatPer100g: 0.4, fiberPer100g: 0.9,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 80, label: "1 Kase (80 g)")
            ]),
    ]}

    // MARK: - SOKAK YEMEKLERİ
    private static func sokakYemekleri() -> [FoodItem] {[
        FoodItem(name: "Kokoreç (Yarım Ekmek)", category: .hazirYemek,
            caloriesPer100g: 285, proteinPer100g: 18.0, carbsPer100g: 22.0, fatPer100g: 13.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "Yarım Ekmek (200 g)"),
                Portion(unit: .adet, gramsEquivalent: 350, label: "Tam Ekmek (350 g)")
            ]),
        FoodItem(name: "Kokoreç (Dürüm)", category: .hazirYemek,
            caloriesPer100g: 255, proteinPer100g: 16.0, carbsPer100g: 18.0, fatPer100g: 12.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 220, label: "1 Dürüm (220 g)")
            ]),
        FoodItem(name: "Tantuni (Dürüm)", category: .hazirYemek,
            caloriesPer100g: 210, proteinPer100g: 14.0, carbsPer100g: 22.0, fatPer100g: 7.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Dürüm (200 g)"),
                Portion(unit: .adet, gramsEquivalent: 300, label: "Büyük Dürüm (300 g)")
            ]),
        FoodItem(name: "Balık Ekmek", category: .hazirYemek,
            caloriesPer100g: 195, proteinPer100g: 14.0, carbsPer100g: 22.0, fatPer100g: 5.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 250, label: "1 Adet (250 g)")
            ]),
        FoodItem(name: "Midye Tava (Tabak)", category: .hazirYemek,
            caloriesPer100g: 200, proteinPer100g: 10.0, carbsPer100g: 14.0, fatPer100g: 11.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 15, label: "1 Adet (15 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Tabak (200 g)")
            ]),
        FoodItem(name: "Kumpir (Standart)", category: .hazirYemek,
            caloriesPer100g: 170, proteinPer100g: 5.5, carbsPer100g: 22.0, fatPer100g: 7.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 400, label: "Standart (400 g)"),
                Portion(unit: .adet, gramsEquivalent: 550, label: "Dolu Dolu (550 g)")
            ]),
        FoodItem(name: "Islak Hamburger", category: .hazirYemek,
            caloriesPer100g: 240, proteinPer100g: 12.0, carbsPer100g: 26.0, fatPer100g: 9.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 130, label: "1 Adet (130 g)")
            ]),
        FoodItem(name: "Saç Kavurma", category: .hazirYemek,
            caloriesPer100g: 230, proteinPer100g: 20.0, carbsPer100g: 5.0, fatPer100g: 14.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "Büyük Porsiyon (300 g)")
            ]),
        FoodItem(name: "Cağ Kebabı", category: .hazirYemek,
            caloriesPer100g: 255, proteinPer100g: 19.0, carbsPer100g: 1.0, fatPer100g: 19.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 30, label: "1 Dilim (30 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Tavuk Kanat (Izgara)", category: .hazirYemek,
            caloriesPer100g: 220, proteinPer100g: 19.0, carbsPer100g: 0.0, fatPer100g: 15.5, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 55, label: "1 Adet (55 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 220, label: "4 Adet (220 g)")
            ]),
        FoodItem(name: "Tavuk Kanat (Fırın/Soslu)", category: .hazirYemek,
            caloriesPer100g: 265, proteinPer100g: 18.0, carbsPer100g: 5.0, fatPer100g: 19.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 55, label: "1 Adet (55 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 220, label: "4 Adet (220 g)")
            ]),
        FoodItem(name: "Boyoz", category: .kahvaltilik,
            caloriesPer100g: 390, proteinPer100g: 8.5, carbsPer100g: 42.0, fatPer100g: 21.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 90, label: "1 Adet (90 g)")
            ]),
        FoodItem(name: "Açma", category: .kahvaltilik,
            caloriesPer100g: 355, proteinPer100g: 8.0, carbsPer100g: 44.0, fatPer100g: 16.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 80, label: "1 Adet (80 g)")
            ]),
        FoodItem(name: "Çiğ Börek", category: .hazirYemek,
            caloriesPer100g: 305, proteinPer100g: 11.0, carbsPer100g: 30.0, fatPer100g: 16.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 150, label: "1 Adet (150 g)")
            ]),
        FoodItem(name: "Lahmacun + Dürüm", category: .hazirYemek,
            caloriesPer100g: 210, proteinPer100g: 10.0, carbsPer100g: 25.0, fatPer100g: 7.5, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Dürüm (200 g)")
            ]),
        FoodItem(name: "Tost (Kaşarlı)", category: .hazirYemek,
            caloriesPer100g: 280, proteinPer100g: 12.0, carbsPer100g: 30.0, fatPer100g: 12.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 150, label: "1 Adet (150 g)")
            ]),
        FoodItem(name: "Tost (Karışık)", category: .hazirYemek,
            caloriesPer100g: 295, proteinPer100g: 14.0, carbsPer100g: 29.0, fatPer100g: 13.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 170, label: "1 Adet (170 g)")
            ]),
        FoodItem(name: "Waffle (Sade)", category: .hazirYemek,
            caloriesPer100g: 320, proteinPer100g: 7.5, carbsPer100g: 45.0, fatPer100g: 12.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 100, label: "1 Adet (100 g)"),
                Portion(unit: .adet, gramsEquivalent: 180, label: "Büyük (180 g)")
            ]),
        FoodItem(name: "Gözleme (Patatesli)", category: .hazirYemek,
            caloriesPer100g: 220, proteinPer100g: 5.5, carbsPer100g: 30.0, fatPer100g: 9.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Adet (200 g)")
            ]),
        FoodItem(name: "Falafel", category: .hazirYemek,
            caloriesPer100g: 333, proteinPer100g: 13.3, carbsPer100g: 31.8, fatPer100g: 17.8, fiberPer100g: 5.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 17, label: "1 Adet (17 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "6 Adet (100 g)")
            ]),
        FoodItem(name: "Pide (Sucuklu)", category: .hazirYemek,
            caloriesPer100g: 295, proteinPer100g: 12.0, carbsPer100g: 30.0, fatPer100g: 13.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 100, label: "1 Dilim (100 g)"),
                Portion(unit: .adet, gramsEquivalent: 350, label: "1 Tam Pide (350 g)")
            ]),
        FoodItem(name: "Pide (Yumurtalı)", category: .hazirYemek,
            caloriesPer100g: 245, proteinPer100g: 11.0, carbsPer100g: 28.0, fatPer100g: 10.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 100, label: "1 Dilim (100 g)"),
                Portion(unit: .adet, gramsEquivalent: 320, label: "1 Tam Pide (320 g)")
            ]),
        FoodItem(name: "Döner Dürüm (Tavuk)", category: .hazirYemek,
            caloriesPer100g: 200, proteinPer100g: 14.0, carbsPer100g: 22.0, fatPer100g: 6.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 280, label: "1 Dürüm (280 g)")
            ]),
        FoodItem(name: "Döner Dürüm (Et)", category: .hazirYemek,
            caloriesPer100g: 240, proteinPer100g: 15.0, carbsPer100g: 22.0, fatPer100g: 10.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 280, label: "1 Dürüm (280 g)")
            ]),
        FoodItem(name: "Döner Ekmek (Tavuk)", category: .hazirYemek,
            caloriesPer100g: 215, proteinPer100g: 13.0, carbsPer100g: 24.0, fatPer100g: 7.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 300, label: "1 Ekmek (300 g)")
            ]),
        FoodItem(name: "Döner Ekmek (Et)", category: .hazirYemek,
            caloriesPer100g: 255, proteinPer100g: 14.0, carbsPer100g: 24.0, fatPer100g: 11.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 300, label: "1 Ekmek (300 g)")
            ]),
        FoodItem(name: "Kuzu Tandır", category: .hazirYemek,
            caloriesPer100g: 235, proteinPer100g: 22.0, carbsPer100g: 0.0, fatPer100g: 16.0, fiberPer100g: 0.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "Büyük Porsiyon (300 g)")
            ]),
        FoodItem(name: "Pilav Üstü Et", category: .hazirYemek,
            caloriesPer100g: 175, proteinPer100g: 10.0, carbsPer100g: 18.0, fatPer100g: 7.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 350, label: "1 Porsiyon (350 g)")
            ]),
        FoodItem(name: "Simit + Beyaz Peynir", category: .kahvaltilik,
            caloriesPer100g: 285, proteinPer100g: 12.0, carbsPer100g: 38.0, fatPer100g: 9.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 170, label: "1 Simit + Peynir (170 g)")
            ]),
    ]}

    // MARK: - EKSTRA TÜRK YEMEKLERİ (Makarna, Börek, Et, Tatlı, Kahvaltı, Çorba, Dolma vb.)
    private static func ekstraTurkYemekleri() -> [FoodItem] {
        var list: [FoodItem] = []
        list += makarnaCesitleri()
        list += borekCesitleri()
        list += etYemekleriEkstra()
        list += tatlilarEkstra()
        list += kahvaltilıkEkstra()
        list += corbaEkstra()
        list += baklagillerEkstra()
        list += dolmalarVeSarmas()
        return list
    }

    // MARK: Makarna Çeşitleri
    private static func makarnaCesitleri() -> [FoodItem] {[
        FoodItem(name: "Yoğurtlu Makarna", category: .tahil,
            caloriesPer100g: 185, proteinPer100g: 7.0, carbsPer100g: 28.0, fatPer100g: 5.5, fiberPer100g: 1.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Kıymalı Makarna", category: .tahil,
            caloriesPer100g: 195, proteinPer100g: 10.5, carbsPer100g: 25.0, fatPer100g: 6.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Fırın Makarna", category: .tahil,
            caloriesPer100g: 215, proteinPer100g: 9.0, carbsPer100g: 28.0, fatPer100g: 7.5, fiberPer100g: 1.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Sebzeli Makarna", category: .tahil,
            caloriesPer100g: 155, proteinPer100g: 5.5, carbsPer100g: 26.0, fatPer100g: 3.5, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Peynirli Makarna", category: .tahil,
            caloriesPer100g: 220, proteinPer100g: 9.5, carbsPer100g: 27.0, fatPer100g: 8.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 280, label: "1 Porsiyon (280 g)")
            ]),
        FoodItem(name: "Tavuklu Makarna (Kremalı)", category: .tahil,
            caloriesPer100g: 200, proteinPer100g: 12.0, carbsPer100g: 23.0, fatPer100g: 7.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Domatesli Makarna Çorbası", category: .diger,
            caloriesPer100g: 65, proteinPer100g: 2.5, carbsPer100g: 11.0, fatPer100g: 1.5, fiberPer100g: 0.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)")
            ]),
    ]}

    // MARK: Börek Çeşitleri
    private static func borekCesitleri() -> [FoodItem] {[
        FoodItem(name: "Su Böreği (Peynirli)", category: .tahil,
            caloriesPer100g: 270, proteinPer100g: 11.0, carbsPer100g: 28.0, fatPer100g: 13.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 150, label: "1 Dilim (150 g)"),
                Portion(unit: .dilim, gramsEquivalent: 100, label: "1 Küçük Dilim (100 g)")
            ]),
        FoodItem(name: "Ispanaklı Börek", category: .tahil,
            caloriesPer100g: 255, proteinPer100g: 8.5, carbsPer100g: 27.0, fatPer100g: 12.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 70, label: "1 Üçgen Börek (70 g)"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Rulo Börek (50 g)"),
                Portion(unit: .dilim, gramsEquivalent: 120, label: "1 Tepsi Dilimi (120 g)")
            ]),
        FoodItem(name: "Patatesli Börek", category: .tahil,
            caloriesPer100g: 240, proteinPer100g: 5.5, carbsPer100g: 32.0, fatPer100g: 10.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 70, label: "1 Üçgen Börek (70 g)"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Rulo Börek (50 g)"),
                Portion(unit: .dilim, gramsEquivalent: 120, label: "1 Tepsi Dilimi (120 g)")
            ]),
        FoodItem(name: "Peynirli Börek (Üçgen)", category: .tahil,
            caloriesPer100g: 285, proteinPer100g: 10.0, carbsPer100g: 29.0, fatPer100g: 14.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 70, label: "1 Üçgen Börek (70 g)"),
                Portion(unit: .adet, gramsEquivalent: 85, label: "1 Büyük Üçgen (85 g)")
            ]),
        FoodItem(name: "Peynirli Börek (Rulo)", category: .tahil,
            caloriesPer100g: 285, proteinPer100g: 10.0, carbsPer100g: 29.0, fatPer100g: 14.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Rulo (50 g)"),
                Portion(unit: .adet, gramsEquivalent: 70, label: "1 Büyük Rulo (70 g)")
            ]),
        FoodItem(name: "Kıymalı Börek (Üçgen)", category: .tahil,
            caloriesPer100g: 295, proteinPer100g: 12.0, carbsPer100g: 28.0, fatPer100g: 14.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 70, label: "1 Üçgen Börek (70 g)"),
                Portion(unit: .adet, gramsEquivalent: 85, label: "1 Büyük Üçgen (85 g)")
            ]),
        FoodItem(name: "Kıymalı Börek (Rulo)", category: .tahil,
            caloriesPer100g: 295, proteinPer100g: 12.0, carbsPer100g: 28.0, fatPer100g: 14.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Rulo (50 g)"),
                Portion(unit: .adet, gramsEquivalent: 70, label: "1 Büyük Rulo (70 g)")
            ]),
        FoodItem(name: "Sigara Böreği (Peynirli)", category: .tahil,
            caloriesPer100g: 310, proteinPer100g: 10.0, carbsPer100g: 30.0, fatPer100g: 16.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 40, label: "1 Adet (40 g)"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "5 Adet (200 g)")
            ]),
        FoodItem(name: "Kol Böreği (Peynirli)", category: .tahil,
            caloriesPer100g: 280, proteinPer100g: 10.5, carbsPer100g: 29.0, fatPer100g: 13.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 130, label: "1 Dilim (130 g)")
            ]),
        FoodItem(name: "Tepsi Böreği (Kıymalı)", category: .tahil,
            caloriesPer100g: 290, proteinPer100g: 12.0, carbsPer100g: 27.0, fatPer100g: 14.0, fiberPer100g: 1.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 150, label: "1 Dilim (150 g)"),
                Portion(unit: .dilim, gramsEquivalent: 100, label: "1 Küçük Dilim (100 g)")
            ]),
    ]}

    // MARK: Et Yemekleri Ekstra
    private static func etYemekleriEkstra() -> [FoodItem] {[
        FoodItem(name: "Hünkar Beğendi", category: .et,
            caloriesPer100g: 175, proteinPer100g: 12.0, carbsPer100g: 8.0, fatPer100g: 11.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 350, label: "1 Porsiyon (350 g)")
            ]),
        FoodItem(name: "Ali Nazik Kebap", category: .et,
            caloriesPer100g: 165, proteinPer100g: 13.0, carbsPer100g: 6.0, fatPer100g: 10.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 350, label: "1 Porsiyon (350 g)")
            ]),
        FoodItem(name: "Beyti Kebap", category: .et,
            caloriesPer100g: 245, proteinPer100g: 18.0, carbsPer100g: 15.0, fatPer100g: 13.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Patlıcan Kebabı", category: .et,
            caloriesPer100g: 180, proteinPer100g: 11.0, carbsPer100g: 10.0, fatPer100g: 10.5, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 350, label: "1 Porsiyon (350 g)")
            ]),
        FoodItem(name: "Çöp Şiş", category: .et,
            caloriesPer100g: 220, proteinPer100g: 20.0, carbsPer100g: 2.0, fatPer100g: 14.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Şiş (50 g)")
            ]),
        FoodItem(name: "Kuzu Pirzola (Izgara)", category: .et,
            caloriesPer100g: 285, proteinPer100g: 22.0, carbsPer100g: 0, fatPer100g: 21.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 90, label: "1 Pirzola (90 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 270, label: "3 Pirzola (270 g)")
            ]),
        FoodItem(name: "Dana Antrikot (Izgara)", category: .et,
            caloriesPer100g: 270, proteinPer100g: 25.0, carbsPer100g: 0, fatPer100g: 18.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Kavurma (Dana)", category: .et,
            caloriesPer100g: 310, proteinPer100g: 22.0, carbsPer100g: 3.0, fatPer100g: 24.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Kavurma (Kuzu)", category: .et,
            caloriesPer100g: 330, proteinPer100g: 20.0, carbsPer100g: 2.0, fatPer100g: 27.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Orman Kebabı", category: .et,
            caloriesPer100g: 170, proteinPer100g: 13.0, carbsPer100g: 9.0, fatPer100g: 9.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 350, label: "1 Porsiyon (350 g)")
            ]),
        FoodItem(name: "Çerkez Tavuğu", category: .et,
            caloriesPer100g: 235, proteinPer100g: 20.0, carbsPer100g: 5.0, fatPer100g: 15.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Patlıcan Musakka", category: .et,
            caloriesPer100g: 155, proteinPer100g: 8.5, carbsPer100g: 8.0, fatPer100g: 10.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Kağıt Kebabı", category: .et,
            caloriesPer100g: 195, proteinPer100g: 17.0, carbsPer100g: 4.0, fatPer100g: 12.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Ciğer Sarma", category: .et,
            caloriesPer100g: 210, proteinPer100g: 16.0, carbsPer100g: 8.0, fatPer100g: 13.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
    ]}

    // MARK: Tatlılar Ekstra
    private static func tatlilarEkstra() -> [FoodItem] {[
        FoodItem(name: "Kabak Tatlısı", category: .tatli,
            caloriesPer100g: 195, proteinPer100g: 1.5, carbsPer100g: 40.0, fatPer100g: 4.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Ayva Tatlısı", category: .tatli,
            caloriesPer100g: 175, proteinPer100g: 1.0, carbsPer100g: 36.0, fatPer100g: 4.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Güllaç", category: .tatli,
            caloriesPer100g: 145, proteinPer100g: 4.5, carbsPer100g: 27.0, fatPer100g: 2.5, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Keşkül", category: .tatli,
            caloriesPer100g: 165, proteinPer100g: 4.0, carbsPer100g: 28.0, fatPer100g: 4.5, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Tavuk Göğsü (Tatlı)", category: .tatli,
            caloriesPer100g: 155, proteinPer100g: 5.0, carbsPer100g: 28.0, fatPer100g: 3.5, fiberPer100g: 0.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Fırın Sütlaç", category: .tatli,
            caloriesPer100g: 150, proteinPer100g: 4.5, carbsPer100g: 26.0, fatPer100g: 3.5, fiberPer100g: 0.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Trileçe", category: .tatli,
            caloriesPer100g: 285, proteinPer100g: 5.5, carbsPer100g: 38.0, fatPer100g: 12.0, fiberPer100g: 0.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 120, label: "1 Dilim (120 g)")
            ]),
        FoodItem(name: "Profiterol", category: .tatli,
            caloriesPer100g: 320, proteinPer100g: 5.0, carbsPer100g: 32.0, fatPer100g: 19.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Krem Karamel", category: .tatli,
            caloriesPer100g: 155, proteinPer100g: 4.0, carbsPer100g: 25.0, fatPer100g: 4.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Adet (120 g)")
            ]),
        FoodItem(name: "Supangle", category: .tatli,
            caloriesPer100g: 195, proteinPer100g: 5.0, carbsPer100g: 30.0, fatPer100g: 6.5, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Çikolatalı Sufle", category: .tatli,
            caloriesPer100g: 380, proteinPer100g: 7.0, carbsPer100g: 42.0, fatPer100g: 20.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Adet (120 g)")
            ]),
        FoodItem(name: "Dondurma (Dondurma Külahı)", category: .tatli,
            caloriesPer100g: 210, proteinPer100g: 3.5, carbsPer100g: 28.0, fatPer100g: 9.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Külah (120 g)")
            ]),
    ]}

    // MARK: Kahvaltılık Ekstra
    private static func kahvaltilıkEkstra() -> [FoodItem] {[
        FoodItem(name: "Çılbır (Yoğurtlu Yumurta)", category: .kahvaltilik,
            caloriesPer100g: 130, proteinPer100g: 8.5, carbsPer100g: 5.0, fatPer100g: 8.5, fiberPer100g: 0.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Tahin Pekmez", category: .kahvaltilik,
            caloriesPer100g: 430, proteinPer100g: 8.0, carbsPer100g: 52.0, fatPer100g: 22.0, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 30, label: "1 Yemek Kaşığı (30 g)")
            ]),
        FoodItem(name: "Pekmez", category: .kahvaltilik,
            caloriesPer100g: 290, proteinPer100g: 0.5, carbsPer100g: 72.0, fatPer100g: 0.2, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 20, label: "1 Tatlı Kaşığı (20 g)"),
                Portion(unit: .yemekKasigi, gramsEquivalent: 35, label: "1 Yemek Kaşığı (35 g)")
            ]),
        FoodItem(name: "Kaygana", category: .kahvaltilik,
            caloriesPer100g: 195, proteinPer100g: 9.0, carbsPer100g: 18.0, fatPer100g: 9.5, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Adet (120 g)")
            ]),
        FoodItem(name: "Pastırmalı Yumurta", category: .kahvaltilik,
            caloriesPer100g: 190, proteinPer100g: 14.0, carbsPer100g: 1.5, fatPer100g: 14.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Kavurmalı Yumurta", category: .kahvaltilik,
            caloriesPer100g: 200, proteinPer100g: 13.0, carbsPer100g: 2.0, fatPer100g: 16.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Porsiyon (150 g)")
            ]),
        FoodItem(name: "Türk Kahvesi (Şekerli)", category: .kahvaltilik,
            caloriesPer100g: 22, proteinPer100g: 0.3, carbsPer100g: 4.5, fatPer100g: 0.2, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 60, label: "1 Fincan (60 ml)")
            ]),
        FoodItem(name: "Türk Kahvesi (Orta Şekerli)", category: .kahvaltilik,
            caloriesPer100g: 12, proteinPer100g: 0.3, carbsPer100g: 2.0, fatPer100g: 0.2, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .bardak, gramsEquivalent: 60, label: "1 Fincan (60 ml)")
            ]),
    ]}

    // MARK: Çorba Ekstra
    private static func corbaEkstra() -> [FoodItem] {[
        FoodItem(name: "Beyran Çorbası", category: .diger,
            caloriesPer100g: 85, proteinPer100g: 7.5, carbsPer100g: 5.0, fatPer100g: 4.0, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 300, label: "1 Kase (300 g)")
            ]),
        FoodItem(name: "Analı Kızlı Çorbası", category: .diger,
            caloriesPer100g: 95, proteinPer100g: 5.5, carbsPer100g: 12.0, fatPer100g: 3.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)")
            ]),
        FoodItem(name: "Kelle Paça Çorbası", category: .diger,
            caloriesPer100g: 65, proteinPer100g: 7.0, carbsPer100g: 2.0, fatPer100g: 3.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 300, label: "1 Kase (300 g)")
            ]),
        FoodItem(name: "Toyga Çorbası", category: .diger,
            caloriesPer100g: 75, proteinPer100g: 4.5, carbsPer100g: 9.0, fatPer100g: 2.5, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)")
            ]),
        FoodItem(name: "Kırmızı Mercimek Çorbası", category: .diger,
            caloriesPer100g: 80, proteinPer100g: 5.0, carbsPer100g: 11.5, fatPer100g: 2.0, fiberPer100g: 2.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)")
            ]),
        FoodItem(name: "Yeşil Mercimek Çorbası", category: .diger,
            caloriesPer100g: 85, proteinPer100g: 5.5, carbsPer100g: 12.0, fatPer100g: 2.0, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)")
            ]),
        FoodItem(name: "Nohut Çorbası", category: .diger,
            caloriesPer100g: 90, proteinPer100g: 5.0, carbsPer100g: 13.0, fatPer100g: 2.5, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .kase, gramsEquivalent: 250, label: "1 Kase (250 g)")
            ]),
    ]}

    // MARK: Baklagiller Ekstra
    private static func baklagillerEkstra() -> [FoodItem] {[
        FoodItem(name: "Barbunya Pilaki", category: .diger,
            caloriesPer100g: 105, proteinPer100g: 5.5, carbsPer100g: 14.0, fatPer100g: 3.0, fiberPer100g: 4.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Porsiyon (250 g)")
            ]),
        FoodItem(name: "Kuru Fasulye (Pastırmalı)", category: .diger,
            caloriesPer100g: 145, proteinPer100g: 10.0, carbsPer100g: 16.0, fatPer100g: 5.0, fiberPer100g: 5.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Kuru Fasulye (Sucuklu)", category: .diger,
            caloriesPer100g: 155, proteinPer100g: 9.5, carbsPer100g: 15.0, fatPer100g: 6.5, fiberPer100g: 5.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Porsiyon (300 g)")
            ]),
        FoodItem(name: "Börülce (Pişmiş)", category: .diger,
            caloriesPer100g: 100, proteinPer100g: 6.5, carbsPer100g: 16.0, fatPer100g: 1.5, fiberPer100g: 4.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Barbunya (Pişmiş)", category: .diger,
            caloriesPer100g: 110, proteinPer100g: 7.0, carbsPer100g: 17.0, fatPer100g: 1.5, fiberPer100g: 4.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
        FoodItem(name: "Siyez Buğdayı (Pişmiş)", category: .diger,
            caloriesPer100g: 130, proteinPer100g: 5.5, carbsPer100g: 25.0, fatPer100g: 1.5, fiberPer100g: 4.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Porsiyon (200 g)")
            ]),
    ]}

    // MARK: Dolmalar ve Sarmalar
    private static func dolmalarVeSarmas() -> [FoodItem] {[
        FoodItem(name: "Biber Dolması (Etli)", category: .et,
            caloriesPer100g: 130, proteinPer100g: 8.0, carbsPer100g: 12.0, fatPer100g: 5.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 80, label: "1 Biber (80 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 320, label: "4 Biber (320 g)")
            ]),
        FoodItem(name: "Biber Dolması (Zeytinyağlı)", category: .sebze,
            caloriesPer100g: 110, proteinPer100g: 2.5, carbsPer100g: 16.0, fatPer100g: 4.5, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 75, label: "1 Biber (75 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "4 Biber (300 g)")
            ]),
        FoodItem(name: "Kabak Dolması (Etli)", category: .et,
            caloriesPer100g: 120, proteinPer100g: 7.5, carbsPer100g: 10.0, fatPer100g: 5.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 100, label: "1 Kabak (100 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "3 Kabak (300 g)")
            ]),
        FoodItem(name: "Lahana Sarması (Etli)", category: .et,
            caloriesPer100g: 115, proteinPer100g: 6.5, carbsPer100g: 11.0, fatPer100g: 4.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Sarma (50 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "5 Sarma (250 g)")
            ]),
        FoodItem(name: "Lahana Sarması (Zeytinyağlı)", category: .sebze,
            caloriesPer100g: 95, proteinPer100g: 2.0, carbsPer100g: 14.0, fatPer100g: 4.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 45, label: "1 Sarma (45 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 225, label: "5 Sarma (225 g)")
            ]),
        FoodItem(name: "Patlıcan Dolması (Etli)", category: .et,
            caloriesPer100g: 125, proteinPer100g: 7.0, carbsPer100g: 9.0, fatPer100g: 6.5, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Patlıcan (120 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 360, label: "3 Patlıcan (360 g)")
            ]),
    ]}

    // MARK: - INTERNATIONAL FOODS
    private static func internationalFoods() -> [FoodItem] {
        var list: [FoodItem] = []
        list += internationalProteins()
        list += internationalCarbs()
        list += internationalDairy()
        list += internationalFruits()
        list += internationalVeggies()
        list += internationalFastFood()
        list += internationalSnacks()
        list += internationalBreakfast()
        list += internationalDrinks()
        return list
    }

    // MARK: Proteins
    private static func internationalProteins() -> [FoodItem] {[
        FoodItem(name: "Chicken Breast (Grilled)", category: .et,
            caloriesPer100g: 165, proteinPer100g: 31.0, carbsPer100g: 0, fatPer100g: 3.6, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "1 Small (100 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Medium (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Large (200 g)"),
            ]),
        FoodItem(name: "Chicken Thigh (Grilled)", category: .et,
            caloriesPer100g: 209, proteinPer100g: 26.0, carbsPer100g: 0, fatPer100g: 11.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 100, label: "1 Thigh (100 g)"),
            ]),
        FoodItem(name: "Ground Beef (Lean, 90%)", category: .et,
            caloriesPer100g: 215, proteinPer100g: 26.0, carbsPer100g: 0, fatPer100g: 12.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "150 g"),
            ]),
        FoodItem(name: "Beef Steak (Sirloin)", category: .et,
            caloriesPer100g: 207, proteinPer100g: 26.0, carbsPer100g: 0, fatPer100g: 11.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Steak (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 225, label: "1 Large Steak (225 g)"),
            ]),
        FoodItem(name: "Turkey Breast (Cooked)", category: .et,
            caloriesPer100g: 157, proteinPer100g: 29.0, carbsPer100g: 0, fatPer100g: 3.7, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
                Portion(unit: .dilim, gramsEquivalent: 28, label: "1 Slice (28 g)"),
            ]),
        FoodItem(name: "Salmon (Baked)", category: .et,
            caloriesPer100g: 208, proteinPer100g: 20.0, carbsPer100g: 0, fatPer100g: 13.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "1 Fillet (150 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Large Fillet (200 g)"),
            ]),
        FoodItem(name: "Tuna (Canned in Water)", category: .et,
            caloriesPer100g: 116, proteinPer100g: 26.0, carbsPer100g: 0, fatPer100g: 1.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 140, label: "1 Can (140 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 85, label: "3 oz (85 g)"),
            ]),
        FoodItem(name: "Shrimp (Cooked)", category: .et,
            caloriesPer100g: 99, proteinPer100g: 24.0, carbsPer100g: 0.2, fatPer100g: 0.3, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
                Portion(unit: .adet, gramsEquivalent: 15, label: "1 Large Shrimp (15 g)"),
            ]),
        FoodItem(name: "Egg (Large)", category: .sut,
            caloriesPer100g: 143, proteinPer100g: 13.0, carbsPer100g: 0.7, fatPer100g: 9.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 50, label: "1 Large Egg (50 g)"),
                Portion(unit: .adet, gramsEquivalent: 100, label: "2 Eggs (100 g)"),
                Portion(unit: .adet, gramsEquivalent: 150, label: "3 Eggs (150 g)"),
            ]),
        FoodItem(name: "Egg White", category: .sut,
            caloriesPer100g: 52, proteinPer100g: 11.0, carbsPer100g: 0.7, fatPer100g: 0.2, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 33, label: "1 Egg White (33 g)"),
                Portion(unit: .ml, gramsEquivalent: 240, label: "1 Cup (240 ml)"),
            ]),
        FoodItem(name: "Whey Protein Powder", category: .sut,
            caloriesPer100g: 370, proteinPer100g: 75.0, carbsPer100g: 8.0, fatPer100g: 4.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 30, label: "1 Scoop (30 g)"),
            ]),
        FoodItem(name: "Protein Bar (Average)", category: .atistirmalik,
            caloriesPer100g: 380, proteinPer100g: 30.0, carbsPer100g: 40.0, fatPer100g: 10.0, fiberPer100g: 5.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 60, label: "1 Bar (60 g)"),
            ]),
    ]}

    // MARK: Carbs
    private static func internationalCarbs() -> [FoodItem] {[
        FoodItem(name: "Brown Rice (Cooked)", category: .tahil,
            caloriesPer100g: 123, proteinPer100g: 2.7, carbsPer100g: 26.0, fatPer100g: 1.0, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 185, label: "1 Cup (185 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "White Rice (Cooked)", category: .tahil,
            caloriesPer100g: 130, proteinPer100g: 2.7, carbsPer100g: 28.0, fatPer100g: 0.3, fiberPer100g: 0.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 186, label: "1 Cup (186 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Oatmeal (Cooked)", category: .tahil,
            caloriesPer100g: 71, proteinPer100g: 2.5, carbsPer100g: 12.0, fatPer100g: 1.5, fiberPer100g: 1.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 234, label: "1 Cup Cooked (234 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 40, label: "1 Serving Dry (40 g)"),
            ]),
        FoodItem(name: "Rolled Oats (Dry)", category: .tahil,
            caloriesPer100g: 379, proteinPer100g: 13.0, carbsPer100g: 68.0, fatPer100g: 7.0, fiberPer100g: 10.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 40, label: "1 Serving (40 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 80, label: "2 Servings (80 g)"),
            ]),
        FoodItem(name: "Sweet Potato (Baked)", category: .sebze,
            caloriesPer100g: 90, proteinPer100g: 2.0, carbsPer100g: 21.0, fatPer100g: 0.1, fiberPer100g: 3.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 130, label: "1 Medium (130 g)"),
                Portion(unit: .adet, gramsEquivalent: 180, label: "1 Large (180 g)"),
            ]),
        FoodItem(name: "Whole Wheat Bread", category: .tahil,
            caloriesPer100g: 247, proteinPer100g: 13.0, carbsPer100g: 41.0, fatPer100g: 4.2, fiberPer100g: 7.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 28, label: "1 Slice (28 g)"),
                Portion(unit: .dilim, gramsEquivalent: 56, label: "2 Slices (56 g)"),
            ]),
        FoodItem(name: "Quinoa (Cooked)", category: .tahil,
            caloriesPer100g: 120, proteinPer100g: 4.4, carbsPer100g: 21.0, fatPer100g: 1.9, fiberPer100g: 2.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 185, label: "1 Cup (185 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Pasta (Cooked)", category: .tahil,
            caloriesPer100g: 158, proteinPer100g: 5.8, carbsPer100g: 31.0, fatPer100g: 0.9, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 140, label: "1 Cup (140 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 200, label: "1 Large Portion (200 g)"),
            ]),
        FoodItem(name: "Bagel (Plain)", category: .tahil,
            caloriesPer100g: 271, proteinPer100g: 10.0, carbsPer100g: 53.0, fatPer100g: 1.7, fiberPer100g: 2.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 98, label: "1 Bagel (98 g)"),
            ]),
        FoodItem(name: "Tortilla (Flour, 8 inch)", category: .tahil,
            caloriesPer100g: 300, proteinPer100g: 7.8, carbsPer100g: 49.0, fatPer100g: 7.5, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 45, label: "1 Tortilla (45 g)"),
            ]),
    ]}

    // MARK: Dairy
    private static func internationalDairy() -> [FoodItem] {[
        FoodItem(name: "Greek Yogurt (Plain, 0%)", category: .sut,
            caloriesPer100g: 59, proteinPer100g: 10.0, carbsPer100g: 3.6, fatPer100g: 0.4, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 170, label: "1 Container (170 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 227, label: "1 Cup (227 g)"),
            ]),
        FoodItem(name: "Greek Yogurt (Plain, 2%)", category: .sut,
            caloriesPer100g: 73, proteinPer100g: 9.9, carbsPer100g: 3.9, fatPer100g: 1.9, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 170, label: "1 Container (170 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 227, label: "1 Cup (227 g)"),
            ]),
        FoodItem(name: "Cottage Cheese (Low Fat)", category: .sut,
            caloriesPer100g: 72, proteinPer100g: 12.0, carbsPer100g: 2.7, fatPer100g: 1.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 113, label: "½ Cup (113 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 226, label: "1 Cup (226 g)"),
            ]),
        FoodItem(name: "Cheddar Cheese", category: .sut,
            caloriesPer100g: 402, proteinPer100g: 25.0, carbsPer100g: 1.3, fatPer100g: 33.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 28, label: "1 Slice (28 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Mozzarella Cheese", category: .sut,
            caloriesPer100g: 280, proteinPer100g: 28.0, carbsPer100g: 2.2, fatPer100g: 17.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 oz (28 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 85, label: "3 oz (85 g)"),
            ]),
        FoodItem(name: "Whole Milk", category: .sut,
            caloriesPer100g: 61, proteinPer100g: 3.2, carbsPer100g: 4.8, fatPer100g: 3.3, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 240, label: "1 Cup (240 ml)"),
                Portion(unit: .ml, gramsEquivalent: 100, label: "100 ml"),
            ]),
        FoodItem(name: "Skim Milk (0%)", category: .sut,
            caloriesPer100g: 34, proteinPer100g: 3.4, carbsPer100g: 5.0, fatPer100g: 0.1, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 240, label: "1 Cup (240 ml)"),
            ]),
        FoodItem(name: "Almond Milk (Unsweetened)", category: .icecek,
            caloriesPer100g: 13, proteinPer100g: 0.4, carbsPer100g: 0.3, fatPer100g: 1.1, fiberPer100g: 0.3,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 240, label: "1 Cup (240 ml)"),
            ]),
        FoodItem(name: "Butter", category: .yagSos,
            caloriesPer100g: 717, proteinPer100g: 0.9, carbsPer100g: 0.1, fatPer100g: 81.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 14, label: "1 Tbsp (14 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 5, label: "1 Tsp (5 g)"),
            ]),
    ]}

    // MARK: Fruits
    private static func internationalFruits() -> [FoodItem] {[
        FoodItem(name: "Banana", category: .meyve,
            caloriesPer100g: 89, proteinPer100g: 1.1, carbsPer100g: 23.0, fatPer100g: 0.3, fiberPer100g: 2.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 118, label: "1 Medium Banana (118 g)"),
                Portion(unit: .adet, gramsEquivalent: 136, label: "1 Large Banana (136 g)"),
            ]),
        FoodItem(name: "Apple", category: .meyve,
            caloriesPer100g: 52, proteinPer100g: 0.3, carbsPer100g: 14.0, fatPer100g: 0.2, fiberPer100g: 2.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 182, label: "1 Medium Apple (182 g)"),
                Portion(unit: .adet, gramsEquivalent: 223, label: "1 Large Apple (223 g)"),
            ]),
        FoodItem(name: "Blueberries", category: .meyve,
            caloriesPer100g: 57, proteinPer100g: 0.7, carbsPer100g: 14.0, fatPer100g: 0.3, fiberPer100g: 2.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 148, label: "1 Cup (148 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Strawberries", category: .meyve,
            caloriesPer100g: 32, proteinPer100g: 0.7, carbsPer100g: 7.7, fatPer100g: 0.3, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 152, label: "1 Cup (152 g)"),
                Portion(unit: .adet, gramsEquivalent: 12, label: "1 Berry (12 g)"),
            ]),
        FoodItem(name: "Avocado", category: .meyve,
            caloriesPer100g: 160, proteinPer100g: 2.0, carbsPer100g: 9.0, fatPer100g: 15.0, fiberPer100g: 6.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 200, label: "1 Medium (200 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "½ Avocado (100 g)"),
            ]),
        FoodItem(name: "Orange", category: .meyve,
            caloriesPer100g: 47, proteinPer100g: 0.9, carbsPer100g: 12.0, fatPer100g: 0.1, fiberPer100g: 2.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 131, label: "1 Medium Orange (131 g)"),
            ]),
        FoodItem(name: "Mango", category: .meyve,
            caloriesPer100g: 60, proteinPer100g: 0.8, carbsPer100g: 15.0, fatPer100g: 0.4, fiberPer100g: 1.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 165, label: "1 Cup Sliced (165 g)"),
                Portion(unit: .adet, gramsEquivalent: 336, label: "1 Whole Mango (336 g)"),
            ]),
        FoodItem(name: "Grapes", category: .meyve,
            caloriesPer100g: 69, proteinPer100g: 0.7, carbsPer100g: 18.0, fatPer100g: 0.2, fiberPer100g: 0.9,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 92, label: "½ Cup (92 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Pineapple", category: .meyve,
            caloriesPer100g: 50, proteinPer100g: 0.5, carbsPer100g: 13.0, fatPer100g: 0.1, fiberPer100g: 1.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 165, label: "1 Cup Chunks (165 g)"),
            ]),
    ]}

    // MARK: Veggies
    private static func internationalVeggies() -> [FoodItem] {[
        FoodItem(name: "Broccoli (Raw)", category: .sebze,
            caloriesPer100g: 34, proteinPer100g: 2.8, carbsPer100g: 7.0, fatPer100g: 0.4, fiberPer100g: 2.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 91, label: "1 Cup Chopped (91 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Spinach (Raw)", category: .sebze,
            caloriesPer100g: 23, proteinPer100g: 2.9, carbsPer100g: 3.6, fatPer100g: 0.4, fiberPer100g: 2.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 30, label: "1 Cup Raw (30 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Baby Carrots", category: .sebze,
            caloriesPer100g: 35, proteinPer100g: 0.6, carbsPer100g: 8.2, fatPer100g: 0.1, fiberPer100g: 2.9,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 85, label: "About 10 Pieces (85 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Bell Pepper (Red)", category: .sebze,
            caloriesPer100g: 31, proteinPer100g: 1.0, carbsPer100g: 6.0, fatPer100g: 0.3, fiberPer100g: 2.1,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 119, label: "1 Medium Pepper (119 g)"),
            ]),
        FoodItem(name: "Kale (Raw)", category: .sebze,
            caloriesPer100g: 49, proteinPer100g: 4.3, carbsPer100g: 9.0, fatPer100g: 0.9, fiberPer100g: 3.6,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 67, label: "1 Cup Chopped (67 g)"),
            ]),
        FoodItem(name: "Cucumber", category: .sebze,
            caloriesPer100g: 15, proteinPer100g: 0.7, carbsPer100g: 3.6, fatPer100g: 0.1, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 301, label: "1 Whole Cucumber (301 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 119, label: "½ Cucumber (119 g)"),
            ]),
        FoodItem(name: "Cherry Tomatoes", category: .sebze,
            caloriesPer100g: 18, proteinPer100g: 0.9, carbsPer100g: 3.9, fatPer100g: 0.2, fiberPer100g: 1.2,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 149, label: "1 Cup (149 g)"),
                Portion(unit: .adet, gramsEquivalent: 17, label: "1 Cherry Tomato (17 g)"),
            ]),
        FoodItem(name: "Asparagus (Cooked)", category: .sebze,
            caloriesPer100g: 22, proteinPer100g: 2.4, carbsPer100g: 4.1, fatPer100g: 0.2, fiberPer100g: 2.1,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 18, label: "1 Spear (18 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 90, label: "5 Spears (90 g)"),
            ]),
    ]}

    // MARK: Fast Food (International)
    private static func internationalFastFood() -> [FoodItem] {[
        FoodItem(name: "Big Mac (McDonald's)", category: .hazirYemek,
            caloriesPer100g: 229, proteinPer100g: 11.5, carbsPer100g: 24.0, fatPer100g: 10.0, fiberPer100g: 1.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 214, label: "1 Big Mac (214 g)"),
            ]),
        FoodItem(name: "McChicken (McDonald's)", category: .hazirYemek,
            caloriesPer100g: 245, proteinPer100g: 12.0, carbsPer100g: 28.0, fatPer100g: 9.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 154, label: "1 McChicken (154 g)"),
            ]),
        FoodItem(name: "French Fries (McDonald's, Medium)", category: .hazirYemek,
            caloriesPer100g: 323, proteinPer100g: 3.8, carbsPer100g: 44.0, fatPer100g: 15.0, fiberPer100g: 3.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 117, label: "Medium Fries (117 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 154, label: "Large Fries (154 g)"),
            ]),
        FoodItem(name: "Whopper (Burger King)", category: .hazirYemek,
            caloriesPer100g: 234, proteinPer100g: 11.0, carbsPer100g: 22.0, fatPer100g: 11.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 291, label: "1 Whopper (291 g)"),
            ]),
        FoodItem(name: "KFC Original Chicken", category: .hazirYemek,
            caloriesPer100g: 257, proteinPer100g: 21.0, carbsPer100g: 9.0, fatPer100g: 15.5, fiberPer100g: 0.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 115, label: "1 Piece (115 g)"),
            ]),
        FoodItem(name: "Pepperoni Pizza (1 Slice)", category: .hazirYemek,
            caloriesPer100g: 298, proteinPer100g: 13.0, carbsPer100g: 29.0, fatPer100g: 13.5, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .dilim, gramsEquivalent: 107, label: "1 Slice (107 g)"),
            ]),
        FoodItem(name: "Burrito (Chicken)", category: .hazirYemek,
            caloriesPer100g: 163, proteinPer100g: 9.0, carbsPer100g: 21.0, fatPer100g: 4.5, fiberPer100g: 1.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 300, label: "1 Burrito (300 g)"),
            ]),
        FoodItem(name: "Hot Dog (with Bun)", category: .hazirYemek,
            caloriesPer100g: 262, proteinPer100g: 10.5, carbsPer100g: 22.0, fatPer100g: 15.0, fiberPer100g: 1.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 120, label: "1 Hot Dog (120 g)"),
            ]),
        FoodItem(name: "Caesar Salad (with Dressing)", category: .sebze,
            caloriesPer100g: 130, proteinPer100g: 5.5, carbsPer100g: 8.0, fatPer100g: 9.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 250, label: "1 Serving (250 g)"),
            ]),
        FoodItem(name: "Club Sandwich", category: .hazirYemek,
            caloriesPer100g: 230, proteinPer100g: 14.0, carbsPer100g: 22.0, fatPer100g: 9.0, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 280, label: "1 Sandwich (280 g)"),
            ]),
    ]}

    // MARK: Snacks
    private static func internationalSnacks() -> [FoodItem] {[
        FoodItem(name: "Almonds", category: .atistirmalik,
            caloriesPer100g: 579, proteinPer100g: 21.0, carbsPer100g: 22.0, fatPer100g: 50.0, fiberPer100g: 12.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 oz / ~23 Almonds (28 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Walnuts", category: .atistirmalik,
            caloriesPer100g: 654, proteinPer100g: 15.0, carbsPer100g: 14.0, fatPer100g: 65.0, fiberPer100g: 6.7,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 oz (28 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Peanut Butter (Natural)", category: .atistirmalik,
            caloriesPer100g: 598, proteinPer100g: 22.0, carbsPer100g: 22.0, fatPer100g: 51.0, fiberPer100g: 5.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 32, label: "2 Tbsp (32 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 16, label: "1 Tbsp (16 g)"),
            ]),
        FoodItem(name: "Cashews", category: .atistirmalik,
            caloriesPer100g: 553, proteinPer100g: 18.0, carbsPer100g: 33.0, fatPer100g: 44.0, fiberPer100g: 3.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 oz (28 g)"),
            ]),
        FoodItem(name: "Dark Chocolate (70-85%)", category: .tatli,
            caloriesPer100g: 598, proteinPer100g: 8.0, carbsPer100g: 46.0, fatPer100g: 43.0, fiberPer100g: 11.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "1 oz (28 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 10, label: "1 Square (10 g)"),
            ]),
        FoodItem(name: "Rice Cakes (Plain)", category: .atistirmalik,
            caloriesPer100g: 387, proteinPer100g: 7.5, carbsPer100g: 81.0, fatPer100g: 2.8, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 9, label: "1 Rice Cake (9 g)"),
            ]),
        FoodItem(name: "Hummus", category: .baklagil,
            caloriesPer100g: 177, proteinPer100g: 8.0, carbsPer100g: 20.0, fatPer100g: 8.6, fiberPer100g: 6.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 60, label: "¼ Cup (60 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "100 g"),
            ]),
        FoodItem(name: "Granola Bar", category: .atistirmalik,
            caloriesPer100g: 471, proteinPer100g: 7.5, carbsPer100g: 64.0, fatPer100g: 20.0, fiberPer100g: 4.4,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 47, label: "1 Bar (47 g)"),
            ]),
        FoodItem(name: "Potato Chips", category: .atistirmalik,
            caloriesPer100g: 536, proteinPer100g: 7.0, carbsPer100g: 53.0, fatPer100g: 35.0, fiberPer100g: 4.8,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 28, label: "Small Bag (28 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 50, label: "Medium Bag (50 g)"),
            ]),
    ]}

    // MARK: Breakfast
    private static func internationalBreakfast() -> [FoodItem] {[
        FoodItem(name: "Pancakes (Plain)", category: .kahvaltilik,
            caloriesPer100g: 227, proteinPer100g: 6.0, carbsPer100g: 37.0, fatPer100g: 6.5, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 77, label: "1 Medium Pancake (77 g)"),
                Portion(unit: .adet, gramsEquivalent: 231, label: "3 Pancakes (231 g)"),
            ]),
        FoodItem(name: "Waffle (Plain)", category: .kahvaltilik,
            caloriesPer100g: 291, proteinPer100g: 8.0, carbsPer100g: 36.0, fatPer100g: 13.0, fiberPer100g: 1.3,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 75, label: "1 Waffle (75 g)"),
            ]),
        FoodItem(name: "Scrambled Eggs", category: .kahvaltilik,
            caloriesPer100g: 170, proteinPer100g: 11.0, carbsPer100g: 1.6, fatPer100g: 13.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 100, label: "2 Eggs Scrambled (100 g)"),
                Portion(unit: .porsiyon, gramsEquivalent: 150, label: "3 Eggs Scrambled (150 g)"),
            ]),
        FoodItem(name: "Fried Egg", category: .kahvaltilik,
            caloriesPer100g: 196, proteinPer100g: 13.6, carbsPer100g: 0.8, fatPer100g: 15.0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .adet, gramsEquivalent: 46, label: "1 Large Fried Egg (46 g)"),
            ]),
        FoodItem(name: "Smoothie (Mixed Berry)", category: .icecek,
            caloriesPer100g: 55, proteinPer100g: 1.0, carbsPer100g: 13.0, fatPer100g: 0.3, fiberPer100g: 1.5,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 300, label: "1 Glass (300 ml)"),
                Portion(unit: .ml, gramsEquivalent: 450, label: "Large (450 ml)"),
            ]),
        FoodItem(name: "Granola (with Milk)", category: .kahvaltilik,
            caloriesPer100g: 159, proteinPer100g: 5.0, carbsPer100g: 27.0, fatPer100g: 4.0, fiberPer100g: 2.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 300, label: "1 Bowl with Milk (300 g)"),
            ]),
        FoodItem(name: "Acai Bowl", category: .kahvaltilik,
            caloriesPer100g: 95, proteinPer100g: 2.0, carbsPer100g: 18.0, fatPer100g: 2.5, fiberPer100g: 3.0,
            availablePortions: [
                Portion(unit: .gram, gramsEquivalent: 1, label: "1 g"),
                Portion(unit: .porsiyon, gramsEquivalent: 350, label: "1 Bowl (350 g)"),
            ]),
    ]}

    // MARK: Drinks
    private static func internationalDrinks() -> [FoodItem] {[
        FoodItem(name: "Black Coffee (Espresso)", category: .icecek,
            caloriesPer100g: 9, proteinPer100g: 0.1, carbsPer100g: 1.7, fatPer100g: 0.2, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 30, label: "1 Shot (30 ml)"),
                Portion(unit: .ml, gramsEquivalent: 240, label: "1 Mug (240 ml)"),
            ]),
        FoodItem(name: "Latte (Whole Milk)", category: .icecek,
            caloriesPer100g: 56, proteinPer100g: 2.8, carbsPer100g: 5.5, fatPer100g: 2.5, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 240, label: "Small (240 ml)"),
                Portion(unit: .ml, gramsEquivalent: 360, label: "Medium (360 ml)"),
            ]),
        FoodItem(name: "Orange Juice (Fresh)", category: .icecek,
            caloriesPer100g: 45, proteinPer100g: 0.7, carbsPer100g: 10.0, fatPer100g: 0.2, fiberPer100g: 0.2,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 240, label: "1 Glass (240 ml)"),
            ]),
        FoodItem(name: "Coca-Cola (Regular)", category: .icecek,
            caloriesPer100g: 42, proteinPer100g: 0, carbsPer100g: 10.6, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 330, label: "1 Can (330 ml)"),
                Portion(unit: .ml, gramsEquivalent: 500, label: "1 Bottle (500 ml)"),
            ]),
        FoodItem(name: "Diet Coke / Coke Zero", category: .icecek,
            caloriesPer100g: 0.5, proteinPer100g: 0.1, carbsPer100g: 0.1, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 330, label: "1 Can (330 ml)"),
                Portion(unit: .ml, gramsEquivalent: 500, label: "1 Bottle (500 ml)"),
            ]),
        FoodItem(name: "Protein Shake (Milk Based)", category: .icecek,
            caloriesPer100g: 75, proteinPer100g: 8.0, carbsPer100g: 7.0, fatPer100g: 1.5, fiberPer100g: 0.5,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 300, label: "1 Shake (300 ml)"),
                Portion(unit: .ml, gramsEquivalent: 500, label: "Large Shake (500 ml)"),
            ]),
        FoodItem(name: "Green Tea", category: .icecek,
            caloriesPer100g: 1, proteinPer100g: 0.2, carbsPer100g: 0.2, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 240, label: "1 Cup (240 ml)"),
            ]),
        FoodItem(name: "Energy Drink (Regular)", category: .icecek,
            caloriesPer100g: 45, proteinPer100g: 0.5, carbsPer100g: 11.0, fatPer100g: 0, fiberPer100g: 0,
            availablePortions: [
                Portion(unit: .ml, gramsEquivalent: 1, label: "1 ml"),
                Portion(unit: .ml, gramsEquivalent: 250, label: "1 Can (250 ml)"),
                Portion(unit: .ml, gramsEquivalent: 500, label: "Large Can (500 ml)"),
            ]),
    ]}
}
