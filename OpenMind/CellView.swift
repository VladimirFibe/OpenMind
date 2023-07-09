import SwiftUI

struct CellView: View {
    let cell: Cell
    @State private var text: String = ""
    @EnvironmentObject var cellStore: CellStore
    var isSelected: Bool {
        cell == cellStore.selectedCell
    }
    var body: some View {
        let basicStyle = StrokeStyle(lineWidth: 5, lineJoin: .round)
        let selectedStyle = StrokeStyle(lineWidth: 7, lineCap: .round, lineJoin: .round, dash: [50, 15, 30, 15, 15, 15, 5, 10, 5, 15], dashPhase: 0)
        ZStack {
            cell.shape?.shape
                .foregroundStyle(.white)
            cell.shape?.shape
                .stroke(cell.color, style: isSelected ? selectedStyle : basicStyle)
            TextField("Enter cell text", text: $text)
                .padding()
                .multilineTextAlignment(.center)
        }
        .frame(width: cell.size.width, height: cell.size.height)
        .offset(cell.offset)
        .onAppear { text = cell.text}
        .onTapGesture { cellStore.selectedCell = cell }
    }
}

#Preview {
    CellView(cell: Cell())
        .environmentObject(CellStore())
        .padding()
}
