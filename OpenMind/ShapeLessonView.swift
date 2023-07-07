import SwiftUI

struct ShapeLessonView: View {
    let strokeStyle = StrokeStyle(lineWidth: 10,
                                  lineCap: .round,
                                  lineJoin: .round)
    var body: some View {
        VStack(spacing: 40.0) {
            Heart()
            .stroke(style: strokeStyle)
//            Diamond()
//            .stroke(style: strokeStyle)
            Chevron()
                .stroke(style: strokeStyle)
        }
        .padding(40)
    }
}

struct Heart: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let flip = CGAffineTransform(translationX: rect.width, y: 0).scaledBy(x: -1, y: 1)

        let bottom = CGPoint(x: 0.5 * rect.width, y: rect.height)
        let leftSide = CGPoint(x: 0, y: 0.25 * rect.height)
        let leftTop = CGPoint(x: 0.25 * rect.width, y: 0)
        let midTop = CGPoint(x: 0.5 * rect.width, y: 0.25 * rect.height)
        
        let rightSide = leftSide.applying(flip)
        let rightTop = leftTop.applying(flip)
        
        let sideControl = CGPoint(x: 0, y: 0.75 * rect.height)
        let cornerControl = CGPoint.zero
        let midControl = CGPoint(x: 0.5 * rect.width, y: 0)
        
        path.move(to: bottom)
        path.addCurve(to: leftSide, control1: bottom, control2: sideControl)
        path.addCurve(to: leftTop, control1: leftSide, control2: cornerControl)
        path.addCurve(to: midTop, control1: midControl, control2: midTop)
        path.addCurve(to: rightTop, control1: midTop, control2: midControl)
        path.addCurve(to: rightSide, control1: cornerControl.applying(flip), control2: rightSide)
        path.addCurve(to: bottom, control1: sideControl.applying(flip), control2: bottom)
        
        return path
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addLines([
                .init(x: rect.width / 2, y: 0),
                .init(x: rect.width, y: rect.height / 2),
                .init(x: rect.width / 2, y: rect.height),
                .init(x: 0, y: rect.height / 2)
            ])
            path.closeSubpath()
        }
    }
}

struct Chevron: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addLines([
                .init(x: 0.25 * rect.width, y: 0.5 * rect.height),
                .init(x: 0, y: 0),
                .init(x: 0.75 * rect.width, y: 0),
                .init(x: rect.width, y: 0.5 * rect.height),
                .init(x: 0.75 * rect.width, y: rect.height),
                .init(x: 0, y: rect.height),
            ])
            path.closeSubpath()
        }
    }
}

#Preview {
    ShapeLessonView()
}
