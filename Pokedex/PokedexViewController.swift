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
    var myNetworkManager = NetworkManager()//initialize NetowrkManager//Network Manager used to make requests
    var myDataManager = DataPersitanceManager()
    var myPokemonArray = [Pokemon]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: PokeCollectionViewCell.nibName, bundle: nil) //register nib
        pokedexCollectionView.register(nib, forCellWithReuseIdentifier: PokeCollectionViewCell.nibName)
        
        
        myNetworkManager.delegate = self//set Deleagte
        
        myNetworkManager.downloadPokemon(url:"https://pokeapi.co/api/v2/pokemon/")//make Request using URL
        
        
//        myNetworkManager.pokemonFromNetwork()
        
        
        
        myDataManager.retrieveAllPokemon()
        myDataManager.savedEntitiesToModels()
        
        
//        if let saved = myDataManager.savedPokemonArray { // if we have something stored populated the collectionView with this
//            
//            
//            print("got something saved")
//            if let pokes = myNetworkManager.pokemons { //store any pokemons that arent already saved
//                
//                for poke in pokes {
//                    
//                    myDataManager.storePokemon(pokemonInstance: poke)
//                }
//                
//            }
//            
//            myPokemonArray = saved
//            print(myPokemonArray)
//            
//            pokedexCollectionView.reloadData()
//            
//        } else { // there is nothing saved yet
//            
//            print("nothing saved")
//            if let pokemons  = myNetworkManager.pokemons {
//                
//                print(pokemons)
//                myPokemonArray = pokemons //display pokemon retrieved from NetworkManager
//                
//                for poke in pokemons {
//                    
//                    myDataManager.storePokemon(pokemonInstance: poke) //save all from request
//                }
//            }
//            
//        }
        
        print(myPokemonArray)
        
        myPokemonArray.sort(by: {($0.id > $1.id) })
        pokedexCollectionView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        

        
        
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
        if let pokes = myNetworkManager.pokemons{
            return pokes.count
        }
//        return 0
//        print(myPokemonArray.count)
        return myPokemonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = pokedexCollectionView.dequeueReusableCell(withReuseIdentifier: PokeCollectionViewCell.nibName, for: indexPath) as? PokeCollectionViewCell /*, let pokemons = myNetworkManager.pokemons */{
            
            let pokemon = myPokemonArray[indexPath.row]
//            let pokemon = pokemons[indexPath.row]
            
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
