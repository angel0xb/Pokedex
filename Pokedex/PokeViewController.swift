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
    
    var pokemon:Pokemon?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let poke = pokemon{
            idLabel.text = "\(poke.id)"
            nameLabel.text = poke.name
            weightLabel.text = "\(poke.weight)"
            heightLabel.text = "\(poke.height)"
            type1Label.text = poke.types[0].type["name"]
            
            if poke.types.count > 1{
                if let type2 = poke.types[1].type["name"]{
                    type2Label.text = type2
                }
            }

            
            DispatchQueue.main.async {
                guard let imageURL = poke.sprites["front_default"] as! String! else{return}
                guard let url = URL(string:imageURL) else{return}
                if let data = try? Data(contentsOf: url){
                    if let image: UIImage = UIImage(data: data){
                        self.pokeImage.image = image
                    }
                }
            }
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
