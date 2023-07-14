//
//  Row.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 6/26/23.
//

import Foundation


public class Row : Identifiable {
    public var id : UUID
    private var groups : [Group]
    
    init(groups : [Group]) {
        self.id = UUID()
        self.groups = groups
    }
    
    public func getStitches() -> [Group] {
        return groups
    }
    
    public func getPattern() -> String {
        var pattern = "WIP: "
        for group in groups {
            pattern += group.toString()
        }
        return pattern
    }
}
