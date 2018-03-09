//
//  PokeCollectionViewCell.swift
//  Pokedex
//
//  Created on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {

    static let nibName = "PokeCollectionViewCell"
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var imageIndicator: UIActivityIndicatorView!
    
    var poke:Pokemon?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateCell(pokemon:Pokemon){
        poke = pokemon
        pokeImage.clipsToBounds = true
        
        idLabel.text = "\(pokemon.id)"
        nameLabel.text = pokemon.name
        
        guard let sprite = pokemon.sprites["front_default"] else{return}
        if let sprite = sprite{
           guard let url = URL(string:sprite) else{return}
        
        
            self.imageIndicator.startAnimating()
            
            pokeImage.loadImageUsingCacheWithUrl(url:url, completion: {
                (success) in
                if success {
                    self.imageIndicator.stopAnimating()
                }
            })
        }
    }
}
