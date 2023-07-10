import SwiftUI

struct CellView: View {
    
    let cell: Cell
    @State private var text: String = ""
    @State private var offset: CGSize = .zero
    @State private var currentOffset: CGSize = .zero
    @EnvironmentObject var cellStore: CellStore
    @EnvironmentObject var modalViews: OpenMindView.ModalViews
    @FocusState var textFieldIsFocused: Bool
    var isSelected: Bool {  cell == cellStore.selectedCell }
    var body: some View {
        let flyoutMenu = FlyoutMenu(options: setupOptions())
        let drag = DragGesture()
            .onChanged { drag in
                offset = currentOffset + drag.translation
            }
            .onEnded { drag in
                offset = currentOffset + drag.translation
                currentOffset = offset
            }
        ZStack {
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
            if isSelected {
                flyoutMenu
                    .offset(x: cell.size.width / 2, y: -cell.size.height / 2)
            }
        }
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

extension CellView {
    func setupOptions() -> [FlyoutMenu.Option] {
        let options: [FlyoutMenu.Option] = [
            .init(image: Image(systemName: "trash"), color: .omRed) {
                cellStore.delete(cell)
            },
            .init(image: Image(systemName: "square.on.circle"), color: .green) {
                modalViews.showShapes.toggle()
            },
            .init(image: Image(systemName: "link"), color: .purple) {},
            .init(image: Image("crayon"), color: .orange) {
                modalViews.showDrawingPad.toggle()
            }
        ]
        return options
    }
}

#Preview {
    CellView(cell: Cell())
        .environmentObject(CellStore())
        .environmentObject(OpenMindView.ModalViews())
        .padding()
}
