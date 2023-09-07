//
//  Group.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 7/14/23.
//

import Foundation

public class Group : Identifiable {
    public var id : UUID
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
    
    public func toString() -> String {
        var groupPattern = "(" //groupStitches.count == 1 ? "" : "("
        
        var currentStreak = 1
        if groupStitches.count != 0 {
            for i in 0 ..< groupStitches.count - 1 {
                if (groupStitches[i].getName() != groupStitches[i + 1].getName()) {
                    if (currentStreak != 1) {
                        groupPattern += "\(groupStitches[i].getAbbreviation()) \(currentStreak), "
                    } else {
                        groupPattern += "\(groupStitches[i].getAbbreviation()), "
                    }
                    currentStreak = 1
                } else {
                    currentStreak += 1
                }
            }
            if (currentStreak != 1) {
                groupPattern += "\(groupStitches[groupStitches.count - 1].getAbbreviation()) \(currentStreak)"
            } else {
                groupPattern += "\(groupStitches[groupStitches.count - 1].getAbbreviation())"
            }
        }
        return groupPattern + ") x\(numRepeat)" //(groupStitches.count == 1 ? "" : ") x\(numRepeat)")
        
    }
    
    public func addStitch(stitch: Stitch, numRepeat: Int) {
        self.numRepeat += numRepeat
        groupStitches.append(stitch)
    }
    
    public func incRepeats(_ by: Int) {
        numRepeat += by
    }
    
    public func getStitches() -> [Stitch] {
        return groupStitches
    }
    
    public func getRepeats() -> Int {
        return numRepeat
    }
    
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
}
