import SwiftUI

// MARK: - Macro bar altındaki kompakt satır
struct StepStatRow: View {
    let steps: Int
    let stepGoal: Int
    let distanceKm: Double
    let caloriesBurned: Double

    private var progress: Double { min(Double(steps) / Double(max(stepGoal, 1)), 1.0) }

    var body: some View {
        HStack(spacing: 0) {
            stepCell
            Divider().frame(height: 40)
            calorieCell
            Divider().frame(height: 40)
            distanceCell
        }
        .padding(.vertical, 8)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var stepCell: some View {
        VStack(spacing: 4) {
            Text("Adım").font(.caption).foregroundStyle(.secondary)
            HStack(spacing: 2) {
                Image(systemName: "figure.walk").font(.caption2).foregroundStyle(.indigo)
                Text("\(steps)").font(.system(.subheadline, design: .rounded, weight: .semibold)).foregroundStyle(.indigo)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color(.systemGray5)).frame(height: 5)
                    Capsule()
                        .fill(progress >= 1 ? Color.green : Color.indigo)
                        .frame(width: geo.size.width * progress, height: 5)
                        .animation(.easeInOut(duration: 0.6), value: progress)
                }
            }
            .frame(height: 5)
            Text("/ \(stepGoal / 1000)K \(String(localized: "Adım"))").font(.caption2).foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
    }

    private var calorieCell: some View {
        VStack(spacing: 4) {
            Text("Yakılan" as LocalizedStringKey).font(.caption).foregroundStyle(.secondary)
            HStack(spacing: 2) {
                Image(systemName: "flame.fill").font(.caption2).foregroundStyle(.orange)
                Text("\(Int(caloriesBurned))").font(.system(.subheadline, design: .rounded, weight: .semibold)).foregroundStyle(.orange)
            }
            Spacer().frame(height: 5)
            Text("kcal").font(.caption2).foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
    }

    private var distanceCell: some View {
        VStack(spacing: 4) {
            Text("Mesafe" as LocalizedStringKey).font(.caption).foregroundStyle(.secondary)
            HStack(spacing: 2) {
                Image(systemName: "map.fill").font(.caption2).foregroundStyle(.blue)
                Text(String(format: "%.2f", distanceKm)).font(.system(.subheadline, design: .rounded, weight: .semibold)).foregroundStyle(.blue)
            }
            Spacer().frame(height: 5)
            Text("km").font(.caption2).foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Dashboard alt kartı
struct StepCounterView: View {
    @ObservedObject var service: StepCounterService
    let weightKg: Double

    var body: some View {
        VStack(spacing: 16) {
            // ── Başlık ──────────────────────────────────────
            HStack {
                Label("Adım Sayar", systemImage: "figure.walk")
                    .font(.headline)
                    .foregroundStyle(.indigo)
                Spacer()
                Text("\(service.stepGoal) \(String(localized: "hedef"))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if service.authorizationDenied {
                deniedView
            } else if !service.isAvailable {
                unavailableView
            } else {
                mainContent
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 4)
    }

    // MARK: - Ana içerik
    private var mainContent: some View {
        VStack(spacing: 14) {
            // ── Halka + adım sayısı ─────────────────────────
            HStack(spacing: 20) {
                ZStack {
                    Circle()
                        .stroke(Color.indigo.opacity(0.15), lineWidth: 10)
                        .frame(width: 90, height: 90)

                    Circle()
                        .trim(from: 0, to: service.progress)
                        .stroke(
                            service.progress >= 1
                                ? LinearGradient(colors: [.green, .mint], startPoint: .topLeading, endPoint: .bottomTrailing)
                                : LinearGradient(colors: [.indigo, .purple], startPoint: .topLeading, endPoint: .bottomTrailing),
                            style: StrokeStyle(lineWidth: 10, lineCap: .round)
                        )
                        .frame(width: 90, height: 90)
                        .rotationEffect(.degrees(-90))
                        .animation(.spring(response: 0.6), value: service.progress)

                    VStack(spacing: 0) {
                        Text("\(service.todaySteps)")
                            .font(.system(.title3, design: .rounded, weight: .bold))
                            .foregroundStyle(.indigo)
                            .minimumScaleFactor(0.6)
                        Text("adım" as LocalizedStringKey)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }

                // ── İstatistikler ───────────────────────────
                VStack(spacing: 10) {
                    statRow(
                        icon: "flame.fill",
                        color: .orange,
                        value: String(format: "%.0f kcal", service.caloriesBurned(weightKg: weightKg)),
                        label: "Yakılan"
                    )
                    statRow(
                        icon: "map.fill",
                        color: .blue,
                        value: String(format: "%.2f km", service.distanceKm),
                        label: "Mesafe"
                    )
                    statRow(
                        icon: "checkmark.circle.fill",
                        color: service.progress >= 1 ? .green : .secondary,
                        value: String(format: "%.0f%%", service.progress * 100),
                        label: "Tamamlanan"
                    )

                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }

            // ── İlerleme çubuğu ─────────────────────────────
            VStack(spacing: 4) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.indigo.opacity(0.12))
                            .frame(height: 10)
                        RoundedRectangle(cornerRadius: 6)
                            .fill(
                                service.progress >= 1
                                    ? LinearGradient(colors: [.green, .mint], startPoint: .leading, endPoint: .trailing)
                                    : LinearGradient(colors: [.indigo, .purple], startPoint: .leading, endPoint: .trailing)
                            )
                            .frame(width: geo.size.width * service.progress, height: 10)
                            .animation(.spring(response: 0.6), value: service.progress)
                    }
                }
                .frame(height: 10)

                HStack {
                    Text("0")
                    Spacer()
                    Text("\(service.stepGoal / 1000)K")
                }
                .font(.caption2)
                .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: - Yardımcı görünümler
    private func statRow(icon: String, color: Color, value: String, label: LocalizedStringKey) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
                .foregroundStyle(color)
                .frame(width: 16)
            Text(value)
                .font(.system(.subheadline, design: .rounded, weight: .semibold))
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var deniedView: some View {
        HStack(spacing: 12) {
            Image(systemName: "figure.walk.slash")
                .font(.title2)
                .foregroundStyle(.secondary)
            VStack(alignment: .leading, spacing: 2) {
                Text("Hareket İzni Kapalı")
                    .font(.subheadline.bold())
                Text("Adım takibi için Ayarlar > Caloriex Fit > Hareket bölümünden izin ver.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Button("Ayarlar") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .font(.caption.bold())
            .buttonStyle(.bordered)
        }
    }

    private var unavailableView: some View {
        HStack(spacing: 10) {
            Image(systemName: "iphone.slash")
                .foregroundStyle(.secondary)
            Text("Bu cihazda adım sayar desteklenmiyor.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }
}
