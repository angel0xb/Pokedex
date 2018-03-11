//
//  FlavorText.swift
//  Pokedex
//
//  Created by MCS Devices on 2/23/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation
struct FlavorText: Codable{
    var flavorText:String
    var language:Name
    
    enum CodingKeys : String, CodingKey {
        case language
        case flavorText = "flavor_text"
    }
}
