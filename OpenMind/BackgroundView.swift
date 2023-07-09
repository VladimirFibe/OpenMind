import SwiftUI

struct BackgroundView: View {
    @EnvironmentObject var cellStrore: CellStore
    var body: some View {
        ZStack {
            Color.teal.opacity(0.7)
                .ignoresSafeArea()
                .onTapGesture {
                    cellStrore.selectedCell = nil
                }
            ForEach(cellStrore.cells) { cell in
                CellView(cell: cell)
            }
        }
    }
}

#Preview {
    BackgroundView().environmentObject(CellStore())
}
