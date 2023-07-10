import SwiftUI

struct ColorPicker: View {
    @Binding var pickedColor: Color
    var body: some View {
        HStack {
            ForEach(Color.allCases, id: \.self) { color in
                Circle()
                    .foregroundStyle(color.color)
                    .onTapGesture {
                        pickedColor = color
                    }
                    .overlay {
                        Circle()
                            .padding()
                            .foregroundStyle(pickedColor == color ? SwiftUI.Color(.systemBackground) : .clear)
                    }
            }
        }
    }
}

extension ColorPicker {
    enum Color: CaseIterable {
        case black, violet, blue, green, yellow, orange, red
        
        var color: SwiftUI.Color {
            SwiftUI.Color(uiColor: uiColor)
        }
        
        var uiColor: UIColor {
            switch self {
            case .black: return UIColor(.omBlack)
            case .violet: return UIColor(.omViolet)
            case .blue: return UIColor(.omBlue)
            case .green: return UIColor(.omGreen)
            case .yellow: return UIColor(.omYellow)
            case .orange: return UIColor(.omOrange)
            case .red: return UIColor(.omRed)
            }
        }
    }
}

struct ColorPickerView: View {
    @State private var pickedColor: ColorPicker.Color = .red
    
    var body: some View {
        VStack {
            Circle()
                .foregroundStyle(pickedColor.color)
                .padding(.horizontal, 50)
            ColorPicker(pickedColor: $pickedColor)
        }
        .padding()
    }
}

#Preview {
    ColorPickerView()
}
