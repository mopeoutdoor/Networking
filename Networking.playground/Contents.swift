import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


struct Elephant: Codable {
    let _id: String?
    let index: Int?
    let name: String?
    let species: String?
    let sex: String?
    let fictional: String?
    let dob: String?
    let dod: String?
    let wikilink: String?
    let image: String?
    let note: String?
}

class AppController {
    static let shared = AppController()
    private var elephantsBySpecies = [String: [Elephant]]()
    private var sectionById = [Int: String]()
    private var elephantsInSection = [Int: Elephant]()
    private let jsonUrlElephants = "https://elephant-api.herokuapp.com/elephants"
    private var elephants: [Elephant] = []
    
    //var delegate: AppControllerDelegate?
    
    // Получаем спиосок всех слонов
    func fetchElephants() {
        
        guard let url = URL(string: jsonUrlElephants) else { return }
        print("url string converted to URL")
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                self.elephants = try decoder.decode([Elephant].self, from: data)
                //self.courses = try decoder.decode([Course].self, from: data)
                
                DispatchQueue.main.async {
                    //self.fetchElephantsBySpecies()
                    //self.speciesDic()
                    print(self.elephants)
                    //print(self.elephantsDic(speciesName: "Asian"))
                }
                
                //self.delegate?.didUpdate()
            } catch let error {
                print(error)
            }
            
            }.resume()
        
        DispatchQueue.main.async {
            print(self.elephants)
        }

    }
    // Создаем словарь слонов по ключу species (вид)
    func fetchElephantsBySpecies() {
        for item in elephants {
            if let species = item.species {
                elephantsBySpecies[species, default: []].append(item)
            }
        }
    }
    
    // Создаем словарь из ключей по разделам
    func speciesDic() {
        //        fetchElephantsBySpecies()
        var index = 0
        let species = elephantsBySpecies.map { $0.0 } .sorted(by: < )
        for item in species {
            sectionById[index] = item
            index += 1
        }
    }
    
    // Создаем словарь слонов по конкретному виду
    func elephantsDic(speciesName: String) {
        if let someElephants = elephantsBySpecies[speciesName] {
            let sortedsomeElephants = someElephants.sorted(by: { ($0.name ?? "") < ($1.name ?? "") })
            var index = 0
            for item in sortedsomeElephants {
                elephantsInSection[index] = item
                index += 1
            }
        }
    }
    func printElephants() {
        fetchElephants()
        print(elephants)
    }
}

AppController.shared.fetchElephants()

