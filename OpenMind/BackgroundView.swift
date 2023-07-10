import SwiftUI

struct BackgroundView: View {
    @EnvironmentObject var cellStrore: CellStore
    var body: some View {
        let doubleTapDrag = DragGesture(minimumDistance: 0)
        let doubleTap = TapGesture(count: 2)
            .sequenced(before: doubleTapDrag)
            .onEnded { value in
                switch value {
                case .second(_, let drag):
                    if let drag {
                        print("add new cell at: ", drag.location)
                        newCell(location: drag.location)
                    }
                default: break
                }
            }
        ZStack(alignment: .topLeading) {
            Color.teal.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    cellStrore.selectedCell = nil
                }
                .simultaneousGesture(doubleTap)
            ForEach(cellStrore.cells) { cell in
                CellView(cell: cell)
            }
        }
    }
    
    func newCell(location: CGPoint) {
        let offset = CGSize(width: location.x, height: location.y)
        cellStrore.addCell(offset: offset)
    }
}

#Preview {
    BackgroundView().environmentObject(CellStore())
}
