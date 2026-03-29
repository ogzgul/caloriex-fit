import SwiftUI
import SwiftData

// MARK: - Veri Modelleri

struct MonthSummary: Identifiable {
    let year: Int
    let month: Int
    let logs: [DailyLog]

    var id: String { "\(year)-\(month)" }

    var title: String {
        let fmt = DateFormatter()
        fmt.locale = Locale.current
        fmt.dateFormat = "MMMM yyyy"
        let comps = DateComponents(year: year, month: month, day: 1)
        let date = Calendar.current.date(from: comps) ?? Date()
        return fmt.string(from: date).capitalized
    }

    var loggedDays: Int { logs.filter { $0.totalCalories > 0 }.count }

    var avgCalories: Double {
        let active = logs.filter { $0.totalCalories > 0 }
        guard !active.isEmpty else { return 0 }
        return active.reduce(0) { $0 + $1.totalCalories } / Double(active.count)
    }
    var avgProtein: Double {
        let active = logs.filter { $0.totalCalories > 0 }
        guard !active.isEmpty else { return 0 }
        return active.reduce(0) { $0 + $1.totalProtein } / Double(active.count)
    }
    var avgCarbs: Double {
        let active = logs.filter { $0.totalCalories > 0 }
        guard !active.isEmpty else { return 0 }
        return active.reduce(0) { $0 + $1.totalCarbs } / Double(active.count)
    }
    var avgFat: Double {
        let active = logs.filter { $0.totalCalories > 0 }
        guard !active.isEmpty else { return 0 }
        return active.reduce(0) { $0 + $1.totalFat } / Double(active.count)
    }

    var maxCalories: Double { logs.map(\.totalCalories).max() ?? 0 }
    var minCalories: Double { logs.filter { $0.totalCalories > 0 }.map(\.totalCalories).min() ?? 0 }

    var weekGroups: [WeekSummary] {
        let cal = Calendar.current
        let grouped = Dictionary(grouping: logs.filter { $0.totalCalories > 0 }) { log -> Int in
            let day = cal.component(.day, from: log.date)
            return (day - 1) / 7 + 1
        }
        return grouped.map { WeekSummary(weekNumber: $0.key, logs: $0.value) }
                      .sorted { $0.weekNumber < $1.weekNumber }
    }
}

struct WeekSummary: Identifiable {
    let weekNumber: Int
    let logs: [DailyLog]
    var id: Int { weekNumber }
    var title: String { "\(weekNumber). \(String(localized: "Hafta"))" }
    var loggedDays: Int { logs.count }
    var avgCalories: Double {
        guard !logs.isEmpty else { return 0 }
        return logs.reduce(0) { $0 + $1.totalCalories } / Double(logs.count)
    }
}

// MARK: - Ana Ekran

struct SummaryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \DailyLog.date, order: .reverse) private var allLogs: [DailyLog]
    @State private var showResetAll = false

    private var monthGroups: [MonthSummary] {
        let cal = Calendar.current
        let grouped = Dictionary(grouping: allLogs) { log -> String in
            let c = cal.dateComponents([.year, .month], from: log.date)
            return "\(c.year!)-\(String(format: "%02d", c.month!))"
        }
        return grouped.map { key, logs in
            let parts = key.split(separator: "-")
            return MonthSummary(year: Int(parts[0])!, month: Int(parts[1])!, logs: logs)
        }
        .sorted { $0.id > $1.id }
    }

    var body: some View {
        NavigationStack {
            List {
                if monthGroups.isEmpty {
                    ContentUnavailableView(
                        "Henüz veri yok",
                        systemImage: "chart.bar",
                        description: Text("Yemek eklemeye başlayınca burada göreceksin.")
                    )
                    .listRowBackground(Color.clear)
                } else {
                    // Aylık kartlar
                    Section {
                        ForEach(monthGroups) { month in
                            NavigationLink {
                                MonthDetailView(summary: month) {
                                    deleteMonth(month)
                                }
                            } label: {
                                MonthCard(summary: month)
                            }
                        }
                    } header: {
                        Text("Aylık Özet").textCase(nil).font(.headline)
                    }
                }

                // Veri yönetimi
                Section {
                    Button(role: .destructive) {
                        showResetAll = true
                    } label: {
                        Label("Tüm Verileri Sıfırla", systemImage: "trash.fill")
                    }
                } header: {
                    Text("Veri Yönetimi").textCase(nil).font(.headline)
                } footer: {
                    Text("Tüm günlük kayıtlar ve yemek verileri kalıcı olarak silinir. Bu işlem geri alınamaz.")
                }
            }
            .navigationTitle("Özet")
            .confirmationDialog(
                "Tüm veriler silinecek. Emin misin?",
                isPresented: $showResetAll,
                titleVisibility: .visible
            ) {
                Button("Tümünü Sil", role: .destructive) { deleteAll() }
                Button("İptal", role: .cancel) {}
            }
        }
    }

    private func deleteAll() {
        for log in allLogs { modelContext.delete(log) }
        try? modelContext.save()
    }

    private func deleteMonth(_ month: MonthSummary) {
        for log in month.logs { modelContext.delete(log) }
        try? modelContext.save()
    }
}

// MARK: - Aylık Kart

private struct MonthCard: View {
    let summary: MonthSummary

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(summary.title).font(.headline)
                Spacer()
                Text("\(summary.loggedDays) \(String(localized: "gün kayıtlı"))")
                    .font(.caption).foregroundStyle(.secondary)
            }

            HStack(alignment: .bottom, spacing: 0) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Ort. Kalori")
                        .font(.caption2).foregroundStyle(.secondary)
                    Text("\(Int(summary.avgCalories))")
                        .font(.system(size: 28, weight: .bold, design: .rounded))
                        .foregroundStyle(.orange)
                    Text("kcal / gün")
                        .font(.caption2).foregroundStyle(.secondary)
                }
                Spacer()
                HStack(spacing: 10) {
                    MacroTag(label: "P", value: summary.avgProtein, color: .blue)
                    MacroTag(label: "K", value: summary.avgCarbs,   color: .orange)
                    MacroTag(label: "Y", value: summary.avgFat,     color: .yellow)
                }
            }
        }
        .padding(.vertical, 6)
    }
}

