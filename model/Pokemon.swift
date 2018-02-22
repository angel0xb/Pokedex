//
//  pokemon.swift
//  Pokedex
//
//  Created by MCS Devices on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation

struct Pokemon: Decodable{
    var id:Int
    var name:String
    var height:Int
    var weight:Int
    var types:String
    var sprites:[String:String]
    
}

