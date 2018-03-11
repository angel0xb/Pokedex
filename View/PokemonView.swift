//
//  PokemonView.swift
//  Pokedex
//
//  Created by Angel Rodriguez on 3/11/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable

class PokemonView: UIView {
    

    static let nibName = "PokemonView"
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    @IBOutlet weak var flavorTextView: UITextView!
    
    

    override init(frame: CGRect) {

        super.init(frame: frame)
        
        customInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
    
        super.init(coder: aDecoder)
        
        customInit()
    }
    

    
    private func customInit() {
        Bundle.main.loadNibNamed("PokemonView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
    }
    

    
//    override func prepareForInterfaceBuilder() {
//        super.prepareForInterfaceBuilder()
////        setUpUIElements()
//        customInit()
//        contentView.prepareForInterfaceBuilder()
//    }
}
