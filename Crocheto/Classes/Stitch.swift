//
//  Stitch.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 6/26/23.
//

import Foundation

/// class that represents a single stitch with information on how to represent it
public class Stitch: Identifiable, Equatable {
    
    public var id : UUID?
    private var name : String
    private var abbreviation : String
    
    /// Information for a stitch
    /// - Parameters:
    ///   - name: long version of the name of a stitch
    ///   - abbreviation: abbreviated version to show the short version of a name, i.e. single crochet's abbreviation would be sc
    init(name : String, abbreviation : String) {
        self.id = UUID()
        self.name = name
        self.abbreviation = abbreviation
    }
    
    
    /// function to get name instance variable
    /// - Returns: name
    public func getName() -> String {
        return name
    }
    
    /// function to get abbreviation instance variable
    /// - Returns: abbreviation
    public func getAbbreviation() -> String {
        return abbreviation
    }
    
    
    /// equals method
    /// - Parameters:
    ///   - lhs: lhs
    ///   - rhs: rhs
    /// - Returns: two stitches are the same if their names are the same
    public static func == (lhs: Stitch, rhs: Stitch) -> Bool {
        precondition(lhs.name == rhs.name && lhs.abbreviation == rhs.abbreviation || lhs.name != rhs.name && lhs.abbreviation != rhs.abbreviation, "iff the stitches are the same the name and abbreviations have to match, no other combinations")
        
        return lhs.name == rhs.name
    }
}
