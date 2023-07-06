import SwiftUI

struct CatView: View {
    var gradient: Gradient {
        let stops: [Gradient.Stop] = [
            .init(color: .omViolet, location: 0.0),
            .init(color: .indigo, location: 0.4),
            .init(color: .mint, location: 0.45)
        ]
        return Gradient(stops: stops)
    }
    var body: some View {
        ZStack {
            Color(.tertiarySystemBackground)
                .ignoresSafeArea()
            VStack {
                Image(.ozma)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250)
                    .clipShape(Circle())
                    .overlay {
                        LinearGradient(gradient: gradient, startPoint: .bottom, endPoint: .top)
                            .clipShape(
                                Circle().stroke(lineWidth: 16)
                            )
                    }
                Text("Ozma")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    CatView()
}
