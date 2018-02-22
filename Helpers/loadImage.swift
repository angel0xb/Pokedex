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
    
    func loadImageUsingCacheWithUrl(url : URL, completion: @escaping (_ success: Bool)->())
    {
        let urlString = url.absoluteString
        self.image = nil;
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject)  as? UIImage {
            self.image = cachedImage;
//            print("I have been already saved")
            completion(true)
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                completion(false)
            }
            DispatchQueue.main.async {
                if  let downloadedImage = UIImage(data: data!){
//                    print("Done")
                    imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                    self.image = downloadedImage
                    completion(true)
                }
                
            }
        }).resume()
    }
}

