import Foundation
import UserNotifications

// MARK: - Hatırlatma modu
enum WaterReminderMode: String, CaseIterable, Codable {
    case saatBasi  = "Saat Başı"
    case belirliSaat = "Günde 1 Kez"

    var description: String {
        switch self {
        case .saatBasi:    return "Seçtiğin saatler arasında her saat hatırlatır"
        case .belirliSaat: return "Belirlediğin saatte bir kez hatırlatır"
        }
    }

    var icon: String {
        switch self {
        case .saatBasi:    return "clock.arrow.2.circlepath"
        case .belirliSaat: return "clock.fill"
        }
    }
}

// MARK: - Ayarlar (UserDefaults)
struct WaterReminderSettings: Codable {
    var isEnabled: Bool = false
    var mode: WaterReminderMode = .saatBasi
    var startHour: Int = 8     // saat başı mod: başlangıç (08:00)
    var endHour: Int = 22      // saat başı mod: bitiş (22:00)
    var onceHour: Int = 9      // günde 1 kez saati
    var onceMinute: Int = 0

    static let key = "waterReminderSettings"

    static func load() -> WaterReminderSettings {
        guard let data = UserDefaults.standard.data(forKey: key),
              let settings = try? JSONDecoder().decode(WaterReminderSettings.self, from: data) else {
            return WaterReminderSettings()
        }
        return settings
    }

    func save() {
        guard let data = try? JSONEncoder().encode(self) else { return }
        UserDefaults.standard.set(data, forKey: WaterReminderSettings.key)
    }
}

// MARK: - Bildirim Servisi
enum WaterReminderService {

    static let categoryID = "WATER_REMINDER"

    /// Bildirim izni iste
    static func requestPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                DispatchQueue.main.async { completion(granted) }
            }
    }

    /// Mevcut izin durumunu sorgula
    static func checkPermission(completion: @escaping @Sendable (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            let status = settings.authorizationStatus
            DispatchQueue.main.async { completion(status) }
        }
    }

    /// Ayarlara göre bildirimleri yeniden planla
    static func schedule(settings: WaterReminderSettings) {
        cancelAll()
        guard settings.isEnabled else { return }

        switch settings.mode {
        case .saatBasi:
            scheduleHourly(start: settings.startHour, end: settings.endHour)
        case .belirliSaat:
            scheduleOnce(hour: settings.onceHour, minute: settings.onceMinute)
        }
    }

    /// Tüm su hatırlatmalarını iptal et
    static func cancelAll() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: identifiers())
    }

    // MARK: - Private

    private static func scheduleHourly(start: Int, end: Int) {
        let center = UNUserNotificationCenter.current()
        let hours = (start...min(end, 23)).filter { $0 <= end }

        for hour in hours {
            let content = UNMutableNotificationContent()
            content.title = "💧 Su İçme Zamanı!"
            content.body = randomMessage()
            content.sound = .default
            content.categoryIdentifier = categoryID

            var components = DateComponents()
            components.hour = hour
            components.minute = 0

            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: true
            )
            let request = UNNotificationRequest(
                identifier: "water_hourly_\(hour)",
                content: content,
                trigger: trigger
            )
            center.add(request)
        }
    }

    private static func scheduleOnce(hour: Int, minute: Int) {
        let content = UNMutableNotificationContent()
        content.title = "💧 Günlük Su Hatırlatması"
        content.body = randomMessage()
        content.sound = .default
        content.categoryIdentifier = categoryID

        var components = DateComponents()
        components.hour = hour
        components.minute = minute

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: components,
            repeats: true
        )
        let request = UNNotificationRequest(
            identifier: "water_once",
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    private static func identifiers() -> [String] {
        var ids = ["water_once"]
        ids += (0...23).map { "water_hourly_\($0)" }
        return ids
    }

    private static func randomMessage() -> String {
        let messages = [
            "Biraz su iç, kendine iyi bak! 🥤",
            "Günlük su hedefine ne kadar ulaştın?",
            "Vücudun su istiyor! Bir bardak iç.",
            "Sağlıklı kalmak için düzenli su iç.",
            "Su içme vakti geldi! 💦"
        ]
        return messages.randomElement() ?? messages[0]
    }
}
