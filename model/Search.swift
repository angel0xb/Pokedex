//
//  Search.swift
//  Pokedex
//
//  Created by MCS Devices on 2/22/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation
struct Search:Decodable {
//    var count:Int
    var previous:String?
    var results:[PokeResultModel]
    var next:String?
}
