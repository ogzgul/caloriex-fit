import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query private var profiles: [UserProfile]
    @Query private var allLogs: [DailyLog]
    @Environment(\.modelContext) private var modelContext
    @State private var showEdit = false
    @State private var showResetConfirm = false

    private var profile: UserProfile? { profiles.first }

    var body: some View {
        NavigationStack {
            if let p = profile {
                Form {
                    // ─── Kişisel özet ────────────────────────────────
                    Section {
                        HStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.orange.opacity(0.15))
                                    .frame(width: 64, height: 64)
                                Text(p.name.isEmpty ? "?" : String(p.name.prefix(1)).uppercased())
                                    .font(.system(size: 28, weight: .bold, design: .rounded))
                                    .foregroundStyle(.orange)
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(p.name.isEmpty ? String(localized: "İsimsiz") : p.name)
                                    .font(.title3.bold())
                                Text("\(p.age) \(String(localized: "yaş")) · \(NSLocalizedString(p.gender.rawValue, comment: ""))")
                                    .font(.subheadline).foregroundStyle(.secondary)
                                Text("\(Int(p.heightCm)) cm · \(String(format: "%.1f", p.weightKg)) kg")
                                    .font(.subheadline).foregroundStyle(.secondary)
                            }
                            Spacer()
                            Button {
                                showEdit = true
                            } label: {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.title2)
                                    .foregroundStyle(.orange)
                            }
                        }
                        .padding(.vertical, 4)
                    }

                    // ─── Günlük hedefler ─────────────────────────────
                    Section("Günlük Hedefler") {
                        GoalRow(icon: "flame.fill",   color: .orange, label: "Kalori",  value: "\(Int(p.dailyCalorieGoal)) kcal")
                        GoalRow(icon: "fish.fill",    color: .blue,   label: "Protein", value: "\(Int(p.proteinGoalG)) g")
                        GoalRow(icon: "leaf.fill",    color: .green,  label: "Karb",    value: "\(Int(p.carbsGoalG)) g")
                        GoalRow(icon: "drop.fill",    color: .yellow, label: "Yağ",     value: "\(Int(p.fatGoalG)) g")
                    }

                    // ─── Hesaplama detayı ────────────────────────────
                    Section("Metabolizma") {
                        LabeledContent("BMR (Bazal)", value: "\(Int(p.bmr)) kcal")
                        LabeledContent("Aktivite") { Text(LocalizedStringKey(p.activityLevel.rawValue)) }
                        LabeledContent("Hedef") { Text(LocalizedStringKey(p.weightGoal.rawValue)) }
                    }

                    // ─── Bildirimler & Program ───────────────────────
                    Section("Bildirimler & Program") {
                        NavigationLink {
                            MealScheduleSettingsView()
                        } label: {
                            Label {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Öğün Programı & Hatırlatmalar")
                                    let ms = MealScheduleSettings.load()
                                    let activeReminders = ms.entries.filter { $0.reminderEnabled }.count
                                    Text(activeReminders > 0
                                         ? "\(ms.mealCount) \(String(localized: "öğün")) · \(activeReminders) \(String(localized: "hatırlatma açık"))"
                                         : "\(ms.mealCount) \(String(localized: "öğün")) · \(String(localized: "Hatırlatma kapalı"))")
                                        .font(.caption).foregroundStyle(.secondary)
                                }
                            } icon: {
                                Image(systemName: "fork.knife.circle.fill")
                                    .foregroundStyle(.orange)
                                    .font(.title3)
                            }
                        }

                        NavigationLink {
                            WaterReminderSettingsView()
                        } label: {
                            Label {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Su Hatırlatması")
                                    Text(WaterReminderSettings.load().isEnabled ? "Açık" : "Kapalı" as LocalizedStringKey)
                                        .font(.caption).foregroundStyle(.secondary)
                                }
                            } icon: {
                                Image(systemName: "drop.circle.fill")
                                    .foregroundStyle(.blue)
                                    .font(.title3)
                            }
                        }
                    }

                    // ─── Tehlike bölgesi ─────────────────────────────
                    Section {
                        Button("Uygulamayı Sıfırla", role: .destructive) {
                            showResetConfirm = true
                        }
                    } footer: {
                        Text("Profil, tüm günlük kayıtlar ve yemek verileri kalıcı olarak silinir.")
                    }
                }
                .confirmationDialog(
                    "Her şey silinecek. Emin misin?",
                    isPresented: $showResetConfirm,
                    titleVisibility: .visible
                ) {
                    Button("Tümünü Sil ve Sıfırla", role: .destructive) {
                        for log in allLogs { modelContext.delete(log) }
                        modelContext.delete(p)
                        try? modelContext.save()
                    }
                    Button("İptal", role: .cancel) {}
                }
                .navigationTitle("Profil")
                .sheet(isPresented: $showEdit) {
                    ProfileEditView(profile: p)
                }
            } else {
                ContentUnavailableView("Profil Bulunamadı", systemImage: "person.slash")
                    .navigationTitle("Profil")
            }
        }
    }
}

