//
//  ImageView.swift
//  Networking
//
//  Created by Irina Kopchenova on 09.03.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

import UIKit

class ImageView: UIImageView {
    func fetchImage(for resourceURL: String) {
        guard let url = URL(string: resourceURL) else {
            image = #imageLiteral(resourceName: "elephant_placeholder")
            return
        }
        
        if let cachedImage = loadFromCache(for: url) {
            image = cachedImage
            return
        }
        
        NetworkManager.shared.getImage(from: url) { (data, response) in
            DispatchQueue.main.async {
                 self.image = UIImage(data: data) ?? #imageLiteral(resourceName: "elephant_placeholder")
            }
            self.saveToCache(with: data, and: response)
        }
        
    }
 
    // Load Image from Cache
    func loadFromCache(for url: URL) -> UIImage? {
        if let cacheResponse = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
            return UIImage(data: cacheResponse.data)
        }
        return nil
    }
    
    // Save Image to Cache
    func saveToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let cacheResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cacheResponse, for: URLRequest(url: url))
    }
}
