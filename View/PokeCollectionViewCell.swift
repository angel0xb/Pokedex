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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateCell(pokemon:Pokemon){
        
        pokeImage.clipsToBounds = true
        
        idLabel.text = "\(pokemon.id)"
        nameLabel.text = pokemon.name
        
        guard let imageURL = pokemon.sprites["front_default"] as! String! else{return}
        guard let url = URL(string:imageURL) else{return}
        
        self.imageIndicator.startAnimating()
        
        pokeImage.loadImageUsingCacheWithUrl(url:url, completion: {
            (success) in
            if success {
                self.imageIndicator.stopAnimating()
            }
        })
        
        
        
    }
}
