//
//  ContentView.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 11/29/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : AuthViewModel
    
    var body: some View {
        SwiftUI.Group {
            if (viewModel.userSession != nil) {
                PatternBuilder() //Tab view
            } else if (viewModel.userSession == nil) {
                LoginView()
            } else {
                Text("error")
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
