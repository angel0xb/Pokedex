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
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //Used to get viewContext
    func getContext() -> NSManagedObjectContext {
        return appDelegate.persistentContainer.viewContext
    }
    
    
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
    
    func retrieveAllPokemon() -> [PokemonEntity] {
        
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
        return pokemons
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
