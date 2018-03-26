//
//  PokeCollectionViewCell.swift
//  Pokedex
//
//  Created on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import UIKit
/*
 reusable Cell to display Pokemon
 */
class PokeCollectionViewCell: UICollectionViewCell {

    static let nibName = "PokeCollectionViewCell"// uses for reuse identifier
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    
    var poke:Pokemon?//used grab information once intialized
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    /*
     function uses Pokemon object to populate UI elements on Cell
     */
    
    func populateCell(pokemon:Pokemon){
        poke = pokemon//set poke attribute
        pokeImage.clipsToBounds = true
        
        idLabel.text = "\(pokemon.id)"
        nameLabel.text = pokemon.name
        
        guard let sprite = pokemon.sprites["front_default"] else{return}
        if let sprite = sprite{
           guard let url = URL(string:sprite) else{return}
        
            self.imageIndicator.startAnimating()

            pokeImage.loadImageUsingCacheWithUrl(url:url, completion: { //use UIImageView extension
                (success) in
                if success {
                    self.imageIndicator.stopAnimating()
                    self.imageIndicator.hidesWhenStopped = true
                }
            })
        }
    }
    
    func populateCell(pokemon:PokemonEntity) {
        
    }
//    func populateCellWithEntity(poke)
}
