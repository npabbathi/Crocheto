//
//  TabView.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 11/29/23.
//

import SwiftUI

struct TabView: View {
    var body: some View {
        
    SwiftUI.TabView {
        PatternBuilder()
            .tabItem {
                Label("Pattern Builder", systemImage: "applepencil")
            }
        ProfileView()
            .tabItem {
                Label("Profile", systemImage: "person.fill")
            }
        }
    .tint(CrochetoColors.brown)
    }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabView()
            .environmentObject(AuthViewModel())
    }
}
