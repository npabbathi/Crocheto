//
//  User.swift
//  Crocheto
//
//  Created by Nidhi Pabbathi on 11/29/23.
//

import Foundation

struct User: Identifiable, Codable {
    
    //vars
    let id: String
    let fullname: String
    let email: String
    
    var initals: String {
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        return ""
    }
}

extension User {
    static var MOCK_USER = User(id: NSUUID().uuidString, fullname: "MOCK USER", email: "MOCK.USER@EMAIL.COM")
}
