//
//  NetworkManagerDelegate.swift
//  Pokedex
//
//  Created on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation

protocol NetworkManagerDelegate:class {
    func didDownloadPokemon(poke:Pokemon)
}
