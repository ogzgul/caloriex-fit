import Foundation
import UserNotifications

enum MealReminderService {

    static func schedule(settings: MealScheduleSettings) {
        cancelAll()
        let center = UNUserNotificationCenter.current()

        for entry in settings.entries where entry.reminderEnabled {
            let content = UNMutableNotificationContent()
            content.title = "\(entry.displayName) Zamanı!"
            content.body = message(for: entry.id)
            content.sound = .default

            var components = DateComponents()
            components.hour = entry.hour
            components.minute = entry.minute

            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(
                identifier: "meal_\(entry.id)",
                content: content,
                trigger: trigger
            )
            center.add(request)
        }
    }

    static func cancelAll() {
        let ids = ["kahvalti","ogle","aksam","araogun1","araogun2"].map { "meal_\($0)" }
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
    }

    private static func message(for id: String) -> String {
        switch id {
        case "kahvalti":  return "Güne sağlıklı bir kahvaltıyla başla! ☀️"
        case "ogle":      return "Öğle yemeği vakti! Dengeli bir öğün seni bekliyor."
        case "aksam":     return "Akşam yemeğini unutma, bugünkü hedeflerin nerede? 🌙"
        default:          return "Ara öğün zamanı! Sağlıklı bir şeyler atıştır. 🥜"
        }
    }
}

