//
//  AppController.swift
//  Networking
//
//  Created by Irina Kopchenova on 29.02.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

import Foundation

protocol AppControllerProtocol{
    func didUpdate(results: [Elephant]?)
}

class AppController {
    static let shared = AppController()
    private var elephantsBySpecies = [String: [Elephant]]()
    private var sectionById = [Int: String]()
    private var elephantsInSection = [Int: Elephant]()
    private let jsonUrlElephants = "https://elephant-api.herokuapp.com/elephants"
    private var elephants = [Elephant]()
    
    var delegate: AppControllerProtocol!
    
    // Получаем спиосок всех слонов
    func fetchElephants() {
       
        guard let url = URL(string: jsonUrlElephants) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let someResults = try decoder.decode([Elephant].self, from: data)
                
                DispatchQueue.main.async {
                    print("Received total \(someResults.count) elephants")
                    self.elephants = someResults
                    self.delegate?.didUpdate(results: someResults)
                }
                
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
    // Создаем словарь слонов по ключу species (вид)
    func fetchElephantsBySpecies() -> [String: [Elephant]] {
        for item in elephants {
            if let species = item.species {
            elephantsBySpecies[species, default: []].append(item)
            }
        }
        return elephantsBySpecies
    }
    
    // Проверяем наличие данных по слонам
    func checkFetchElephants() {
        if !elephantsBySpecies.isEmpty {
            fetchElephants()
        }
    }
    
    // Создаем словарь из ключей по разделам
    func speciesDic() -> [Int: String] {
        var index = 0
        checkFetchElephants()
        let species = elephantsBySpecies.map { $0.0 } .sorted(by: < )
        for item in species {
            sectionById[index] = item
            index += 1
        }
        return sectionById
    }
    
    // Создаем словарь слонов по конкретному виду
    func elephantsDic(seciesName: String) -> [Int: Elephant] {
        checkFetchElephants()
        guard let someElephants = elephantsBySpecies[seciesName] else { return [:] }
        let sortedsomeElephants = someElephants.sorted(by: { ($0.name ?? "") < ($1.name ?? "") })
        var index = 0
        for item in sortedsomeElephants {
            elephantsInSection[index] = item
            index += 1
        }
        return elephantsInSection
    }
    
    //func printElephants
}
