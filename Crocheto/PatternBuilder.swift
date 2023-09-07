//
//  PatternBuilder.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 6/26/23.
//

import SwiftUI

struct PatternBuilder: View {
    
    @StateObject private var viewModel = ViewModel()
    
    private let stitchTypes = ["Chain", "Single Crochet", "Double Crochet", "Increase", "Decrease"]
    private let stitchTypeAbbreviations = ["Chain" : "ch",
                                           "Single Crochet" : "sc",
                                           "Double Crochet" : "dc",
                                           "Increase" : "inc",
                                           "Decrease" : "dec"]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [CrochetoColors.lightGreen, CrochetoColors.white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                //finished rows at the top of the screen
                List {
                    Section {
                        Text("Rows: \(viewModel.numRows)")
                    }
                    ForEach(viewModel.rows) { row in
                        Text(row.getPattern())
                    }
                }
                .scrollContentBackground(.hidden)
                
                Divider()
                    .overlay(CrochetoColors.darkGreen)
                
                //working row to be added to the top of the screen
                HStack {
                    Text("Current Row:")
                    Spacer()
                    Button("+ row") {
                        viewModel.addRow()
                    }
                    .buttonStyle(.bordered)
                }
                Text(viewModel.getCurrentRowPattern())
                if viewModel.grouped {
                    Text(viewModel.getCurrentGroupPattern())
                }
                
                HStack {
                    Picker("stitch types", selection: $viewModel.selectedStitchType) {
                        ForEach(stitchTypes, id: \.self) { stitchType in
                            Text(viewModel.grouped ? stitchTypeAbbreviations[stitchType]! : stitchType)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Picker("number of stitches", selection: $viewModel.selectedNumStitches) {
                        ForEach(0 ..< 100) { num in
                            Text(String(num))
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    if viewModel.grouped {
                        Picker("repeat", selection: $viewModel.selectedRepeat) {
                            ForEach(0 ..< 100) { num in
                                Text(String(num))
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                HStack {
                    Button("+ stitch") {
                        viewModel.addStitch(stitchTypeAbbreviations: stitchTypeAbbreviations)
                    }
                    .buttonStyle(.bordered)
                    
                    Toggle("Group stitches?", isOn: $viewModel.grouped)
                    
                    if viewModel.grouped {
                        Button("+ group") {
                            viewModel.addGroup()
                        }
                        .buttonStyle(.bordered)
                    }
                }
            }
            .padding()
        }
    }
}

struct PatternBuilder_Previews: PreviewProvider {
    static var previews: some View {
        PatternBuilder()
    }
}
