import Foundation

// MARK: - Tek öğün kaydı
struct MealScheduleEntry: Codable, Identifiable {
    var id: String           // unique key (kahvalti, ogle, aksam, araogun1, araogun2)
    var displayName: String
    var sfIcon: String
    var hour: Int
    var minute: Int
    var reminderEnabled: Bool

    var timeLabel: String { String(format: "%02d:%02d", hour, minute) }

    var timeDate: Date {
        var c = DateComponents()
        c.hour = hour; c.minute = minute
        return Calendar.current.date(from: c) ?? Date()
    }
}

// MARK: - 2 öğün kombinasyonu
enum TwoMealCombo: String, CaseIterable, Codable {
    case sabahOgle   = "Sabah + Öğle"
    case sabahAksam  = "Sabah + Akşam"
    case ogleAksam   = "Öğle + Akşam"
}

// MARK: - Tüm ayar
struct MealScheduleSettings: Codable {
    var mealCount: Int = 3              // 2–5
    var twoMealCombo: TwoMealCombo = .sabahAksam
    var entries: [MealScheduleEntry] = []

    static let key = "mealScheduleSettings_v2"

    // MARK: - Yükle & kaydet
    static func load() -> MealScheduleSettings {
        if let data = UserDefaults.standard.data(forKey: key),
           let s = try? JSONDecoder().decode(MealScheduleSettings.self, from: data) {
            return s
        }
        var s = MealScheduleSettings()
        s.rebuildEntries()
        return s
    }

    func save() {
        guard let data = try? JSONEncoder().encode(self) else { return }
        UserDefaults.standard.set(data, forKey: MealScheduleSettings.key)
    }

    // MARK: - Öğün listesini yeniden oluştur (önceki saatleri koru)
    mutating func rebuildEntries() {
        let old = Dictionary(uniqueKeysWithValues: entries.map { ($0.id, $0) })

        func entry(_ id: String, _ name: String, _ icon: String, _ h: Int, _ m: Int) -> MealScheduleEntry {
            old[id] ?? MealScheduleEntry(id: id, displayName: name, sfIcon: icon,
                                         hour: h, minute: m, reminderEnabled: false)
        }

        switch mealCount {
        case 2:
            switch twoMealCombo {
            case .sabahOgle:
                entries = [entry("kahvalti", "Kahvaltı", "sunrise.fill", 8, 0),
                           entry("ogle",     "Öğle Yemeği", "sun.max.fill", 12, 30)]
            case .sabahAksam:
                entries = [entry("kahvalti", "Kahvaltı", "sunrise.fill", 8, 0),
                           entry("aksam",    "Akşam Yemeği", "moon.fill", 19, 0)]
            case .ogleAksam:
                entries = [entry("ogle",  "Öğle Yemeği", "sun.max.fill", 12, 30),
                           entry("aksam", "Akşam Yemeği", "moon.fill", 19, 0)]
            }

        case 3:
            entries = [entry("kahvalti", "Kahvaltı",     "sunrise.fill",  8,  0),
                       entry("ogle",     "Öğle Yemeği",  "sun.max.fill", 12, 30),
                       entry("aksam",    "Akşam Yemeği", "moon.fill",    19,  0)]

        case 4:
            entries = [entry("kahvalti", "Kahvaltı",         "sunrise.fill",    8,  0),
                       entry("ogle",     "Öğle Yemeği",      "sun.max.fill",   12, 30),
                       entry("araogun1", "Ara Öğün",         "leaf.fill",      15, 30),
                       entry("aksam",    "Akşam Yemeği",     "moon.fill",      19,  0)]

        case 5:
            entries = [entry("kahvalti", "Kahvaltı",         "sunrise.fill",    8,  0),
                       entry("araogun1", "Sabah Ara Öğünü",  "leaf.fill",      10, 30),
                       entry("ogle",     "Öğle Yemeği",      "sun.max.fill",   12, 30),
                       entry("araogun2", "Öğleden Sonra",    "leaf.fill",      15, 30),
                       entry("aksam",    "Akşam Yemeği",     "moon.fill",      19,  0)]

        default:
            entries = [entry("kahvalti", "Kahvaltı",     "sunrise.fill",  8,  0),
                       entry("ogle",     "Öğle Yemeği",  "sun.max.fill", 12, 30),
                       entry("aksam",    "Akşam Yemeği", "moon.fill",    19,  0)]
        }
    }
}
