//
//  Elephant.swift
//  Networking
//
//  Created by Irina Kopchenova on 29.02.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

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

//{"_id":"5cf1d0db3cfbe0fcbb6c4c93","index":1,"name":"Abul-Abbas","affiliation":"Charlemagne","species":"Asian","sex":"Male","fictional":"false","dob":"Unavailable","dod":"810","wikilink":"https://en.wikipedia.org/wiki/Abul-Abbas","image":"https://elephant-api.herokuapp.com/pictures/001.jpg","note":"An elephant given to Carolingian emperor Charlemagne by the Abbasid caliph Harun al-Rashid."}
