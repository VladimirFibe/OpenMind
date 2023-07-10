import SwiftUI

struct CellView: View {
    let cell: Cell
    @State private var text: String = ""
    @State private var offset: CGSize = .zero
    @State private var currentOffset: CGSize = .zero
    @EnvironmentObject var cellStore: CellStore
    @FocusState var textFieldIsFocused: Bool
    var isSelected: Bool {  cell == cellStore.selectedCell }
    var body: some View {
        let drag = DragGesture()
            .onChanged { drag in
                offset = currentOffset + drag.translation
            }
            .onEnded { drag in
                offset = currentOffset + drag.translation
                currentOffset = offset
            }
        ZStack {
            cell.shape?.shape
                .foregroundStyle(Color(.systemBackground))
            TimelineView(.animation(minimumInterval: 0.2)) { context in
                StrokeView(cell: cell, isSelected: isSelected, date: context.date)
            }
            TextField("Enter cell text", text: $text)
                .padding()
                .multilineTextAlignment(.center)
                .focused($textFieldIsFocused)
        }
        .frame(width: cell.size.width, height: cell.size.height)
        .offset(cell.offset + offset)
        .onAppear { text = cell.text}
        .onChange(of: isSelected, { oldValue, newValue in
            if !newValue { textFieldIsFocused = false }
        })
        .onTapGesture { cellStore.selectedCell = cell }
        .simultaneousGesture(drag)
    }
}

extension CellView {
    
    struct StrokeView: View {
        let cell: Cell
        let isSelected: Bool
        let date: Date
        @State var dashPhase = 0.0
        var body: some View {
            let basicStyle = StrokeStyle(lineWidth: 5, lineJoin: .round)
            let selectedStyle = StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round, dash: [50, 15, 30, 15, 15, 15, 5, 10, 5, 15], dashPhase: dashPhase)
            cell.shape?.shape
                .stroke(cell.color.opacity(isSelected ? 0.8 : 1),
                        style: isSelected ? selectedStyle : basicStyle)
                .onChange(of: date, { oldValue, newValue in
                    dashPhase += 8
                })
        }
    }
}

#Preview {
    CellView(cell: Cell())
        .environmentObject(CellStore())
        .padding()
}
