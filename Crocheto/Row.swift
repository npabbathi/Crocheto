//
//  Row.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 6/26/23.
//

import Foundation


public class Row : Identifiable {
    public var id : UUID
    private var stitches : [Stitch]
    
    init(stitches : [Stitch]) {
        self.id = UUID()
        self.stitches = stitches
    }
    
    public func getStitches() -> [Stitch] {
        return stitches
    }
    
    public func getPattern() -> String {
        var pattern = ""
        
        var currentStreak = 1
        if stitches.count != 0 {
            for i in 0 ..< stitches.count - 1 {
                if (stitches[i].getName() != stitches[i + 1].getName()) {
                    if (currentStreak != 1) {
                        pattern += "\(stitches[i].getAbbreviation()) \(currentStreak), "
                    } else {
                        pattern += "\(stitches[i].getAbbreviation()), "
                    }
                        currentStreak = 1
                } else {
                    currentStreak += 1
                }
            }
            if (currentStreak != 1) {
                pattern += "\(stitches[stitches.count - 1].getAbbreviation()) \(currentStreak)"
            } else {
                pattern += "\(stitches[stitches.count - 1].getAbbreviation())"
            }
        }
        return pattern
    }
}
