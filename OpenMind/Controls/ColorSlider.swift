import SwiftUI

struct ColorSlider: View {
    @Binding var sliderValue: Double
    var range: ClosedRange<Double> = 0...1
    var colors: [Color] = [.black, .blue, .white]
    var body: some View {
        let gradient = LinearGradient(colors: colors, startPoint: .leading, endPoint: .trailing)
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                gradient
                    .frame(height: 10)
                    .cornerRadius(5)
                SliderCircleView(
                    value: $sliderValue,
                    range: range,
                    sliderWidth: geometry.size.width)
                
            }
            .frame(width: geometry.size.width,
                   height: geometry.size.height)
        }
    }
}

extension ColorSlider {
    struct SliderCircleView: View {
        @Binding var value: Double
        let range: ClosedRange<Double>
        let sliderWidth: Double
        let diameter = 30.0
        @State private var offset: CGSize = .zero
        
        var sliderValue: Double {
            let percent = Double(offset.width / (sliderWidth - diameter))
            let value = (range.upperBound - range.lowerBound) * percent + range.lowerBound
            return value
        }
        var body: some View {
            let drag = DragGesture()
                .onChanged {
                    offset.width = clampWidth(translation: $0.translation.width)
                    value = sliderValue
                }
            Circle()
                .frame(width: diameter, height: diameter)
                .foregroundStyle(.white)
                .shadow(color: .gray, radius: 1)
                .gesture(drag)
                .offset(offset)
        }
        
        func clampWidth(translation: Double) -> Double {
            min(sliderWidth - diameter, max(0, offset.width + translation))
        }
    }
}

#Preview {
    @State var sliderValue: Double = 0
    return ColorSlider(sliderValue: $sliderValue)
        .padding()
        .background(Color.secondary)
}
