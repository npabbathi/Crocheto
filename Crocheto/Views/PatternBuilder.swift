//
//  PatternBuilder.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 6/26/23.
//

import SwiftUI

struct PatternBuilder: View {
    
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [CrochetoColors.lightGreen, CrochetoColors.white], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                VStack {
                    NavigationLink("share", destination: SharePatternView(rows: viewModel.rows))
                        .foregroundColor(CrochetoColors.darkGreen)
                        .buttonStyle(.bordered)
                    
                    //finished rows at the top of the screen
                    List {
                        Section {
                            Text("Row count: \(viewModel.rows.count)")
                        }
                        
                        ForEach(viewModel.rows.indices, id: \.self) { index in
                            Text("Row \(index + 1): \(viewModel.rows[index].getPattern())")
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { i in
                                viewModel.removeRow(i)
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .cornerRadius(20)
                    
                    Divider()
                        .overlay(CrochetoColors.darkGreen)
                    
                    //crafting table area for the current row
                    HStack {
                        Text("Current Row:")
                        Spacer()
                        Button("+ row") {
                            viewModel.addRow()
                        }
                        .buttonStyle(.bordered)
                        .tint(CrochetoColors.darkGreen)
                    }
                    Text(viewModel.getCurrentRowPattern())
                    if viewModel.grouped {
                        Text(viewModel.getCurrentGroupPattern())
                    }
                    
                    //wheels
                    HStack {
                        Picker("stitch types", selection: $viewModel.selectedStitchType) {
                            ForEach(PatternBuilder.ViewModel.stitchTypeAbbreviations.sorted(by: <), id: \.key) { key, value in
                                Text(viewModel.grouped ? PatternBuilder.ViewModel.stitchTypeAbbreviations[key]! : key)
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
                            viewModel.addStitch()
                        }
                        .buttonStyle(.bordered)
                        .tint(CrochetoColors.darkGreen)
                        
                        Button("- stitch") {
                            viewModel.removeStitch()
                        }
                        .buttonStyle(.bordered)
                        .tint(CrochetoColors.green)
                        
                        Toggle(viewModel.grouped ? "" : "Group stitches?", isOn: $viewModel.grouped)
                            .tint(Color.gray)
                        
                        if viewModel.grouped {
                            Button("+ group") {
                                viewModel.addGroup()
                            }
                            .buttonStyle(.bordered)
                            .tint(CrochetoColors.darkGreen)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

struct PatternBuilder_Previews: PreviewProvider {
    static var previews: some View {
        PatternBuilder()
    }
}
