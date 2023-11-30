//
//  CrochetoApp.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 5/22/23.
//

import SwiftUI
import Firebase

@main
struct CrochetoApp: App {
    @StateObject var viewModel = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
