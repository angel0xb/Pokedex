//
//  PokeCollectionViewCell.swift
//  Pokedex
//
//  Created by MCS Devices on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import UIKit

class PokeCollectionViewCell: UICollectionViewCell {

    static let nibName = "PokeCollectionViewCell"
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
