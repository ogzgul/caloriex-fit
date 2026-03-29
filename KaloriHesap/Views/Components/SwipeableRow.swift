import SwiftUI

// MARK: - Swipeable satır wrapper
struct SwipeableRow<Content: View>: View {
    let content: Content
    let onEdit: () -> Void
    let onDelete: () -> Void

    @State private var offset: CGFloat = 0
    @State private var showDeleteConfirm = false
    @GestureState private var isDragging = false

    // Aksiyon buton genişlikleri
    private let totalRight: CGFloat = 72   // sağda sil
    private let totalLeft: CGFloat  = 72   // solda düzenle

    init(onEdit: @escaping () -> Void,
         onDelete: @escaping () -> Void,
         @ViewBuilder content: () -> Content) {
        self.onEdit   = onEdit
        self.onDelete = onDelete
        self.content  = content()
    }

    var body: some View {
        ZStack(alignment: .trailing) {

            // ─── Arka plan aksiyonları ───────────────────────
            HStack(spacing: 0) {

                // Sol: Düzenle (offset > 0 iken görünür)
                Button(action: {
                    resetOffset()
                    onEdit()
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "pencil")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Düzenle")
                            .font(.caption2.bold())
                    }
                    .foregroundStyle(.white)
                    .frame(width: totalLeft)
                    .frame(maxHeight: .infinity)
                    .background(Color.orange)
                }
                .opacity(offset > 8 ? 1 : 0)

                Spacer()

                // Sağ: Sil (offset < 0 iken görünür)
                Button(action: {
                    showDeleteConfirm = true
                }) {
                    VStack(spacing: 4) {
                        Image(systemName: "trash")
                            .font(.system(size: 16, weight: .semibold))
                        Text("Sil")
                            .font(.caption2.bold())
                    }
                    .foregroundStyle(.white)
                    .frame(width: totalRight)
                    .frame(maxHeight: .infinity)
                    .background(Color.red)
                }
                .opacity(offset < -8 ? 1 : 0)
            }

            // ─── İçerik (kaydırılan) ─────────────────────────
            content
                .offset(x: offset)
                .background(Color(.systemBackground))
                .simultaneousGesture(
                    DragGesture(minimumDistance: 10, coordinateSpace: .local)
                        .onChanged { value in
                            let h = value.translation.width
                            let v = value.translation.height
                            // Yalnızca yatay harekette tetiklen
                            guard abs(h) > abs(v) else { return }
                            if h < 0 {
                                offset = max(h, -totalRight - 10)
                            } else {
                                offset = min(h, totalLeft + 10)
                            }
                        }
                        .onEnded { value in
                            let h = value.translation.width
                            let v = value.translation.height
                            guard abs(h) > abs(v) else {
                                withAnimation(.spring(response: 0.3)) { offset = 0 }
                                return
                            }
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                                if h < -totalRight / 2 {
                                    offset = -totalRight   // sil açık
                                } else if h > totalLeft / 2 {
                                    offset = totalLeft     // düzenle açık
                                } else {
                                    offset = 0            // kapat
                                }
                            }
                        }
                )
        }
        .clipped()
        .confirmationDialog(
            "Bu yemeği silmek istiyor musun?",
            isPresented: $showDeleteConfirm,
            titleVisibility: .visible
        ) {
            Button("Sil", role: .destructive) {
                resetOffset()
                onDelete()
            }
            Button("İptal", role: .cancel) {
                resetOffset()
            }
        }
    }

    private func resetOffset() {
        withAnimation(.spring(response: 0.3)) { offset = 0 }
    }
}
