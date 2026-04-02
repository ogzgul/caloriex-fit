import Foundation
import CoreMotion
import Combine

final class StepCounterService: ObservableObject, @unchecked Sendable {

    // MARK: - Yayınlanan veriler
    @Published private(set) var todaySteps: Int = 0
    @Published private(set) var todayDistanceMeters: Double = 0
    @Published private(set) var isAvailable: Bool = CMPedometer.isStepCountingAvailable()
    @Published private(set) var authorizationDenied: Bool = false

    // MARK: - Hedef (UserDefaults)
    var stepGoal: Int {
        get { UserDefaults.standard.integer(forKey: "stepGoal").nonZero ?? 10_000 }
        set { UserDefaults.standard.set(newValue, forKey: "stepGoal") }
    }

    // MARK: - Hesaplamalar
    func caloriesBurned(weightKg: Double) -> Double {
        Double(todaySteps) * weightKg * 0.0005
    }

    var distanceKm: Double { todayDistanceMeters / 1000 }

    var progress: Double {
        guard stepGoal > 0 else { return 0 }
        return min(Double(todaySteps) / Double(stepGoal), 1.0)
    }

    // MARK: - Private
    private let pedometer = CMPedometer()
    private var started = false

    // MARK: - Başlat / Durdur
    func start() {
        guard !started else { return }

        guard CMPedometer.isStepCountingAvailable() else {
            DispatchQueue.main.async { self.isAvailable = false }
            return
        }

        switch CMPedometer.authorizationStatus() {
        case .denied, .restricted:
            DispatchQueue.main.async { self.authorizationDenied = true }
        case .authorized:
            started = true
            beginTracking()
        case .notDetermined:
            started = true
            requestPermissionThenTrack()
        @unknown default:
            break
        }
    }

    func stop() {
        pedometer.stopUpdates()
        started = false
    }

    // MARK: - Private

    private func requestPermissionThenTrack() {
        let startOfDay = Calendar.current.startOfDay(for: Date())
        pedometer.queryPedometerData(from: startOfDay, to: Date()) { [weak self] data, error in
            guard let self else { return }
            if let nsErr = error as NSError?, nsErr.domain == CMErrorDomain {
                DispatchQueue.main.async {
                    self.authorizationDenied = true
                    self.started = false
                }
                return
            }
            let steps = data?.numberOfSteps.intValue ?? 0
            let distance = data?.distance?.doubleValue ?? 0
            DispatchQueue.main.async {
                self.todaySteps = steps
                self.todayDistanceMeters = distance
                self.beginTracking()
            }
        }
    }

    private func beginTracking() {
        let startOfDay = Calendar.current.startOfDay(for: Date())

        // Anlık veri
        pedometer.queryPedometerData(from: startOfDay, to: Date()) { [weak self] data, error in
            guard let data, error == nil else { return }
            let steps = data.numberOfSteps.intValue
            let distance = data.distance?.doubleValue ?? 0
            DispatchQueue.main.async {
                self?.todaySteps = steps
                self?.todayDistanceMeters = distance
            }
        }

        // Canlı güncelleme
        pedometer.startUpdates(from: startOfDay) { [weak self] data, error in
            guard let data, error == nil else { return }
            let steps = data.numberOfSteps.intValue
            let distance = data.distance?.doubleValue ?? 0
            DispatchQueue.main.async {
                self?.todaySteps = steps
                self?.todayDistanceMeters = distance
            }
        }
    }
}

private extension Int {
    var nonZero: Int? { self == 0 ? nil : self }
}
