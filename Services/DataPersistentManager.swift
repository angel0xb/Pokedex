//
//  DataPersistentManager.swift
//  Pokedex
//
//  Created by Angel Rodriguez on 3/9/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataPersitanceManager {
    
    var savedPokemon: [PokemonEntity]?
    var savedPokemonArray: [Pokemon]?
    var savedPokemonDicationary: [String : Bool]?
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //Used to get viewContext
    func getContext() -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    /*
     saves pokemon passed as parameter
     converts Pokmon to match entity
 */
    func storePokemon(pokemonInstance: Pokemon) {

        if findPokemon(id: pokemonInstance.id) == nil {
            
            let context = convertToEntity(pokemonInstance: pokemonInstance)
            
            do {
                try context.save()
                print("successfully saved post with id: \(pokemonInstance.id)")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                print("an error ocurred while saving post with id: \(pokemonInstance.id)")
            }
        } else {
            print("already saved ")
        }

    }
    
    func findPokemon(id: Int) -> Pokemon? {
        
        var pokemon: Pokemon?
        let context = getContext()
        let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
        
        do{
            let searchResults = try context.fetch(fetchRequest)
            
            for foundPoke in searchResults {
                
                pokemon = convertToPokemonModel(pokeEntity: foundPoke)
                
            }
            
        } catch let error {
            
            print("Error finding Pokemon with \(id): ", error)
        }
        
        return pokemon
    }
    
    func retrieveAllPokemon() /*-> [PokemonEntity] */{
        
        var pokemons = [PokemonEntity]()
        let context = getContext()
        let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        
        
        do{
            let searchResults = try context.fetch(fetchRequest)
            
            for foundPoke in searchResults {
                
                pokemons.append(foundPoke)
                
            }
            
        } catch let error {
            
            print("Error retrieving Pokemon: ", error)
        }
        
        
        savedPokemon = pokemons
        /*return pokemons*/
    }
    
    
    
    func deletePokemon(id: Int) {
        
        let context = getContext()
        let fetchRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        
        fetchRequest.predicate = NSPredicate(format: "id == %@", String(id))
        
        do {
            let searchResults = try context.fetch(fetchRequest)
            
            for pokemon in searchResults {
                
                context.delete(pokemon)
            }
            
        } catch let error {
            
            print("Error deleting Pokemon with id \(id): ", error)
        }
    }
    

    func savedEntitiesToModels() /*-> [Pokemon]? */{
        
        var pokemons = [Pokemon]()
        
        guard let entities = savedPokemon else { return }
        
        for entity in entities {
            
            if let poke = convertToPokemonModel(pokeEntity: entity) {
                
                pokemons.append(poke)
            }
            
        }
        
        
        if pokemons.count > 0 {
            
            savedPokemonArray = pokemons
        }
        
        /*return pokemons*/
    }
    
    /*
     takes in a Pokemon ID to use for predicate for fetch request
     looks at each entity from result
     if value for id key is nil set it to true
     ids not found in request will remain nil
     */
    func  getSavedDictionary(id: Int) /* -> [String : Bool]*/ {
        
        let context = getContext()
        let fecthRequest: NSFetchRequest<PokemonEntity> = PokemonEntity.fetchRequest()
        var pokemonDicationary = [String : Bool]() // Dicationary of pokemon ids match with a bool whether or not they have been saved already
        fecthRequest.predicate = NSPredicate(format: "id == %@", String(id))
        
        
        do {
            let searchResults = try context.fetch(fecthRequest)
            
            for entity in searchResults {
                if let id = entity.id{
                    
                    if pokemonDicationary[id] == nil {
                        
                        pokemonDicationary[id] = true
                        
                    }
                }

            }
        } catch let error {
            print("Error: ", error)
        }
        
        savedPokemonDicationary = pokemonDicationary
        /*return pokemonDicationary */
        
    }
    
    
    func convertToEntity(pokemonInstance: Pokemon) -> NSManagedObjectContext  {
        let context = getContext()
        let entity = PokemonEntity(context: context)
        entity.id = String(pokemonInstance.id)
        entity.name = String(pokemonInstance.name)
        entity.height = String(pokemonInstance.height)
        entity.weight = String(pokemonInstance.weight)
        entity.type1 = pokemonInstance.types[0].type["name"]

        if pokemonInstance.types.count > 1 {

            entity.type2 = pokemonInstance.types[1].type["name"]
        }

        if let sprite = pokemonInstance.sprites["front_default"] {

            entity.sprite = sprite
        }


        if let species = pokemonInstance.pokeSpecies {

            var englishText = String()
            for flavorText in species.flavorTextEntries {

                if flavorText.language.name == "en" {

                    englishText = flavorText.flavorText
                    englishText = englishText.replacingOccurrences(of: "^\\n*", with: " ")//
                }
            }

            entity.flavorText = englishText
        }

        return context
    }
    
    
    func convertToPokemonModel(pokeEntity: PokemonEntity) -> Pokemon? {
        
        if let id = pokeEntity.id, let height = pokeEntity.height, let weight = pokeEntity.weight, let name = pokeEntity.name, let sprite = pokeEntity.sprite, let flavorText = pokeEntity.flavorText, let type1 = pokeEntity.type1 {
            
            if let type2 = pokeEntity.type2{
                let pokemon = Pokemon(id: Int(id)!, name: name, height: Int(height)!, weight: Int(weight)!, sprites: ["front_default": sprite], types: [ Type(slot: 0, type: ["name" : type1]), Type(slot: 1, type: ["name" : type2]) ], species: Name(name: name, url: name ), pokeSpecies: PokemonSpecies(id: Int(id)!, name: name, flavorTextEntries: [FlavorText(flavorText: flavorText, language: Name(name: "en", url: ""))]))
                return pokemon
            }
            
            let pokemon = Pokemon(id: Int(id)!, name: name, height: Int(height)!, weight: Int(weight)!, sprites: ["front_default": sprite], types: [Type(slot: 0, type: ["name" : type1] )], species: Name(name: name, url: name ), pokeSpecies: PokemonSpecies(id: Int(id)!, name: name, flavorTextEntries: [FlavorText(flavorText: flavorText, language: Name(name: "en", url: ""))]))
            return pokemon
        }
        return nil
    }
}
