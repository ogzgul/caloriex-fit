import Foundation

/// Kullanıcı 3 farklı günde yemek kaydettikten sonra 1 kez puan isteği tetikler.
struct ReviewManager {

    private static let loggedDaysKey   = "reviewManager.loggedDays"
    private static let hasRequestedKey = "reviewManager.hasRequested"
    private static let requiredDays    = 3

    /// Yemek eklendiğinde çağır. `true` dönerse `requestReview()` tetikle.
    static func recordEntryAdded(on date: Date) -> Bool {
        guard !UserDefaults.standard.bool(forKey: hasRequestedKey) else { return false }

        let key = dayKey(for: date)
        var days = loggedDays()

        days.insert(key)
        save(days: days)

        return days.count >= requiredDays
    }

    static func markReviewRequested() {
        UserDefaults.standard.set(true, forKey: hasRequestedKey)
    }

    // MARK: - Private

    private static func dayKey(for date: Date) -> String {
        let fmt = DateFormatter()
        fmt.dateFormat = "yyyy-MM-dd"
        return fmt.string(from: date)
    }

    private static func loggedDays() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: loggedDaysKey) ?? []
        return Set(array)
    }

    private static func save(days: Set<String>) {
        UserDefaults.standard.set(Array(days), forKey: loggedDaysKey)
    }
}
