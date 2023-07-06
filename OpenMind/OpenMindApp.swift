//
//  OpenMindApp.swift
//  OpenMind
//
//  Created by MacService on 7/6/23.
//

import SwiftUI
import SwiftData

@main
struct OpenMindApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
