import Foundation
import SwiftData

enum Gender: String, CaseIterable, Codable {
    case erkek = "Erkek"
    case kadin = "Kadın"
}

enum ActivityLevel: String, CaseIterable, Codable {
    case sedanter    = "Hareketsiz"
    case hafif       = "Hafif Aktif"
    case orta        = "Orta Aktif"
    case aktif       = "Aktif"
    case cokAktif    = "Çok Aktif"

    var multiplier: Double {
        switch self {
        case .sedanter:  return 1.2
        case .hafif:     return 1.375
        case .orta:      return 1.55
        case .aktif:     return 1.725
        case .cokAktif:  return 1.9
        }
    }

    var description: String {
        switch self {
        case .sedanter:  return "Masa başı iş, spor yok"
        case .hafif:     return "Haftada 1–3 gün hafif egzersiz"
        case .orta:      return "Haftada 3–5 gün orta egzersiz"
        case .aktif:     return "Haftada 6–7 gün yoğun egzersiz"
        case .cokAktif:  return "Günde 2x antrenman veya ağır iş"
        }
    }
}

enum WeightGoal: String, CaseIterable, Codable {
    case kilo_ver    = "Kilo Ver"
    case koru        = "Kiloyu Koru"
    case kilo_al     = "Kilo Al"

    var calorieAdjustment: Double {
        switch self {
        case .kilo_ver: return -500
        case .koru:     return 0
        case .kilo_al:  return +300
        }
    }
}

@Model
final class UserProfile {
    var name: String
    var age: Int
    var genderRaw: String
    var heightCm: Double
    var weightKg: Double
    var activityLevelRaw: String
    var weightGoalRaw: String
    var onboardingCompleted: Bool

    init(name: String = "", age: Int = 25, gender: Gender = .erkek,
         heightCm: Double = 170, weightKg: Double = 70,
         activityLevel: ActivityLevel = .orta, weightGoal: WeightGoal = .koru) {
        self.name = name
        self.age = age
        self.genderRaw = gender.rawValue
        self.heightCm = heightCm
        self.weightKg = weightKg
        self.activityLevelRaw = activityLevel.rawValue
        self.weightGoalRaw = weightGoal.rawValue
        self.onboardingCompleted = false
    }

    var gender: Gender { Gender(rawValue: genderRaw) ?? .erkek }
    var activityLevel: ActivityLevel { ActivityLevel(rawValue: activityLevelRaw) ?? .orta }
    var weightGoal: WeightGoal { WeightGoal(rawValue: weightGoalRaw) ?? .koru }

    // MARK: - Harris-Benedict BMR
    var bmr: Double {
        switch gender {
        case .erkek:
            return 88.362 + (13.397 * weightKg) + (4.799 * heightCm) - (5.677 * Double(age))
        case .kadin:
            return 447.593 + (9.247 * weightKg) + (3.098 * heightCm) - (4.330 * Double(age))
        }
    }

    var dailyCalorieGoal: Double {
        (bmr * activityLevel.multiplier) + weightGoal.calorieAdjustment
    }

    var proteinGoalG: Double   { weightKg * 1.6 }
    var fatGoalG: Double       { dailyCalorieGoal * 0.25 / 9 }
    var carbsGoalG: Double     { (dailyCalorieGoal - (proteinGoalG * 4) - (fatGoalG * 9)) / 4 }
}
