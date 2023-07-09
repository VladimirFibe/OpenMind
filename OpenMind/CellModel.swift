import Combine
import SwiftUI

let minCellSize = CGSize(width: 200, height: 100)

struct Cell: Identifiable, Equatable {
    var id = UUID()
    var color = Color(.omViolet)
    var size = minCellSize
    var offset = CGSize.zero
    var shape = CellShape.allCases.randomElement()
    var text = "New Idea!"
}

class CellStore: ObservableObject {
    @Published var selectedCell: Cell?
    @Published var cells: [Cell] = [
        .init(color: .red, text: "Drawing in SwiftUI"),
        .init(color: .green, offset: .init(width: 100, height: 300), text: "Shapes")
    ]
    private func indexOf(cell: Cell) -> Int {
        guard let index = cells.firstIndex(where: { $0.id == cell.id })
        else { fatalError("Cell \(cell) does not exitst")}
        return index
    }
}
