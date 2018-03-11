//
//  PokeViewController.swift
//  Pokedex
//
//  Created  on 2/21/18.
//  Copyright © 2018 angel. All rights reserved.
//

import UIKit

class PokeViewController: UIViewController {

    var pokemon:Pokemon?
    var image:UIImage?
    @IBOutlet weak var pokeView: PokemonView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let poke = pokemon {
            
            pokeView.idLabel.text = "No. \(poke.id)"
            pokeView.nameLabel.text = poke.name
            pokeView.weightLabel.text = "Weight:\(poke.weight)lbs"
            pokeView.heightLabel.text = "Height:\(poke.height)ft"
            pokeView.type1Label.text = poke.types[0].type["name"]
            
            if poke.types.count > 1{
                
                if let type2 = poke.types[1].type["name"]{
                    
                    pokeView.type2Label.text = type2
                }
                
            } else {
                
                pokeView.type2Label.text = ""
            }
            
            
            if let species = poke.pokeSpecies{
                
                var englishText = String()
                for flavorText in species.flavorTextEntries {
                    
                    if flavorText.language.name == "en" {
                        
                        englishText = flavorText.flavorText
                    }
                }
                
                pokeView.flavorTextView.text = englishText.trimmingCharacters(in: CharacterSet.newlines)
            }
            
            pokeView.pokeImage.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
