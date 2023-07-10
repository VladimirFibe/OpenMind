import Combine
import SwiftUI

let minCellSize = CGSize(width: 200, height: 100)

struct Drawing: Equatable {
    var paths: [DrawingPath] = []
    var size: CGSize = .zero
}
struct Cell: Identifiable, Equatable {
    var id = UUID()
    var color = Color(.omViolet)
    var size = minCellSize
    var offset = CGSize.zero
    var shape = CellShape.allCases.randomElement()
    var text = "New Idea!"
    var drawing: Drawing?
    
    mutating func update(drawing: Drawing) {
        self.drawing = drawing
    }
    mutating func update(shape: CellShape) {
        self.shape = shape
    }
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
    
    func addCell(offset: CGSize) {
        let cell = Cell(offset: offset)
        cells.append(cell)
        selectedCell = cell
    }
    
    func delete(_ cell: Cell?) {
        guard let cell else { return }
        if selectedCell == cell { selectedCell = nil }
        cells.removeAll { $0.id == cell.id }
    }
    
    func updateShape(cell: Cell, shape: CellShape) {
        let index = indexOf(cell: cell)
        cells[index].update(shape: shape)
    }
    
    func updateDrawing(cell: Cell, drawing: Drawing) {
        let index = indexOf(cell: cell)
        cells[index].update(drawing: drawing)
    }
}
