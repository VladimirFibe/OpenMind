import SwiftUI
//import SwiftData

@main
struct OpenMindApp: App {

    var body: some Scene {
        WindowGroup {
            OpenMindView().environmentObject(CellStore())
                .environmentObject(OpenMindView.ModalViews())
//ContentView()
        }
//        .modelContainer(for: Item.self)
    }
}
