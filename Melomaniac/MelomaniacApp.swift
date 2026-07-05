//
//  MelomaniacApp.swift
//  Melomaniac
//
//  Created by Allan Auezkhan on 29.05.2026.
//

import SwiftUI
import CoreData

@main
struct MelomaniacApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
