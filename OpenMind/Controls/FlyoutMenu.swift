import SwiftUI
import Algorithms

struct FlyoutMenu: View {
    struct Option {
        var image: Image
        var color: Color
        var action: () -> () = {}
    }
    let iconDiameter = 44.0
    let menuDiameter = 150.0
    
    let options: [Option]
    @State private var isOpen = false
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.pink.opacity(0.1))
                .frame(width: isOpen ? menuDiameter : 0)
            ForEach(options.indexed(), id: \.index) { index, option in
                button(option: option, at: index)
                    .scaleEffect(isOpen ? 1 : 0.1)
            }
            .disabled(!isOpen)
            MainView(diameter: iconDiameter, isOpen: $isOpen)
        }
    }
    
    func button(option: Option, at index: Int) -> some View {
        let angle = .pi / 4 * Double(index) - .pi * (isOpen ? 0.6 : 1)
        let radius = menuDiameter / 2
        return Button(action: option.action) {
            ZStack {
                Circle().fill(option.color)
                    .frame(width: iconDiameter, height: iconDiameter)
                option.image
                    .foregroundStyle(.white)
            }
        }
        .offset(x: cos(angle) * radius, y: sin(angle) * radius)
    }
}

extension FlyoutMenu {
    struct MainView: View {
        let diameter: Double
        @Binding var isOpen: Bool
        
        var body: some View {
            Button {
                withAnimation {
                    isOpen.toggle()
                }
            } label: {
                ZStack {
                    Circle()
                        .foregroundStyle(.omRed)
                        .frame(width: diameter, height: diameter)
                    Image(systemName: "plus")
                        .foregroundStyle(.white)
                        .font(.title)
                        .rotationEffect(isOpen ? .degrees(45) : .degrees(0))
                }
            }

        }
    }
}

#Preview {
    FlyoutMenu(options: [
        .init(image: Image(systemName: "trash"), color: .omBlue),
        .init(image: Image(systemName: "pawprint"), color: .omOrange),
        .init(image: Image(systemName: "book"), color: .teal),
        .init(image: Image(systemName: "flame"), color: .omRed),
        .init(image: Image(systemName: "link"), color: .purple)
    ])
}
