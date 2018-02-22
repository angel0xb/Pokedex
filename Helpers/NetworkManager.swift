//
//  NetworkManager.swift
//  Pokedex
//
//  Created on 2/20/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation

final class NetworkManager{
    weak var delegate:NetworkManagerDelegate?
    
    
//    func downloadPokemon(urlString: String){
//
//        guard let url = URL(string:urlString) else{
//            return
//        }
//
//
//        URLSession.shared.dataTask(with: url) { (data, response, err) in
//            guard let data = data else{return}
//
//            guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else{return}
//
////            print(json)
//            let results = json["results"] as! [Any]
//
//            DispatchQueue.main.async {
//            var pokeURLS = [String]()
//            for pokeInfo in results{
//                let pokeInfoDict = pokeInfo as! [String:Any]
//                let pokeURL = pokeInfoDict["url"] as! String
//                pokeURLS.append(pokeURL)
//            }
//
//
//                do{
//                    var pokemons = [Pokemon]()
//
//                    self.getPokemon(urls: pokeURLS, completionHandler: ({(result:[Pokemon]) in
//
//                        pokemons = result.sorted {($0.id) < ($1.id)}
//                        for poke in pokemons{
//                            self.delegate?.didDownloadPokemon(poke: poke)
//                        }
//
//
//                    }))
//
//
//                } catch let jsonErr{
//                    print("Error serializing json:", jsonErr)
//                }
//            }
//
//            }.resume()
//    }
    
    
    func downloadPokemon(urlString: String){
        
        guard let url = URL(string:urlString) else{
            return
        }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            guard let data = data else{return}
            
            do{
                let search = try JSONDecoder().decode(Search.self, from: data)
                let results = search.results
                
                var pokeURLs = [String]()
                
                for pokeInfo in results{
                    let pokeURL = pokeInfo.url
                    pokeURLs.append(pokeURL)
                }
                
                var pokemons = [Pokemon]()
                
                self.getPokemon(urls: pokeURLs, completionHandler: ({(result:[Pokemon]) in
                    
//                    pokemons = result.sorted {($0.id) < ($1.id)}
//                    for poke in pokemons{
//                        self.delegate?.didDownloadPokemon(poke: poke)
//                    }
                    
                }))
                
            }catch let jsonErr{
                print("Error serializing json:", jsonErr)
            }
            
        }.resume()
    }
    
    
    func getPokemon(urls:[String], completionHandler: @escaping ([Pokemon]) ->Void) {

        var pokemons = [Pokemon]()
        for url in urls{
            guard let url = URL(string:url) else{return}
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                guard let data = data else{return}
                
                DispatchQueue.main.async {
                    do{
                        
                        
                        let poke = try JSONDecoder().decode(Pokemon.self, from: data)
                        
                        
                        pokemons.append(poke)
//                        pokemons = pokemons.sorted {($0.id) < ($1.id)}
//                        
//                        for poke in pokemons{
//                            self.delegate?.didDownloadPokemon(poke: poke)
//                        }
                        if pokemons.count == urls.count{
                            pokemons = pokemons.sorted {($0.id) < ($1.id)}
                            for poke in pokemons{
                                self.delegate?.didDownloadPokemon(poke: poke)
                            }

                            completionHandler(pokemons)
                        }
                        
                        
                    } catch let jsonErr{
                        print("Error serializing json:", jsonErr)
                    }
                }
 
                
                }.resume()
        }

    }
}
