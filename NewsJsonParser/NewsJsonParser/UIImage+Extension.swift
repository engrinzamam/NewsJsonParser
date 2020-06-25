//
//  UIImage+Extension.swift
//  NewsJsonParser
//
//  Created by engrInzamamulhaq on 25/06/2020.
//  Copyright © 2020 Inzamam ul haq. All rights reserved.
//

import Foundation
import UIKit


extension UIImageView {
    
    
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        let placeholderImage = UIImage(named:"placeholder")
        
        let cache = NSCache<NSString, UIImage>()
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard  let url = URL(string: urlString) else {
            completed(placeholderImage)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self, error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data,
                let image = UIImage(data: data) else {
                    completed(placeholderImage)
                    return
            }
            
            cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
}

