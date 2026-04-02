import SwiftUI
import UserNotifications

struct MealScheduleSettingsView: View {
    @State private var settings = MealScheduleSettings.load()
    @State private var permissionStatus: UNAuthorizationStatus = .notDetermined
    @State private var expandedEntryID: String? = nil   // hangi satırın saati açık

    var body: some View {
        Form {

            // ─── Bildirim izni uyarısı ───────────────────────
            if permissionStatus == .denied {
                Section {
                    HStack(spacing: 10) {
                        Image(systemName: "bell.slash.fill").foregroundStyle(.red)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Bildirim İzni Kapalı").font(.subheadline.bold())
                            Text("Hatırlatma açmak için Ayarlar'dan izin ver.")
                                .font(.caption).foregroundStyle(.secondary)
                        }
                        Spacer()
                        Button("Ayarlar") {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                        }
                        .font(.caption.bold()).buttonStyle(.bordered)
                    }
                }
            }

            // ─── Günde kaç öğün? ────────────────────────────
            Section(header: Text("Günde Kaç Öğün Yiyorsun?")) {
                HStack(spacing: 0) {
                    ForEach(2...5, id: \.self) { n in
                        Button {
                            if settings.mealCount != n {
                                settings.mealCount = n
                                settings.rebuildEntries()
                                expandedEntryID = nil
                                save()
                            }
                        } label: {
                            VStack(spacing: 4) {
                                Text("\(n)")
                                    .font(.title3.bold())
                                Text("öğün")
                                    .font(.caption2)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(settings.mealCount == n
                                        ? Color.orange
                                        : Color(.systemGray6))
                            .foregroundStyle(settings.mealCount == n ? .white : .primary)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }

            // ─── 2 öğün kombinasyonu ─────────────────────────
            if settings.mealCount == 2 {
                Section("Hangi Öğünler?") {
                    ForEach(TwoMealCombo.allCases, id: \.self) { combo in
                        Button {
                            settings.twoMealCombo = combo
                            settings.rebuildEntries()
                            expandedEntryID = nil
                            save()
                        } label: {
                            HStack {
                                Text(LocalizedStringKey(combo.rawValue))
                                    .foregroundStyle(.primary)
                                Spacer()
                                if settings.twoMealCombo == combo {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.orange)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
            }

            // ─── Öğün listesi ────────────────────────────────
            Section(header: Text("Öğün Saatleri & Hatırlatmalar"),
                    footer: Text("Saat satırına dokun, ayarla ve Tamam'a bas. Hatırlatma toggle'ı ile bildirim aç.")) {
                ForEach($settings.entries) { $entry in
                    MealEntryRow(
                        entry: $entry,
                        isExpanded: expandedEntryID == entry.id,
                        onTapTime: {
                            withAnimation(.spring(response: 0.35)) {
                                expandedEntryID = expandedEntryID == entry.id ? nil : entry.id
                            }
                        },
                        onConfirmTime: {
                            withAnimation(.spring(response: 0.3)) {
                                expandedEntryID = nil
                            }
                            save()
                        },
                        onReminderToggle: {
                            handleReminderToggle(entryID: entry.id)
                        }
                    )
                    .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    .listRowSeparator(.hidden)
                }
            }
        }
        .navigationTitle("Öğün Programı")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { refreshFromStorage() }
    }

    // MARK: - Helpers
    private func save() {
        settings.save()
        MealReminderService.schedule(settings: settings)
    }

    private func refreshFromStorage() {
        settings = MealScheduleSettings.load()
        if let expandedEntryID, !settings.entries.contains(where: { $0.id == expandedEntryID }) {
            self.expandedEntryID = nil
        }
        checkPermission()
    }

    private func checkPermission() {
        WaterReminderService.checkPermission { permissionStatus = $0 }
    }

    private func handleReminderToggle(entryID: String) {
        // Hemen kaydet — kullanıcı geri gitmeden önce UserDefaults'a yaz
        save()
        guard let entry = settings.entries.first(where: { $0.id == entryID }) else { return }
        guard entry.reminderEnabled else { return }

        if permissionStatus.allowsScheduling {
            // Zaten kaydedildi
        } else if permissionStatus == .notDetermined {
            WaterReminderService.requestPermission { granted in
                permissionStatus = granted ? .authorized : .denied
                if !granted,
                   let idx = settings.entries.firstIndex(where: { $0.id == entryID }) {
                    settings.entries[idx].reminderEnabled = false
                }
                save()
            }
        } else {
            if let idx = settings.entries.firstIndex(where: { $0.id == entryID }) {
                settings.entries[idx].reminderEnabled = false
            }
            save()
        }
    }
}

// MARK: - Öğün Satırı
private struct MealEntryRow: View {
    @Binding var entry: MealScheduleEntry
    let isExpanded: Bool
    let onTapTime: () -> Void
    let onConfirmTime: () -> Void
    let onReminderToggle: () -> Void

    private var accentColor: Color {
        switch entry.id {
        case "kahvalti":  return .orange
        case "ogle":      return .yellow
        case "aksam":     return .indigo
        default:          return .green
        }
    }

    var body: some View {
        VStack(spacing: 0) {
            // ── Ana satır ──────────────────────────────────
            HStack(spacing: 12) {
                // İkon
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(accentColor.opacity(0.15))
                        .frame(width: 38, height: 38)
                    Image(systemName: entry.sfIcon)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(accentColor)
                }

                // İsim
                VStack(alignment: .leading, spacing: 2) {
                    Text(LocalizedStringKey(entry.displayName))
                        .font(.subheadline.bold())
                    Text(entry.reminderEnabled ? "Hatırlatma: Açık" : "Hatırlatma: Kapalı")
                        .font(.caption2)
                        .foregroundStyle(entry.reminderEnabled ? accentColor : Color(.systemGray3))
                }

                Spacer()

                // Saat butonu
                Button(action: onTapTime) {
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption)
                        Text(entry.timeLabel)
                            .font(.system(.subheadline, design: .rounded, weight: .semibold))
                            .lineLimit(1)
                            .fixedSize()
                    }
                    .foregroundStyle(isExpanded ? .white : accentColor)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(isExpanded ? accentColor : accentColor.opacity(0.12),
                                in: Capsule())
                }
                .buttonStyle(.plain)
                .fixedSize()

                // Bildirim zili
                Toggle("", isOn: $entry.reminderEnabled)
                    .labelsHidden()
                    .tint(accentColor)
                    .onChange(of: entry.reminderEnabled) { _, _ in onReminderToggle() }
            }
            .padding(.vertical, 10)

            // ── Saat seçici (açılır) ──────────────────────
            if isExpanded {
                Divider()

                VStack(spacing: 8) {
                    // Wheel picker
                    DatePicker(
                        "",
                        selection: Binding(
                            get: { entry.timeDate },
                            set: { d in
                                let c = Calendar.current.dateComponents([.hour, .minute], from: d)
                                entry.hour   = c.hour   ?? entry.hour
                                entry.minute = c.minute ?? entry.minute
                            }
                        ),
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .frame(height: 110)
                    .clipped()

                    // Tamam butonu
                    Button(action: onConfirmTime) {
                        Text("Tamam")
                            .font(.subheadline.bold())
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(accentColor)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .buttonStyle(.plain)
                    .padding(.bottom, 8)
                }
                .padding(.horizontal, 4)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.horizontal, 4)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: .black.opacity(0.04), radius: 4, y: 2)
        .padding(.vertical, 4)
        .animation(.spring(response: 0.35), value: isExpanded)
    }
}
