import SwiftUI

struct OpenMindView: View {
    @EnvironmentObject var cellStore: CellStore
    @EnvironmentObject var modalViews: OpenMindView.ModalViews
    @State private var cellShape = CellShape.roundedRect

    var body: some View {
            BackgroundView()
            .onChange(of: cellShape, { _, newShape in
                guard let cell = cellStore.selectedCell else { return }
                cellStore.updateShape(cell: cell, shape: newShape)
            })
            .sheet(isPresented: $modalViews.showShapes) {
                ShapeSelectionGrid(selectedCellShape: $cellShape)
            }
            .fullScreenCover(isPresented: $modalViews.showDrawingPad) {
                DrawingPadView()
            }
    }
}

extension OpenMindView {
    class ModalViews: ObservableObject {
        @Published var showShapes = false
        @Published var showDrawingPad = false
    }
}

#Preview {
    OpenMindView()
        .environmentObject(CellStore())
        .environmentObject(OpenMindView.ModalViews())
}
