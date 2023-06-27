//
//  PatternBuilder.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 6/26/23.
//

import SwiftUI

struct PatternBuilder: View {
    @State private var rows = [Stitch]()
    @State private var numRows = 0
    
    @State private var selectedStitchType = "Chain"
    @State private var selectedNumStitches = 1
    
    
    private var stitchTypes = ["Chain", "Single Crochet", "Double Crochet"]
    private var stitchTypeAbbreviations = ["Chain" : "ch",
                                  "Single Crochet" : "sc",
                                  "Double Crochet" : "dc"]
    
    private var stitchTypeCounts = ["Chain" : 1,
                                  "Single Crochet" : 1,
                                  "Double Crochet" : 1]
    
    var body: some View {
        ZStack {
            CrochetoColors.lightGreen
                .ignoresSafeArea()
            VStack {
                List {
                    Section {
                        Text("Rows: \(numRows) \(selectedNumStitches)")
                    }
                    ForEach(rows) { stitch in
                        Text(stitch.getAbbreviation())
                    }
                }
                .scrollContentBackground(.hidden)
                Divider()
                    .overlay(CrochetoColors.darkGreen)
                HStack {
                    Picker("stitch types", selection: $selectedStitchType) {
                        ForEach(stitchTypes, id: \.self) { stitchType in
                            Text(stitchType)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Picker("number of stitches", selection: $selectedNumStitches) {
                        ForEach(0 ..< 100) { num in
                            Text(String(num))
                        }
                    }
                    .pickerStyle(.wheel)
                }
                
                Button("add") {
                    for _ in 0 ..< selectedNumStitches {
                        rows.append(Stitch(name: selectedStitchType, abbreviation: stitchTypeAbbreviations[selectedStitchType] ?? "??", increaseAmount: stitchTypeCounts[selectedStitchType] ?? 0))
                    }
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

struct PatternBuilder_Previews: PreviewProvider {
    static var previews: some View {
        PatternBuilder()
    }
}
