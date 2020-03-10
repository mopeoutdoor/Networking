import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


struct Elephant: Codable, Equatable {
    let name: String?
    let species: String?
    let sex: String?
    let dob: String?
    let dod: String?
    let wikilink: String?
    let image: String?
    let note: String?
    
    init(elephant: [String: Any]) {
        name = elephant["name"] as? String
        species = elephant["species"] as? String
        sex = elephant["sex"] as? String
        dob = elephant["dob"] as? String
        dod = elephant["dod"] as? String
        wikilink = elephant["wikilink"] as? String
        image = elephant["image"] as? String
        note = elephant["note"] as? String
    }
    
    static func getElephant(from jsonData: Any) -> [Elephant]? {
        guard let elephantsDic = jsonData as? Array<[String:Any]> else { return nil}
        return elephantsDic.compactMap { Elephant.init(elephant: $0) }
    }
    
    public static func == (lhs: Elephant, rhs: Elephant) -> Bool {
        if lhs.name == rhs.name && lhs.species == rhs.species { return true }
        return false
    }
}

let elephant1 = Elephant(elephant: ["name": "Ivan", "species": "African"])
let elephant2 = Elephant(elephant: ["name": "Bolvan", "species": "Asian"])
let elephants = [elephant1, elephant2]
if let index = elephants.firstIndex(where: { $0 == elephant2}) {
    print("Find index \(index)")
}
