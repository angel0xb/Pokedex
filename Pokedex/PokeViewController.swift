//
//  PokeViewController.swift
//  Pokedex
//
//  Created  on 2/21/18.
//  Copyright © 2018 angel. All rights reserved.
//

import UIKit

class PokeViewController: UIViewController {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    @IBOutlet weak var flavorTextView: UITextView!
    
    var pokemon:Pokemon?
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let poke = pokemon{
            idLabel.text = "No. \(poke.id)"
            nameLabel.text = poke.name
            weightLabel.text = "Weight:\(poke.weight)lbs"
            heightLabel.text = "Height:\(poke.height)ft"
            type1Label.text = poke.types[0].type["name"]
            
            if poke.types.count > 1{
                if let type2 = poke.types[1].type["name"]{
                    type2Label.text = type2
                }
            } else {
                type2Label.text = ""
            }

            
            if let species = poke.pokeSpecies{
                var englishText = String()
                for flavorText in species.flavor_text_entries {
                    if flavorText.language.name == "en" {
                        englishText = flavorText.flavor_text
                        englishText = englishText.replacingOccurrences(of: "^\\n*", with: " ")//replace newlines with space
                    }
                }
                
                flavorTextView.text = englishText
            }
            
            pokeImage.image = image
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
