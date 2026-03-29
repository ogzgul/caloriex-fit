import SwiftUI

struct MacroBarView: View {
    let protein: Double
    let carbs: Double
    let fat: Double
    let proteinGoal: Double
    let carbsGoal: Double
    let fatGoal: Double

    var body: some View {
        HStack(spacing: 16) {
            MacroItem(
                label: "Protein",
                value: protein,
                goal: proteinGoal,
                unit: "g",
                color: .blue
            )
            Divider().frame(height: 40)
            MacroItem(
                label: "Karb",
                value: carbs,
                goal: carbsGoal,
                unit: "g",
                color: .orange
            )
            Divider().frame(height: 40)
            MacroItem(
                label: "Yağ",
                value: fat,
                goal: fatGoal,
                unit: "g",
                color: .yellow
            )
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}

private struct MacroItem: View {
    let label: LocalizedStringKey
    let value: Double
    let goal: Double
    let unit: String
    let color: Color

    private var progress: Double { min(value / max(goal, 1), 1.0) }

    var body: some View {
        VStack(spacing: 6) {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text("\(Int(value))\(unit)")
                .font(.system(.subheadline, design: .rounded, weight: .semibold))

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Capsule().fill(Color(.systemGray5)).frame(height: 5)
                    Capsule()
                        .fill(color)
                        .frame(width: geo.size.width * progress, height: 5)
                        .animation(.easeInOut(duration: 0.6), value: progress)
                }
            }
            .frame(height: 5)

            Text("/ \(Int(goal))\(unit)")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .frame(maxWidth: .infinity)
    }
}
