//
//  NetworkManager.swift
//  Pokedex
//
//  Created on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation

final class NetworkManager: NetworkManagerService{
    weak var delegate:NetworkManagerDelegate?
    var pokemons:[Pokemon]? //used to store sorted [Pokemon]
    
    func downloadPokemon(url: String ) {
        getRequest(urlString:url , completion: ({(data:Data) in
            
            do{
                let search = try JSONDecoder().decode(Search.self, from: data)
                let results = search.results
                
                var pokeURLs = [String]()
                
                for pokeInfo in results {
                    let pokeURL = pokeInfo.url
                    pokeURLs.append(pokeURL)
                }
                
                
                DispatchQueue.main.async {
                    
                    self.getPokemons(urls: pokeURLs, completion: ({ (pokeResults) in
                        print("retrieving pokemon")
                        let pokeResultsSorted = pokeResults.sorted(by: {($0.id < ($1.id))})

                        self.pokemons = pokeResultsSorted

                        self.delegate?.didDownloadRequest()
                    }))
          
                }
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
        }))
    }
    
    
    func getPokemon(url:String, completion: @escaping (Pokemon) -> Void) {
        let group = DispatchGroup()
        
        getRequest(urlString: url, completion: ({ (data:Data) in
            do {
                
                var pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                group.enter()
                self.getSpecies(request: pokemon.species.url, completion: { (pSpecies) in
                    print("setting species")
                    pokemon.pokeSpecies = pSpecies
                    group.leave()
                    
                })
                
                group.notify(queue: .main, execute: {
                    completion(pokemon)

                    })
    
            } catch let jsonError {

                print("Error serializing json:", jsonError)
            }

        }))
        
    }
    
    
    func getPokemons(urls: [String], completion: @escaping (([Pokemon]) -> Void)) {
        let group = DispatchGroup()
        var pokes = [Pokemon]()
        for url in urls {
            group.enter()
            getPokemon(url: url, completion: { (pokemon) in
                pokes.append(pokemon)
                group.leave()
            })
            
        }
        group.notify(queue: .main) {
            
            completion(pokes)
        }
        
    }
    
    


//    makes network request and parses it into a PokemonSpecies using JSONDecoder
    func getSpecies(request:String, completion: @escaping (PokemonSpecies) -> Void) {

        getRequest(urlString: request, completion: { (data) in
            do {
                let specie = try JSONDecoder().decode(PokemonSpecies.self, from: data)
                completion(specie)
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            
        })
        
    }
    
    func getRequstModel<T:Decodable>(urlRequest: String, completion: @escaping
        ((T) -> Void)) {
        getRequest(urlString: urlRequest, completion:  { (data) in
            do{
                let model = try JSONDecoder().decode(T.self, from: data)
                
                completion(model)
            } catch let jsonError {
                print("Error serializing json:", jsonError)
            }
        })
    }
    
}








