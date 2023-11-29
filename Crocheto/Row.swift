//
//  Row.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 6/26/23.
//

import Foundation


/// class that represents a row in the pattern, consists of a list of groups which are a list of stitches
public class Row : Identifiable {
    public var id : UUID
    private var groups : [Group]
    
    init(groups : [Group]) {
        self.id = UUID()
        self.groups = groups
    }
    
    
    /// getter method for the groups
    /// - Returns: array of groups
    public func getGroups() -> [Group] {
        return groups
    }
    
    /// returns the string version of the row, comma seperated and by groups's toString format
    /// - Returns: string version of the  row
    public func getPattern() -> String {
        var pattern = ""
        
        if (groups.count > 0) {
            for i in 0 ..< groups.count - 1 {
                pattern += groups[i].toString() + ", "
            }
            pattern += groups[groups.count - 1].toString()
        }
        
        return pattern
    }
}
