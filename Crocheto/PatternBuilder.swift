//
//  PatternBuilder.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 6/26/23.
//

import SwiftUI

struct PatternBuilder: View {
    @State private var rows = [Row]()
    @State private var numRows = 0
    
    @State private var currentStitches = [Stitch]()
    private var currentSitchesPattern: String {
        var pattern = ""
        
        var currentStreak = 1
        if currentStitches.count != 0 {
            for i in 0 ..< currentStitches.count - 1 {
                if (currentStitches[i].getName() != currentStitches[i + 1].getName()) {
                    if (currentStreak != 1) {
                        pattern += "\(currentStitches[i].getAbbreviation()) \(currentStreak), "
                    } else {
                        pattern += "\(currentStitches[i].getAbbreviation()), "
                    }
                        currentStreak = 1
                } else {
                    currentStreak += 1
                }
            }
            if (currentStreak != 1) {
                pattern += "\(currentStitches[currentStitches.count - 1].getAbbreviation()) \(currentStreak)"
            } else {
                pattern += "\(currentStitches[currentStitches.count - 1].getAbbreviation())"
            }
        }
        return pattern
    }
    
    @State private var selectedStitchType = "Chain"
    @State private var selectedNumStitches = 1
    @State private var selectedRepeat = 1
    @State private var grouped = false
    
    
    private var stitchTypes = ["Chain", "Single Crochet", "Double Crochet", "Increase", "Decrease"]
    private var stitchTypeAbbreviations = ["Chain" : "ch",
                                  "Single Crochet" : "sc",
                                  "Double Crochet" : "dc",
                                           "Increase" : "inc",
                                           "Decrease" : "dec"]
    
    private var stitchTypeCounts = ["Chain" : 0,
                                  "Single Crochet" : 0,
                                  "Double Crochet" : 0,
                                    "Increase" : 1,
                                    "Decrease" : -1]
    
    var body: some View {
        ZStack {
            CrochetoColors.lightGreen
                .ignoresSafeArea()
            VStack {
                List {
                    Section {
                        Text("Rows: \(numRows)")
                    }
                    ForEach(rows) { row in
                        Text(row.getPattern())
                    }
                }
                .scrollContentBackground(.hidden)
                
                
                Divider()
                    .overlay(CrochetoColors.darkGreen)
                
                HStack {
                    Text("Current Row:")
                    Spacer()
                    Button("+ row") {
                        if currentStitches.count != 0 {
                            rows.append(Row(stitches: currentStitches))
                            currentStitches = [Stitch]()
                            numRows += 1
                        }
                    }
                    .buttonStyle(.bordered)
                }
                Text(currentSitchesPattern)
                
                HStack {
                    Picker("stitch types", selection: $selectedStitchType) {
                        ForEach(stitchTypes, id: \.self) { stitchType in
                            Text(grouped ? stitchTypeAbbreviations[stitchType]! : stitchType)
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    Picker("number of stitches", selection: $selectedNumStitches) {
                        ForEach(0 ..< 100) { num in
                            Text(String(num))
                        }
                    }
                    .pickerStyle(.wheel)
                    
                    if grouped {
                        Picker("repeat", selection: $selectedRepeat) {
                            ForEach(0 ..< 100) { num in
                                Text(String(num))
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                HStack {
                    Button("+ stitch") {
                        for _ in 0 ..< selectedNumStitches {
                            currentStitches.append(Stitch(name: selectedStitchType, abbreviation: stitchTypeAbbreviations[selectedStitchType] ?? "??", increaseAmount: stitchTypeCounts[selectedStitchType] ?? 0))
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Toggle("Group stitches?", isOn: $grouped)
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
