//
//  UIImageView+Cache.swift
//  Foodie
//
//  Created by Hannie Kim on 12/29/21.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(from url: URL) {
        // reset image
        image = nil
        
        // set image to cached image
        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            self.image = cachedImage
            return
        }
        
        // request for a new image
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let downloadedImage = UIImage(data: data), error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                imageCache.setObject(downloadedImage, forKey: NSString(string: url.absoluteString))
                self.image = downloadedImage
            }
        }.resume()
    }
}
