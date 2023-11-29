//
//  PatternBuilder-ViewModel.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 9/6/23.
//

import Foundation

extension PatternBuilder {
    @MainActor class ViewModel: ObservableObject {
        //TODO: encapsulation bad rn, but these need to be read and write for the pickers?? how to make them private except for PatternBuilder?
        @Published var selectedStitchType = "Chain"
        @Published var selectedNumStitches = 1
        @Published var selectedRepeat = 1
        @Published var grouped = false
        
        @Published private(set) var rows = [Row]()
        
        @Published private(set) var currentRow = [Group]()
        @Published private(set) var currentGroup = [Stitch]()
        
        static let stitchTypeAbbreviations = ["Single Crochet" : "sc",
                                              "Double Crochet" : "dc",
                                              "Chain" : "ch",
                                              "Increase" : "inc",
                                              "Decrease" : "dec",
                                              "Magic Ring" : "mr",
                                              "Half Double Crochet" : "hdc",
                                              "Triple crochet" : "tc",
                                              "Bubble" : "bub"]
        
        /// Function to add the user's current working row to the list of total final rows
        func addRow() {
            if currentRow.count != 0 {
                rows.append(Row(groups: currentRow))
                currentRow = [Group]()
            }
        }
        
        /// Function to add the user's current working group of stitches to their current working row
        func addGroup() {
            if currentGroup.count != 0 {
                currentRow.append(Group(groupStitchs: currentGroup, numRepeat: selectedRepeat))
                
                //combines last groups if they are the same
                if (currentRow.count > 1) {
                    if (currentRow[currentRow.count - 1].equalStitches(other: currentRow[currentRow.count - 2])) {
                        //increases repeat
                        currentRow[currentRow.count - 2].incRepeats(currentRow[currentRow.count - 1].getRepeats())
                        currentRow.remove(at: currentRow.count - 1)
                    }
                }
                
                currentGroup = [Stitch]()
                grouped.toggle()
            }
        }
        
        /// Function to add the user's current number of stitches their current working row
        func addStitch() {
            for _ in 0 ..< selectedNumStitches {
                currentGroup.append(Stitch(name: selectedStitchType, abbreviation: PatternBuilder.ViewModel.stitchTypeAbbreviations[selectedStitchType] ?? "??"))
                
                //if not editing a group, add faux groups (stitches)
                if !grouped {
                    currentRow.append(Group(groupStitchs: currentGroup, numRepeat: 1))
                    currentGroup = [Stitch]()
                }
            }
            
            // combines the last stitches if they are the same
            if currentRow.count > 1 {
                if currentRow[currentRow.count - 1].equalStitches(other: currentRow[currentRow.count - 2]) {
                    //increases repeat
                    currentRow[currentRow.count - 2].incRepeats(currentRow[currentRow.count - 1].getRepeats())
                    currentRow.remove(at: currentRow.count - 1)
                }
            }
        }
        
        /// Function to get the current  row pattern the user is working on
        /// - Returns: String representation of the current row
        func getCurrentRowPattern() -> String {
            var pattern = ""
            
            if currentRow.count > 0 {
                for i in 0 ..< currentRow.count - 1 {
                    pattern += currentRow[i].toString() + ", "
                }
                pattern += currentRow[currentRow.count - 1].toString()
            }
            
            return "ROW: " + pattern
        }
        
        
        /// Function that returns a String version of the current Group pattern, used if the grouped toggle is turned on
        /// - Returns: String representation of the current Group
        func getCurrentGroupPattern() -> String {
            //TODO: icky?? unnecessary objects! change this up
            return Group(groupStitchs: currentGroup, numRepeat: selectedRepeat).toString()
        }
        
        
        /// remove the last stitch in the current working row
        func removeStitch() {
            //remove from working group if user is editing a group
            if (grouped && currentGroup.count > 0) {
                currentGroup.removeLast();
                
            //remove from the current working row aka array of groups
            } else if (currentRow.count > 0) {
                let lastGroup = currentRow[currentRow.count - 1]
                
                //remove the last stitch in the group
                if (lastGroup.getStitches().count > 1) {
                    lastGroup.removeLastStitch()
                    
                //remove the entire group from row since it is empty
                } else if (lastGroup.getStitches().count == 1) {
                    currentRow.removeLast()
                }
            }
        }
        
        
        /// removed a row at a index
        /// - Parameter i: index to remove from
        func removeRow(_ i : Int) {
            rows.remove(at: i)
        }
    }
}
