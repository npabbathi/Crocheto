//
//  PatternBuilder-ViewModel.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 9/6/23.
//

import Foundation

extension PatternBuilder {
    @MainActor class ViewModel: ObservableObject {
        //TODO: private(set) encapsulation looking bad rn
        @Published var selectedStitchType = "Chain"
        @Published var selectedNumStitches = 1
        @Published var selectedRepeat = 1
        @Published var grouped = false
        
        @Published var rows = [Row]()
        @Published var numRows = 0
        
        @Published var currentRow = [Group]()
        @Published var currentGroup = [Stitch]()
        
        /// Function to add the user's current working row to the list of total final rows
        func addRow() {
            if currentRow.count != 0 {
                rows.append(Row(groups: currentRow))
                currentRow = [Group]()
                numRows += 1
            }
        }
        
        /// Function to add the user's current working group of stitches to their current working row
        func addGroup() {
            if currentGroup.count != 0 {
                currentRow.append(Group(groupStitchs: currentGroup, numRepeat: selectedRepeat))
                currentGroup = [Stitch]()
                grouped.toggle()
            }
        }
        
        /// Function to add the user's current number of stitches their current working row
        func addStitch(stitchTypeAbbreviations : [String : String]) { //TODO: passing in a constant, uneeded parameter!!!
            for _ in 0 ..< selectedNumStitches {
                currentGroup.append(Stitch(name: selectedStitchType, abbreviation: stitchTypeAbbreviations[selectedStitchType] ?? "??"))
                if !grouped {
                    currentRow.append(Group(groupStitchs: currentGroup, numRepeat: 1))
                    currentGroup = [Stitch]()
                }
            }
        }
        
        /// Function to get the current  row pattern the user is working on
        /// - Returns: String representation of the current row
        func getCurrentRowPattern() -> String {
            var pattern = ""
            
            if currentRow.count > 1 { //TODO: combine if statements lol this style is horrible
                if currentRow[currentRow.count - 1].equalStitches(other: currentRow[currentRow.count - 2]) {
                    //increases repeat
                    currentRow[currentRow.count - 2].incRepeats(currentRow[currentRow.count - 1].getRepeats())
                    currentRow.remove(at: currentRow.count - 1)
                }
            }
            
            if currentRow.count > 0 {
                for i in 0 ..< currentRow.count - 1 {
                    pattern += currentRow[i].toString() + ", "
                }
                pattern += currentRow[currentRow.count - 1].toString()
            }
            
            return "ROW: " + pattern
        }
        
        func getCurrentGroupPattern() -> String {
            var groupPattern = "("//currentGroup.count == 1 ? "" : "("
            
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
            return groupPattern + ") x\(selectedRepeat)" //(currentGroup.count == 1 ? "" : ") x\(selectedRepeat)")
        }
    }
}
