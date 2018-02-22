//
//  PokedexViewController.swift
//  Pokedex
//
//  Created on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class PokedexViewController: UIViewController {

    @IBOutlet weak var pokedexCollectionView: UICollectionView!
    var myPokeArray = [Pokemon]()
    var offset = 20
    let myNetworkManager = NetworkManager()
    
    @IBAction func nextPage(_ sender: Any) {
        
        
        print(offset)
        print(myPokeArray.count)
//        myNetworkManager.delegate = self
        myNetworkManager.downloadPokemon(urlString:"https://pokeapi.co/api/v2/pokemon/?limit=1&offset=\(offset)")
        offset += 1
        DispatchQueue.main.async {
            self.pokedexCollectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: PokeCollectionViewCell.nibName, bundle: nil)
        pokedexCollectionView.register(nib, forCellWithReuseIdentifier: PokeCollectionViewCell.nibName)
        
        
        myNetworkManager.delegate = self
        myNetworkManager.downloadPokemon(urlString:"https://pokeapi.co/api/v2/pokemon/")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPokemon"{
            if let pokeVC = segue.destination as? PokeViewController, let indexPath = pokedexCollectionView.indexPathsForSelectedItems?.first{
                
                let poke = myPokeArray[indexPath.row]
                pokeVC.pokemon = poke
                
            }
                
        }
    }
        
    
}

extension PokedexViewController: NetworkManagerDelegate{
    func didDownloadPokemon(poke: Pokemon) {

        myPokeArray.append(poke)

        DispatchQueue.main.async{
            self.pokedexCollectionView.reloadData()
        }
    }
    
    
}

extension PokedexViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myPokeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pokedexCollectionView.dequeueReusableCell(withReuseIdentifier: PokeCollectionViewCell.nibName, for: indexPath) as! PokeCollectionViewCell
        let pokemon = myPokeArray[indexPath.row]
        
        cell.populateCell(pokemon: pokemon)
        
        return cell
    }
}

extension PokedexViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showPokemon", sender: self)
    }
}
