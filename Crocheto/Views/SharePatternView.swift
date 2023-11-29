//
//  SharePatternView.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 11/16/23.
//

import SwiftUI

struct SharePatternView: View {
    
    @StateObject private var viewModel = ViewModel()
    @State var rows : [Row]
    @State private var patternName = "".uppercased()
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [CrochetoColors.lightGreen, CrochetoColors.green], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                
                Text(patternName == "" ? "MY PATTERN" : patternName.uppercased())
                    .font(.title)
                    .kerning(2)
                    .foregroundColor(CrochetoColors.white)
                    .padding()
                
                TextField("Name your pattern", text: $patternName)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(CrochetoColors.white)
                    .cornerRadius(10)
                    .padding()
                
                Divider()
                    .overlay(CrochetoColors.white)
                    .padding()
                
                List {
                    ForEach(rows.indices, id: \.self) { index in
                        Text("Row \(index + 1): \(rows[index].getPattern())")
                    }
                }
                .scrollContentBackground(.hidden)
                
                ShareLink(item: viewModel.getSharePattern(rows: rows, patternName: patternName))
                    .buttonStyle(.bordered)
                    .tint(.white)
            }
        }
    }
}

struct SharePatternView_Previews: PreviewProvider {
    static var previews: some View {
        SharePatternView(rows: [Row(groups: [Group]())])
    }
}