// MARK: - Hedef satırı

private struct GoalRow: View {
    let icon: String
    let color: Color
    let label: LocalizedStringKey
    let value: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundStyle(color)
                .frame(width: 24)
            Text(label)
            Spacer()
            Text(value)
                .foregroundStyle(.secondary)
                .bold()
        }
    }
}

// MARK: - Profil Düzenleme

struct ProfileEditView: View {
    @Environment(\.dismiss) private var dismiss
    let profile: UserProfile

    @State private var name: String
    @State private var age: Double
    @State private var gender: Gender
    @State private var height: Double
    @State private var weight: Double
    @State private var activity: ActivityLevel
    @State private var goal: WeightGoal

    init(profile: UserProfile) {
        self.profile = profile
        _name     = State(initialValue: profile.name)
        _age      = State(initialValue: Double(profile.age))
        _gender   = State(initialValue: profile.gender)
        _height   = State(initialValue: profile.heightCm)
        _weight   = State(initialValue: profile.weightKg)
        _activity = State(initialValue: profile.activityLevel)
        _goal     = State(initialValue: profile.weightGoal)
    }

    // Canlı önizleme kalorisi
    private var previewCalories: Double {
        let bmr: Double
        switch gender {
        case .erkek:
            bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age)
        case .kadin:
            bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age)
        }
        return (bmr * activity.multiplier) + goal.calorieAdjustment
    }

    var body: some View {
        NavigationStack {
            Form {
                // ─── Kişisel Bilgiler ────────────────────────
                Section("Kişisel Bilgiler") {
                    HStack {
                        Label("Ad", systemImage: "person")
                        Spacer()
                        TextField("Adınız", text: $name)
                            .multilineTextAlignment(.trailing)
                    }

                    Picker(selection: $gender) {
                        ForEach(Gender.allCases, id: \.self) {
                            Text(LocalizedStringKey($0.rawValue)).tag($0)
                        }
                    } label: {
                        Label("Cinsiyet", systemImage: "person.2")
                    }

                    SliderFormRow(
                        icon: "birthday.cake", label: "Yaş",
                        value: $age, range: 10...90, step: 1,
                        displayText: "\(Int(age)) \(String(localized: "yaş"))"
                    )
                }

                // ─── Vücut Ölçüleri ──────────────────────────
                Section("Vücut Ölçüleri") {
                    SliderFormRow(
                        icon: "ruler", label: "Boy",
                        value: $height, range: 140...220, step: 1,
                        displayText: "\(Int(height)) cm"
                    )
                    SliderFormRow(
                        icon: "scalemass", label: "Kilo",
                        value: $weight, range: 30...200, step: 0.5,
                        displayText: String(format: "%.1f kg", weight)
                    )
                }

                // ─── Aktivite ────────────────────────────────
                Section("Aktivite Seviyesi") {
                    ForEach(ActivityLevel.allCases, id: \.self) { level in
                        Button { activity = level } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(LocalizedStringKey(level.rawValue))
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                    Text(LocalizedStringKey(level.description))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                if activity == level {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.orange)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }

                // ─── Hedef ───────────────────────────────────
                Section("Hedef") {
                    Picker(selection: $goal) {
                        ForEach(WeightGoal.allCases, id: \.self) {
                            Text(LocalizedStringKey($0.rawValue)).tag($0)
                        }
                    } label: {
                        Label("Hedef", systemImage: "target")
                    }
                    .pickerStyle(.segmented)
                }

                // ─── Canlı kalori özeti ──────────────────────
                Section {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Yeni Günlük Kalori Hedefi")
                                .font(.caption).foregroundStyle(.secondary)
                            Text("\(Int(previewCalories)) kcal")
                                .font(.system(.title2, design: .rounded, weight: .bold))
                                .foregroundStyle(.orange)
                                .contentTransition(.numericText())
                                .animation(.easeInOut(duration: 0.2), value: previewCalories)
                        }
                        Spacer()
                        Image(systemName: "flame.fill")
                            .font(.title)
                            .foregroundStyle(.orange.opacity(0.3))
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("Profili Düzenle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        profile.name             = name
                        profile.age              = Int(age)
                        profile.genderRaw        = gender.rawValue
                        profile.heightCm         = height
                        profile.weightKg         = weight
                        profile.activityLevelRaw = activity.rawValue
                        profile.weightGoalRaw    = goal.rawValue
                        dismiss()
                    }
                    .bold()
                }
            }
        }
    }
}

// MARK: - Slider Form Satırı

private struct SliderFormRow: View {
    let icon: String
    let label: LocalizedStringKey
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let displayText: String

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Label(label, systemImage: icon)
                Spacer()
                Text(displayText)
                    .foregroundStyle(.orange)
                    .bold()
                    .contentTransition(.numericText())
                    .animation(.easeInOut(duration: 0.1), value: value)
            }
            Slider(value: $value, in: range, step: step)
                .tint(.orange)
        }
        .padding(.vertical, 2)
    }
}
