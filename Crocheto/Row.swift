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
}
