//
//  DataManager.swift
//  Networking
//
//  Created by Irina Kopchenova on 09.03.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

import Foundation

class DataManager {
    let elephantKey = "ElephantKey"
    let userDefauts = UserDefaults.standard
    static let shared = DataManager()
    
    func restoreElephants() -> [Elephant] {
        guard let data = userDefauts.object(forKey: elephantKey) as? Data else { print("Error access for ElephantKey"); return [] }
        guard let elephants = try? JSONDecoder().decode([Elephant].self, from: data) else { print("Error decode for ElephantKey"); return [] }
        return elephants
    }
    
    func saveElephants() {
        let elephants = AppController.shared.elephants
        guard let data = try? JSONEncoder().encode(elephants) else { print("Error encode [Elephant]"); return }
        userDefauts.set(data, forKey: elephantKey)
    }
    
    func removeElephant(at index: Int) {
        var elephants = restoreElephants()
        elephants.remove(at: index)
        saveElephants()
    }
}
