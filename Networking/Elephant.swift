//
//  Elephant.swift
//  Networking
//
//  Created by Irina Kopchenova on 29.02.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

struct Elephant: Codable {
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
}
