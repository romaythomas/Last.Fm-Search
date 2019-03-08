//
//  ImageManager.swift
//  Last.Fm Search
//
//  Created by Owner on 07/03/2019.
//  Copyright © 2019 Thomas. All rights reserved.
//

import Foundation

import UIKit.UIImage



class ImageManger {
    
    static let shared = ImageManger()
    
    let imageCache: NSCache<NSString, UIImage>
    
    private init() { imageCache = NSCache<NSString, UIImage>() }
    
    
    func fetchImage(_ ImageUrl: String, completion: @escaping (UIImage) -> Void) {
        
        
        if let imageURL = URL(string: "\(ImageUrl)")
        {
            
            if let image = imageCache.object(forKey: imageURL.absoluteString as NSString) {
                
                
                completion(image)
                
            } else {
                
                
                let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                    
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let data = data, let image = UIImage(data: data) {
                        
                      
                        self.imageCache.setObject(image, forKey: imageURL.absoluteString as NSString)
              
                        
                        completion(image)
                    }
                }
                
                dataTask.resume()
            }
            
        }
        
    }
    
}

