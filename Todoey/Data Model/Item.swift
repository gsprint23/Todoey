//
//  Item.swift
//  Todoey
//
//  Created by Gina Sprint on 6/14/18.
//  Copyright © 2018 Gina Sprint. All rights reserved.
//

import Foundation

// don't have to name Item to match name of file but is good practice
class Item : Encodable, Decodable { // Encodable and Decodable are protocols
    // or replace Encodable, Decodable with just Codable -> Swift 4
    // all properties must be standard data types
    var title : String = ""
    var done : Bool = false

    
    
}
