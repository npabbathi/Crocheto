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
    
    @State private var currentRow = [Group]()
    @State private var currentGroup = [Stitch]()
    private var currentSitchesPattern: String { //NOT WORKING
        var pattern = ""
        
        if currentRow.count > 1 {
            for i in stride(from: currentRow.count - 1, to: 0, by: -1) {
                if currentRow[i].getStitches() == currentRow[i - 1].getStitches() {
                    currentRow[i - 1].incRepeats(currentRow[i].getRepeats())
                    currentRow.remove(at: i)
                }
            }
            
            if currentRow[1].getStitches() == currentRow[0].getStitches() {
                currentRow[0].incRepeats(currentRow[1].getRepeats())
                currentRow.remove(at: 1)
            }
        }
        
        for group in currentRow {
            pattern += group.toString() + ", "
        }
        
        return "ROW: " + pattern
        //        var pattern = ""
        //
        //        var currentStreak = 1
        //        if currentStitches.count != 0 {
        //            for i in 0 ..< currentStitches.count - 1 {
        //                if (currentStitches[i].getName() != currentStitches[i + 1].getName()) {
        //                    if (currentStreak != 1) {
        //                        pattern += "\(currentStitches[i].getAbbreviation()) \(currentStreak), "
        //                    } else {
        //                        pattern += "\(currentStitches[i].getAbbreviation()), "
        //                    }
        //                        currentStreak = 1
        //                } else {
        //                    currentStreak += 1
        //                }
        //            }
        //            if (currentStreak != 1) {
        //                pattern += "\(currentStitches[currentStitches.count - 1].getAbbreviation()) \(currentStreak)"
        //            } else {
        //                pattern += "\(currentStitches[currentStitches.count - 1].getAbbreviation())"
        //            }
        //        }
        //        return pattern
    }
    
    private var currentGroupPattern: String {
        var groupPattern = currentGroup.count == 1 ? "" : "("
        
        var currentStreak = 1
        if currentGroup.count != 0 {
            for i in 0 ..< currentGroup.count - 1 {
                if (currentGroup[i].getName() != currentGroup[i + 1].getName()) {
                    if (currentStreak != 1) {
                        groupPattern += "\(currentGroup[i].getAbbreviation()) \(currentStreak), "
                    } else {
                        groupPattern += "\(currentGroup[i].getAbbreviation()), "
                    }
                    currentStreak = 1
                } else {
                    currentStreak += 1
                }
            }
            if (currentStreak != 1) {
                groupPattern += "\(currentGroup[currentGroup.count - 1].getAbbreviation()) \(currentStreak)"
            } else {
                groupPattern += "\(currentGroup[currentGroup.count - 1].getAbbreviation())"
            }
        }
        return groupPattern + (currentGroup.count == 1 ? "" : ") x\(selectedRepeat)")
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
            LinearGradient(colors: [CrochetoColors.lightGreen, CrochetoColors.white], startPoint: .top, endPoint: .bottom)
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
                        if currentRow.count != 0 {
                            rows.append(Row(groups: currentRow))
                            currentRow = [Group]()
                            numRows += 1
                        }
                    }
                    .buttonStyle(.bordered)
                }
                Text(currentSitchesPattern)
                if grouped {
                    Text(currentGroupPattern)
                }
                
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
                            
                            if grouped {
                                currentGroup.append(Stitch(name: selectedStitchType, abbreviation: stitchTypeAbbreviations[selectedStitchType] ?? "??", increaseAmount: stitchTypeCounts[selectedStitchType] ?? 0))
                            } else {
                                currentGroup.append(Stitch(name: selectedStitchType, abbreviation: stitchTypeAbbreviations[selectedStitchType] ?? "??", increaseAmount: stitchTypeCounts[selectedStitchType] ?? 0))
                                currentRow.append(Group(groupStitchs: currentGroup, numRepeat: 1))
                                currentGroup = [Stitch]()
                            }
                        }
                    }
                    .buttonStyle(.bordered)
                    
                    Toggle("Group stitches?", isOn: $grouped)
                    
                    if grouped {
                        Button("+ group") {
                            if currentGroup.count != 0 {
                                currentRow.append(Group(groupStitchs: currentGroup, numRepeat: selectedRepeat))
                                currentGroup = [Stitch]()
                                grouped.toggle()
                            }
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
