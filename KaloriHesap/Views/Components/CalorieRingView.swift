import SwiftUI

struct CalorieRingView: View {
    let consumed: Double
    let goal: Double
    var size: CGFloat = 160

    private var progress: Double { min(consumed / max(goal, 1), 1.0) }
    private var remaining: Double { max(goal - consumed, 0) }
    private var isOver: Bool { consumed > goal }

    var body: some View {
        ZStack {
            // Arka plan halkası
            Circle()
                .stroke(Color(.systemGray5), lineWidth: ringWidth)
                .frame(width: size, height: size)

            // Dolum halkası
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        colors: isOver ? [.red, .orange] : [.green, .mint],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: ringWidth, lineCap: .round)
                )
                .frame(width: size, height: size)
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.8), value: progress)

            // Merkez metin
            VStack(spacing: 2) {
                Text(isOver ? "Aşıldı!" : "Kalan")
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                Text(isOver
                     ? "+\(Int(consumed - goal))"
                     : "\(Int(remaining))")
                    .font(.system(size: size * 0.18, weight: .bold, design: .rounded))
                    .foregroundStyle(isOver ? .red : .primary)

                Text("kcal")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var ringWidth: CGFloat { size * 0.1 }
}

#Preview {
    CalorieRingView(consumed: 1400, goal: 2000)
        .padding()
}
