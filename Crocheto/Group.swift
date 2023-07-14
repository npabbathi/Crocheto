//
//  Group.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 7/14/23.
//

import Foundation

public class Group : Identifiable {
    public var id : UUID
    private var stitches : [Stitch]
    
    init(stitches : [Stitch]) {
        self.id = UUID()
        self.stitches = stitches
    }
}
