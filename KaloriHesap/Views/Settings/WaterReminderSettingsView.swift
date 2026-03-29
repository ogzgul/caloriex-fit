import SwiftUI
import UserNotifications

struct WaterReminderSettingsView: View {
    @State private var settings = WaterReminderSettings.load()
    @State private var permissionStatus: UNAuthorizationStatus = .notDetermined
    @State private var showPermissionAlert = false

    var body: some View {
        Form {
            // ─── İzin Durumu ───────────────────────────────────
            if permissionStatus == .denied {
                Section {
                    HStack(spacing: 12) {
                        Image(systemName: "bell.slash.fill")
                            .foregroundStyle(.red)
                        VStack(alignment: .leading, spacing: 2) {
                            Text("Bildirim İzni Kapalı")
                                .font(.subheadline.bold())
                            Text("Hatırlatmaları açmak için Ayarlar > KaloriHesap > Bildirimler kısmından izin ver.")
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
            }

            // ─── Hatırlatmayı Aç/Kapa ──────────────────────────
            Section {
                Toggle(isOn: $settings.isEnabled) {
                    Label("Su Hatırlatması", systemImage: "drop.fill")
                }
                .tint(.blue)
                .onChange(of: settings.isEnabled) { _, newValue in
                    if newValue {
                        handleEnableToggle()
                    } else {
                        WaterReminderService.cancelAll()
                        saveAndSchedule()
                    }
                }
            } footer: {
                Text("Günlük su hedefine ulaşman için seni hatırlatır. Her gün gece yarısında kayıt sıfırlanır.")
            }

            // ─── Mod Seçimi ────────────────────────────────────
            if settings.isEnabled {
                Section("Hatırlatma Sıklığı") {
                    ForEach(WaterReminderMode.allCases, id: \.self) { mode in
                        Button {
                            settings.mode = mode
                            saveAndSchedule()
                        } label: {
                            HStack(spacing: 12) {
                                Image(systemName: mode.icon)
                                    .foregroundStyle(.blue)
                                    .frame(width: 24)
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(LocalizedStringKey(mode.rawValue))
                                        .font(.body)
                                        .foregroundStyle(.primary)
                                    Text(LocalizedStringKey(mode.description))
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                if settings.mode == mode {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.blue)
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }

                // ─── Saat Başı Ayarları ─────────────────────────
                if settings.mode == .saatBasi {
                    Section(header: Text("Saat Aralığı"),
                            footer: Text("\(hourLabel(settings.startHour))–\(hourLabel(settings.endHour)): \(settings.endHour - settings.startHour + 1)x \(String(localized: "hatırlatma"))")) {
                        Stepper(value: $settings.startHour, in: 6...settings.endHour - 1) {
                            HStack {
                                Label("Başlangıç", systemImage: "sunrise.fill")
                                Spacer()
                                Text(hourLabel(settings.startHour))
                                    .foregroundStyle(.blue)
                                    .bold()
                            }
                        }
                        .onChange(of: settings.startHour) { _, _ in saveAndSchedule() }

                        Stepper(value: $settings.endHour, in: settings.startHour + 1...23) {
                            HStack {
                                Label("Bitiş", systemImage: "sunset.fill")
                                Spacer()
                                Text(hourLabel(settings.endHour))
                                    .foregroundStyle(.blue)
                                    .bold()
                            }
                        }
                        .onChange(of: settings.endHour) { _, _ in saveAndSchedule() }
                    }
                }

                // ─── Günde 1 Kez Ayarları ──────────────────────
                if settings.mode == .belirliSaat {
                    Section(header: Text("Hatırlatma Saati"),
                            footer: Text("\(hourLabel(settings.onceHour, minute: settings.onceMinute)): 1 \(String(localized: "hatırlatma"))")) {
                        DatePicker(
                            "Saat",
                            selection: Binding(
                                get: {
                                    var c = DateComponents()
                                    c.hour = settings.onceHour
                                    c.minute = settings.onceMinute
                                    return Calendar.current.date(from: c) ?? Date()
                                },
                                set: { newDate in
                                    let c = Calendar.current.dateComponents([.hour, .minute], from: newDate)
                                    settings.onceHour = c.hour ?? 9
                                    settings.onceMinute = c.minute ?? 0
                                    saveAndSchedule()
                                }
                            ),
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .frame(maxWidth: .infinity)
                    }
                }

                // ─── Özet ──────────────────────────────────────
                Section {
                    HStack {
                        Image(systemName: "bell.badge.fill")
                            .foregroundStyle(.blue)
                        Text(summaryText)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle("Su Hatırlatması")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { checkPermission() }
    }

    // MARK: - Helpers

    private var summaryText: String {
        switch settings.mode {
        case .saatBasi:
            let count = settings.endHour - settings.startHour + 1
            return "\(hourLabel(settings.startHour))–\(hourLabel(settings.endHour)): \(count)x \(String(localized: "hatırlatma"))"
        case .belirliSaat:
            return "\(hourLabel(settings.onceHour, minute: settings.onceMinute)): 1 \(String(localized: "hatırlatma"))"
        }
    }

    private func hourLabel(_ hour: Int, minute: Int = 0) -> String {
        String(format: "%02d:%02d", hour, minute)
    }

    private func saveAndSchedule() {
        settings.save()
        WaterReminderService.schedule(settings: settings)
    }

    private func checkPermission() {
        WaterReminderService.checkPermission { status in
            permissionStatus = status
        }
    }

    private func handleEnableToggle() {
        WaterReminderService.checkPermission { status in
            permissionStatus = status
            if status == .authorized {
                saveAndSchedule()
            } else if status == .notDetermined {
                WaterReminderService.requestPermission { granted in
                    permissionStatus = granted ? .authorized : .denied
                    if granted { saveAndSchedule() }
                    else { settings.isEnabled = false }
                }
            } else {
                // denied — toggle geri al
                settings.isEnabled = false
                showPermissionAlert = true
            }
        }
    }
}