// MARK: - Ay Detay Ekranı

struct MonthDetailView: View {
    let summary: MonthSummary
    let onDelete: () -> Void

    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteConfirm = false

    var body: some View {
        List {

            // Genel istatistikler
            Section {
                HStack(spacing: 0) {
                    StatItem(title: "Ort.", value: "\(Int(summary.avgCalories))", unit: "kcal", color: .orange)
                    Divider().frame(height: 50)
                    StatItem(title: "En Yüksek", value: "\(Int(summary.maxCalories))", unit: "kcal", color: .red)
                    Divider().frame(height: 50)
                    StatItem(title: "En Düşük", value: "\(Int(summary.minCalories))", unit: "kcal", color: .green)
                }
                .padding(.vertical, 4)

                HStack(spacing: 0) {
                    StatItem(title: "Protein", value: String(format: "%.0f", summary.avgProtein), unit: "g", color: .blue)
                    Divider().frame(height: 50)
                    StatItem(title: "Karb", value: String(format: "%.0f", summary.avgCarbs), unit: "g", color: .orange)
                    Divider().frame(height: 50)
                    StatItem(title: "Yağ", value: String(format: "%.0f", summary.avgFat), unit: "g", color: .yellow)
                }
                .padding(.vertical, 4)
            } header: {
                Text("Genel Bakış").textCase(nil)
            }

            // Haftalık dağılım
            if !summary.weekGroups.isEmpty {
                Section {
                    ForEach(summary.weekGroups) { week in
                        WeekRow(week: week, maxCalories: summary.maxCalories)
                    }
                } header: {
                    Text("Haftalık Dağılım").textCase(nil)
                }
            }

            // Günlük kayıtlar
            Section {
                ForEach(summary.logs.filter { $0.totalCalories > 0 }
                                    .sorted { $0.date > $1.date }) { log in
                    DayRow(log: log)
                }
            } header: {
                Text("Günlük Kayıtlar").textCase(nil)
            }

            // Sil
            Section {
                Button(role: .destructive) {
                    showDeleteConfirm = true
                } label: {
                    Label("Bu Ayın Verilerini Sil", systemImage: "trash")
                }
            } header: {
                Text("Veri Yönetimi").textCase(nil)
            } footer: {
                Text("\(summary.title): \(String(localized: "Tüm kayıtlar silinecek. Emin misin?"))")
            }
        }
        .navigationTitle(summary.title)
        .navigationBarTitleDisplayMode(.inline)
        .confirmationDialog(
            "\(summary.title): \(String(localized: "Tüm veriler silinecek. Emin misin?"))",
            isPresented: $showDeleteConfirm,
            titleVisibility: .visible
        ) {
            Button("Sil", role: .destructive) {
                onDelete()
                dismiss()
            }
            Button("İptal", role: .cancel) {}
        }
    }
}

// MARK: - Alt Bileşenler

private struct WeekRow: View {
    let week: WeekSummary
    let maxCalories: Double

    private var progress: Double {
        guard maxCalories > 0 else { return 0 }
        return min(week.avgCalories / maxCalories, 1.0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(week.title).font(.subheadline.bold())
                Spacer()
                Text("\(week.loggedDays) \(String(localized: "gün"))  ·  \(String(localized: "ort.")) \(Int(week.avgCalories)) kcal")
                    .font(.caption).foregroundStyle(.secondary)
            }
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color(.systemGray5)).frame(height: 7)
                    Capsule()
                        .fill(LinearGradient(colors: [.orange, .red],
                                             startPoint: .leading, endPoint: .trailing))
                        .frame(width: geo.size.width * progress, height: 7)
                }
            }
            .frame(height: 7)
        }
        .padding(.vertical, 4)
    }
}

private struct DayRow: View {
    let log: DailyLog

    private var dayLabel: String {
        let fmt = DateFormatter()
        fmt.locale = Locale.current
        fmt.dateFormat = "d MMMM, EEEE"
        return fmt.string(from: log.date)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(dayLabel).font(.subheadline)
                Text("\(log.entries.count) \(String(localized: "yemek"))")
                    .font(.caption).foregroundStyle(.secondary)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(Int(log.totalCalories))")
                    .font(.subheadline.bold()).foregroundStyle(.orange)
                Text("kcal").font(.caption2).foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 2)
    }
}

private struct StatItem: View {
    let title: LocalizedStringKey
    let value: String
    let unit: String
    let color: Color

    var body: some View {
        VStack(spacing: 3) {
            Text(title).font(.caption2).foregroundStyle(.secondary)
            Text(value)
                .font(.system(.title3, design: .rounded, weight: .bold))
                .foregroundStyle(color)
            Text(unit).font(.caption2).foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

private struct MacroTag: View {
    let label: LocalizedStringKey
    let value: Double
    let color: Color

    var body: some View {
        VStack(spacing: 2) {
            Text(label).font(.caption2).foregroundStyle(.secondary)
            Text("\(Int(value))g")
                .font(.system(.caption, design: .rounded, weight: .semibold))
                .foregroundStyle(color)
        }
        .padding(.horizontal, 8).padding(.vertical, 4)
        .background(color.opacity(0.12), in: RoundedRectangle(cornerRadius: 8))
    }
}
