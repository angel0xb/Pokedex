//
//  PokemonSpecies.swift
//  Pokedex
//
//  Created by MCS Devices on 2/22/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation
struct PokemonSpecies:Codable {
    var id:Int
    var name:String
    var flavor_text_entries:[FlavorText]
}
