import SwiftUI
import SwiftData

@main
struct KaloriHesapApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [
            UserProfile.self,
            DailyLog.self,
            FoodEntry.self
        ])
    }
}
