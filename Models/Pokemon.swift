//
//  pokemon.swift
//  Pokedex
//
//  Created on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation

struct Pokemon: Codable{
    var id:Int
    var name:String
    var height:Int
    var weight:Int
    var sprites:[String:String?]
    var types:[Type]
    var species:Name
    var pokeSpecies:PokemonSpecies?
    
    enum CodingKeys : String, CodingKey {
        case id
        case name
        case height
        case weight
        case sprites
        case types
        case species
        case pokeSpecies = "poke_species"
    }
}


