//
//  Group.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 7/14/23.
//

import Foundation


/// class that represnts a group of stitches that repeat a certian number of times
public class Group : Identifiable {
    public let id : UUID
    private var groupStitches : [Stitch]
    private var numRepeat : Int
    
    init(groupStitchs : [Stitch], numRepeat : Int) {
        self.id = UUID()
        self.groupStitches = groupStitchs
        self.numRepeat = numRepeat
    }
    
    init() {
        self.id = UUID()
        self.groupStitches = [Stitch]()
        self.numRepeat = 0
    }
    
    /// string version of the current group, condensed to have stitches that are the same that are right next to eachother shown in multiples
    /// - Returns: string version of the current group
    public func toString() -> String {
        var groupPattern = "("
        var currentStreak = 1
        
        //if there are stitches in the group that need to be condensed
        if groupStitches.count != 0 {
            
            //fencepost looping
            for i in 0 ..< groupStitches.count - 1 {
                if (groupStitches[i].getName() != groupStitches[i + 1].getName()) {
                    groupPattern += stitchCombo(i, currentStreak: currentStreak, withComma: true)
                    currentStreak = 1
                } else {
                    currentStreak += 1
                }
            }
            
            //edgecase, check if there was a streak at the very end of the stitches
            groupPattern += stitchCombo(groupStitches.count - 1, currentStreak: currentStreak, withComma: false)
        }
        
        return groupPattern + ") x\(numRepeat)"
    }
    
    
    /// helper method to return the streak of stitches
    /// - Parameters:
    ///   - index: index in groupStitches to get the abbreviation from
    ///   - currentStreak: number of times the stitch repeated
    ///   - withComma: fencepost comma for the last element in the list
    /// - Returns: string version of the squished current streak
    private func stitchCombo(_ index : Int, currentStreak : Int, withComma : Bool) -> String {
        return "\(groupStitches[index].getAbbreviation())" +
                (currentStreak != 1 ? " \(currentStreak)" : "") +
                (withComma ? ", " : "")
    }
    
    
    /// add stitch to be called in pattern builder view model for updating the current row
    /// - Parameters:
    ///   - stitch: stitch to be added
    ///   - numRepeat: number of times its repeated
    public func addStitch(stitch: Stitch, numRepeat: Int) {
        self.numRepeat += numRepeat
        groupStitches.append(stitch)
    }
    
    
    /// increase number of repeats for a group
    /// - Parameter by: number to increase repeat by
    public func incRepeats(_ by: Int) {
        numRepeat += by
    }
    
    /// getter method for groupStitches
    /// - Returns: array of stitches that consist the current group
    public func getStitches() -> [Stitch] {
        return groupStitches
    }
    
    /// get the number of times this group repeats
    /// - Returns: numRepeat
    public func getRepeats() -> Int {
        return numRepeat
    }
    
    
    /// equals method for if the internal stitches are the same
    /// - Parameter other: other group
    /// - Returns: bool if only the stitches in the group are the same, not including numRepeat
    public func equalStitches(other: Group) -> Bool {
        if groupStitches.count != other.groupStitches.count {
            return false
        }
        for i in 0 ..< groupStitches.count {
            if groupStitches[i] != other.groupStitches[i] {
                return false
            }
        }
        return true
    }
    
    
    /// remove the last stitch from the group
    public func removeLastStitch() {
        precondition(groupStitches.count > 0, "there must be at least one stitch to remove from the current group")
        
        groupStitches.removeLast()
    }
}
