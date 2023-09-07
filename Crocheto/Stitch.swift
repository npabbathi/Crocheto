//
//  Stitch.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 6/26/23.
//

import Foundation

public class Stitch: Identifiable, Equatable {
    
    public var id : UUID?
    private var name : String
    private var abbreviation : String
    //private var color : String
    
    init(name : String, abbreviation : String) {
        self.id = UUID()
        self.name = name
        self.abbreviation = abbreviation
    }
    
    public func getName() -> String {
        return name
    }
    
    public func getAbbreviation() -> String {
        return abbreviation
    }
    
    public static func == (lhs: Stitch, rhs: Stitch) -> Bool {
        return lhs.name == rhs.name
    }
}
