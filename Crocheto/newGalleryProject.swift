//
//  newGalleryProject.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 5/23/23.
//

import SwiftUI

struct newGalleryProject: View {
    var body: some View {
        ZStack {
            CrochetoColors.lightGreen.ignoresSafeArea()
            Text("Project Description goes here")
        }
    }
}

struct newGalleryProject_Previews: PreviewProvider {
    static var previews: some View {
        newGalleryProject()
    }
}
