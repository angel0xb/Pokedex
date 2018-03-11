//
//  NetworkManagerService.swift
//  Pokedex
//
//  Created by MCS Devices on 2/23/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation

class NetworkManagerService {
    
    /*
     makes use of escaping closure to capture network request using URLSession
    convert string to URL
    Create request using URLSession
    capture data using escaping closure
    */
    func getRequest(urlString:String,completion: @escaping ((Data) -> Void)) {
        guard let url = URL(string:urlString) else { fatalError("Could not create URL")}
        
        URLSession.shared.dataTask(with: url) { (data,response,err) in
            guard let data = data else {return}
            
            completion(data)
            
            }.resume()
    }
}
