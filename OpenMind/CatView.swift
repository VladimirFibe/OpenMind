import SwiftUI

struct CatView: View {
    var body: some View {
        ZStack {
            Color.teal
                .ignoresSafeArea()
            Image(.ozma)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .overlay {
                    Circle()
                        .stroke(lineWidth: 8)
                        .foregroundStyle(.white)
                }
                .frame(width: 250)
        }
    }
}

#Preview {
    CatView()
}
