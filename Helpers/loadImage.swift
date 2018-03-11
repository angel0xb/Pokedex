//
//  loadImage.swift
//  Pokedex
//
//  Created on 2/21/18.
//  Copyright © 2018 angel. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    /*
     escaping closure is used to get Bool on whether Image is loaded yet
     Bool is used to stop & hide UIActivityIndicatorView
     
     (1)uses urlString to check if an object with that key exists in Image cache
     (2)If Image exists in cache set image from cache
     (3)If image is not in cache make request using URLSession
     (4)Add image to cache and set Image
     
     
     */
    func loadImageUsingCacheWithUrl(url : URL, completion: @escaping (_ success: Bool)->())
    {
        let urlString = url.absoluteString
        self.image = nil;
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject)  as? UIImage {//(1)
            self.image = cachedImage;//(2)
//            print("I have been already saved")
            completion(true)
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in//(3)
            if error != nil {
                print(error!)
                completion(false)
            }
            DispatchQueue.main.async {
                if  let downloadedImage = UIImage(data: data!){
//                    print("Done")
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)//(4)
                    self.image = downloadedImage
                    completion(true)
                }
                
            }
        }).resume()
    }
}

