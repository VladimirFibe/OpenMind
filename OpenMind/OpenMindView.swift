import SwiftUI

struct OpenMindView: View {
    @EnvironmentObject var cellStore: CellStore
    @State private var sliderValue = 0.0
    var body: some View {
        VStack {
            VStack {
                ColorSlider(sliderValue: $sliderValue,
                            range: 0...255,
                            color: cellStore.selectedCell?.color ?? .blue)
            
                Text(String(format: "%.2f", sliderValue))
            }
            .padding()
            .frame(height: 80)
            BackgroundView()
        }
    }
}

#Preview {
    OpenMindView().environmentObject(CellStore())
}
