import SwiftUI
//import SwiftData

@main
struct OpenMindApp: App {

    var body: some Scene {
        WindowGroup {
            BackgroundView().environmentObject(CellStore())
//ContentView()
        }
//        .modelContainer(for: Item.self)
    }
}
