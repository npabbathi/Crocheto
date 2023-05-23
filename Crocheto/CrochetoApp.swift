//
//  CrochetoApp.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 5/22/23.
//

import SwiftUI

@main
struct CrochetoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
