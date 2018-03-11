//
//  CaughtPokemonViewController.swift
//  Pokedex
//
//  Created by Angel Rodriguez on 3/10/18.
//  Copyright © 2018 angel. All rights reserved.
//

import UIKit

class CaughtPokemonViewController: UIViewController {

    @IBOutlet weak var caughtCollectionView: UICollectionView!
    var myDataPerssitence = DataPersitanceManager()
    var savedPokes:[Pokemon]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let nib = UINib(nibName: PokeCollectionViewCell.nibName, bundle: nil) //register nib
        caughtCollectionView.register(nib, forCellWithReuseIdentifier: PokeCollectionViewCell.nibName)
        
        let savedEntities = myDataPerssitence.retrieveAllPokemon()
        
        var pokes = [Pokemon]()
        
        for entity in savedEntities{
            
            if let pokemon = myDataPerssitence.convertToPokemonModel(pokeEntity: entity) {
                
                pokes.append(pokemon)
            }
            
        }
        
        savedPokes = pokes
     
        caughtCollectionView.reloadData()
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

extension CaughtPokemonViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = savedPokes?.count{
    
            return count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = caughtCollectionView.dequeueReusableCell(withReuseIdentifier: PokeCollectionViewCell.nibName, for: indexPath) as? PokeCollectionViewCell {
            let pokemon = savedPokes![indexPath.row]
        
            cell.populateCell(pokemon: pokemon)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

