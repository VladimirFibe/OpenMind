import SwiftUI

struct ShapeSelectionGrid: View {
    @Binding var selectedCellShape: CellShape
    @Environment(\.dismiss) var dismiss
    var body: some View {
        let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 20), count: 2)
        LazyVGrid(columns: columns, spacing: 20.0) {
            ForEach(CellShape.allCases, id: \.self) { cell in
                cell.shape
                    .foregroundStyle(.accent.opacity(0.3))
                    .overlay {
                        cell.shape
                            .stroke(style: StrokeStyle(lineWidth: 10, lineJoin: .round))
                            .foregroundStyle(.accent)
                    }
                    .aspectRatio(2, contentMode: .fit)
                    .onTapGesture {
                        selectedCellShape = cell
                        dismiss()
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ShapeSelectionGrid(selectedCellShape: .constant(.heart))
}
