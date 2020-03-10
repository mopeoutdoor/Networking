//
//  NetworkManager.swift
//  Networking
//
//  Created by Irina Kopchenova on 09.03.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

import Foundation

class NetworkManager {
    static var shared = NetworkManager()
    
    func getImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error { print(error) }
            guard let data = data, let response = response else { return }
            guard let responseURL = response.url else { return }
            if responseURL.absoluteString != url.absoluteString { return }
            completion(data, response)
        }.resume()
    }
}
