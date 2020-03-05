//
//  JsonData.swift
//  Networking
//
//  Created by Irina Kopchenova on 05.03.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//
import Alamofire

class JsonData {
    static var shared = JsonData()
    var elephants = [Elephant]()
    
    func fetchElephants(completionHandler: @escaping ([Elephant]) -> Void) {
        let jsonUrlElephants = "https://elephant-api.herokuapp.com/elephants"
        
        request(jsonUrlElephants).validate().responseJSON { dataResponse in
            switch dataResponse.result {
            case .success(let value):
                self.elephants = Elephant.getElephant(from: value) ?? []

                DispatchQueue.main.async {
                    completionHandler(self.elephants)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
