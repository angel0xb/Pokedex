//
//  PokedexViewController.swift
//  Pokedex
//
//  Created on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()//cache used to store images

class PokedexViewController: UIViewController {

    @IBOutlet weak var pokedexCollectionView: UICollectionView!//view used to display Pokemon
    var myNetworkManager: NetworkManager?//Network Manager used to make requests
    
    @IBAction func nextPage(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: PokeCollectionViewCell.nibName, bundle: nil) //register nib
        pokedexCollectionView.register(nib, forCellWithReuseIdentifier: PokeCollectionViewCell.nibName)
        
        myNetworkManager = NetworkManager()//initialize NetowrkManager
        myNetworkManager?.delegate = self//set Deleagte
        myNetworkManager?.downloadPokemon(url:"https://pokeapi.co/api/v2/pokemon/")//make Request using URL
        
        
//        pokedexCollectionView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation
/*
     segue used to display Pokemon information
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let pokeVC = segue.destination as? PokeViewController, let indexPath = pokedexCollectionView.indexPathsForSelectedItems?.first { // safely get PokeViewController set indexpath using selected cell
            
            //Safely use cell with indexPath to set image and Pokemon object
            if let cell = pokedexCollectionView.cellForItem(at: indexPath) as? PokeCollectionViewCell {
                
                pokeVC.image = cell.pokeImage.image
                pokeVC.pokemon = cell.poke
                
                
//                if let pokes = myNetworkManager?.pokemons {
//                    let pokemon = pokes[indexPath.row]
//                    pokeVC.pokemon = pokemon
//                    guard let sprite = pokemon.sprites["front_default"] else{return}
//                    if let sprite = sprite{
//                        if let image = imageCache.object(forKey: sprite as AnyObject) {
//                             pokeVC.image = image as? UIImage
//                        }
//                    }
//                }
                
                
            }
        }
    }
}

extension PokedexViewController: NetworkManagerDelegate{
    func didDownloadRequest() {
        DispatchQueue.main.async {
            self.pokedexCollectionView.reloadData()
        }
    }
}

extension PokedexViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let pokes = myNetworkManager?.pokemons{
            return pokes.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = pokedexCollectionView.dequeueReusableCell(withReuseIdentifier: PokeCollectionViewCell.nibName, for: indexPath) as? PokeCollectionViewCell, let pokemon = myNetworkManager?.pokemons![indexPath.row] {
            
            cell.populateCell(pokemon: pokemon)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension PokedexViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPokemon", sender: self)
    }
}
