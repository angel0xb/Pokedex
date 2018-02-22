//
//  pokemon.swift
//  Pokedex
//
//  Created on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation

struct Pokemon: Decodable{
    var id:Int
    var name:String
    var height:Int
    var weight:Int
    var sprites:[String:String?]
    var types:[Type]
    
    
}

