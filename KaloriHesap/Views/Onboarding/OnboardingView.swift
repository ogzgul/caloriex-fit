import SwiftUI
import SwiftData

struct OnboardingView: View {
    @Environment(\.modelContext) private var modelContext
    var onComplete: () -> Void

    @State private var name: String = ""
    @State private var age: Double = 25
    @State private var gender: Gender = .erkek
    @State private var height: Double = 170
    @State private var weight: Double = 70
    @State private var activity: ActivityLevel = .orta
    @State private var goal: WeightGoal = .koru
    @State private var step: Int = 0

    // Hesaplanan hedef (canlı önizleme)
    private var tempProfile: UserProfile {
        UserProfile(name: name, age: Int(age), gender: gender,
                    heightCm: height, weightKg: weight,
                    activityLevel: activity, weightGoal: goal)
    }

    var body: some View {
        NavigationStack {
            TabView(selection: $step) {
                // Adım 0 — Hoşgeldin
                WelcomeStep().tag(0)

                // Adım 1 — Kişisel Bilgi
                PersonalInfoStep(name: $name, age: $age, gender: $gender).tag(1)

                // Adım 2 — Vücut
                BodyStep(height: $height, weight: $weight).tag(2)

                // Adım 3 — Aktivite
                ActivityStep(activity: $activity).tag(3)

                // Adım 4 — Hedef
                GoalStep(goal: $goal, dailyCalories: tempProfile.dailyCalorieGoal).tag(4)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .animation(.easeInOut, value: step)
            .safeAreaInset(edge: .bottom) {
                bottomButtons
            }
        }
    }

    @ViewBuilder
    private var bottomButtons: some View {
        HStack(spacing: 16) {
            if step > 0 {
                Button("Geri") { withAnimation { step -= 1 } }
                    .buttonStyle(.bordered)
            }

            Button {
                if step < 4 {
                    withAnimation { step += 1 }
                } else {
                    saveProfile()
                }
            } label: {
                if step < 4 { Text("İleri") } else { Text("Başla") }
            }
            .buttonStyle(.borderedProminent)
            .tint(.orange)
            .frame(maxWidth: .infinity)
            .disabled(step == 1 && name.isEmpty)
        }
        .padding()
        .background(.ultraThinMaterial)
    }

    private func saveProfile() {
        let profile = UserProfile(
            name: name, age: Int(age), gender: gender,
            heightCm: height, weightKg: weight,
            activityLevel: activity, weightGoal: goal
        )
        profile.onboardingCompleted = true
        modelContext.insert(profile)
        try? modelContext.save()
        onComplete()
    }
}

// MARK: - Onboarding Adımları

private struct WelcomeStep: View {
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
            Image(systemName: "flame.fill")
                .font(.system(size: 80))
                .foregroundStyle(.orange)
            Text("Caloriex Fit'e\nHoşgeldiniz!")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
            Text("Günlük besin takibini kolaylaştırın,\nsağlıklı beslenme hedeflerinize ulaşın.")
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            Spacer()
        }
        .padding(32)
    }
}

private struct PersonalInfoStep: View {
    @Binding var name: String
    @Binding var age: Double
    @Binding var gender: Gender

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            StepHeader(icon: "person.fill", title: "Kişisel Bilgiler", color: .blue)

            TextField("Adınız", text: $name)
                .textFieldStyle(.roundedBorder)
                .font(.body)

            Picker("Cinsiyet", selection: $gender) {
                ForEach(Gender.allCases, id: \.self) { g in
                    Text(LocalizedStringKey(g.rawValue)).tag(g)
                }
            }
            .pickerStyle(.segmented)

            SliderRow(label: "Yaş", value: $age, range: 10...90, step: 1,
                      displayText: "\(Int(age)) \(String(localized: "yaş"))")

            Spacer()
        }
        .padding(32)
    }
}

private struct BodyStep: View {
    @Binding var height: Double
    @Binding var weight: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            StepHeader(icon: "figure.stand", title: "Vücut Ölçüleri", color: .green)

            SliderRow(label: "Boy", value: $height, range: 140...220, step: 1,
                      displayText: "\(Int(height)) cm")

            SliderRow(label: "Kilo", value: $weight, range: 30...200, step: 0.5,
                      displayText: String(format: "%.1f kg", weight))

            Spacer()
        }
        .padding(32)
    }
}

private struct ActivityStep: View {
    @Binding var activity: ActivityLevel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            StepHeader(icon: "figure.run", title: "Aktivite Seviyesi", color: .orange)

            ForEach(ActivityLevel.allCases, id: \.self) { level in
                Button {
                    activity = level
                } label: {
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(LocalizedStringKey(level.rawValue)).font(.subheadline.bold())
                            Text(LocalizedStringKey(level.description)).font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        if activity == level {
                            Image(systemName: "checkmark.circle.fill").foregroundStyle(.orange)
                        }
                    }
                    .padding()
                    .background(activity == level ? Color.orange.opacity(0.1) : Color(.systemGray6),
                                in: RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(activity == level ? Color.orange : Color.clear, lineWidth: 1.5)
                    )
                }
                .buttonStyle(.plain)
            }
            Spacer()
        }
        .padding(32)
    }
}

private struct GoalStep: View {
    @Binding var goal: WeightGoal
    let dailyCalories: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            StepHeader(icon: "target", title: "Hedefin Ne?", color: .red)

            ForEach(WeightGoal.allCases, id: \.self) { g in
                Button { goal = g } label: {
                    HStack {
                        Text(LocalizedStringKey(g.rawValue)).font(.subheadline.bold())
                        Spacer()
                        if goal == g {
                            Image(systemName: "checkmark.circle.fill").foregroundStyle(.orange)
                        }
                    }
                    .padding()
                    .background(goal == g ? Color.orange.opacity(0.1) : Color(.systemGray6),
                                in: RoundedRectangle(cornerRadius: 12))
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(goal == g ? Color.orange : Color.clear, lineWidth: 1.5)
                    )
                }
                .buttonStyle(.plain)
            }

            VStack(spacing: 4) {
                Text("Günlük Kalori Hedefiniz")
                    .font(.caption).foregroundStyle(.secondary)
                Text("\(Int(dailyCalories)) kcal")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundStyle(.orange)
                    .contentTransition(.numericText())
                    .animation(.easeInOut, value: dailyCalories)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.orange.opacity(0.08), in: RoundedRectangle(cornerRadius: 16))

            Spacer()
        }
        .padding(32)
    }
}

// MARK: - Ortak bileşenler

private struct StepHeader: View {
    let icon: String
    let title: LocalizedStringKey
    let color: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            Text(title)
                .font(.title2.bold())
        }
    }
}

private struct SliderRow: View {
    let label: LocalizedStringKey
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    let displayText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label).font(.subheadline.bold())
                Spacer()
                Text(displayText)
                    .font(.system(.subheadline, design: .rounded, weight: .semibold))
                    .foregroundStyle(.orange)
                    .contentTransition(.numericText())
                    .animation(.easeInOut(duration: 0.1), value: value)
            }
            Slider(value: $value, in: range, step: step)
                .tint(.orange)
        }
    }
}
