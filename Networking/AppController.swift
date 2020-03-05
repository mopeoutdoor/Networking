//
//  AppController.swift
//  Networking
//
//  Created by Irina Kopchenova on 04.03.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//
import Foundation

class AppController {
    static let shared = AppController()
    var elephants = [Elephant]()
    private var elephantsBySpecies = [String: [Elephant]]()
    
    // Принимаем список слонов
    
    // Создаем словарь слонов по ключу species (вид)
    func fetchElephantsBySpecies() -> [String: [Elephant]] {
        for item in elephants {
            if let species = item.species {
                elephantsBySpecies[species, default: []].append(item)
            }
        }
        return elephantsBySpecies
    }
        
    // Создаем словарь из ключей по разделам
    func speciesDic() -> [Int: String] {
        var sectionById = [Int: String]()
        var index = 0
        let species = elephantsBySpecies.map { $0.0 } .sorted(by: < )
        for item in species {
            sectionById[index] = item
            index += 1
        }
        return sectionById
    }
    
    // Возвращаем словарь слонов по конкретному виду
    func elephantsDic(speciesName: String) -> [Int: Elephant] {
        var elephantsInSection = [Int: Elephant]()
        if let someElephants = elephantsBySpecies[speciesName] {
            let sortedsomeElephants = someElephants.sorted(by: { ($0.name ?? "") < ($1.name ?? "") })
            var index = 0
            for item in sortedsomeElephants {
                elephantsInSection[index] = item
                index += 1
            }
        }
        return elephantsInSection
    }
    
}

