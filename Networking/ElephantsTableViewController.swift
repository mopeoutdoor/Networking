//
//  ElephantsTableViewController.swift
//  Networking
//
//  Created by Irina Kopchenova on 01.03.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

import UIKit

class ElephantsTableViewController: UITableViewController, AppControllerProtocol {
    var elephants = [Elephant]()
    private var elephantsBySpecies = [String: [Elephant]]()
    private var sectionById = [Int: String]()
    private var elephantsInSection = [Int: Elephant]()
    private let jsonUrlElephants = "https://elephant-api.herokuapp.com/elephants"
    //var someElephant: Elephant!
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(false)
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let appController = AppController.shared
//        appController.delegate = self
        fetchElephants()
        
        
//        AppController.shared.fetchElephants()
//        print("Elephant species \(AppController.shared.fetchElephantsBySpecies())")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        //return 1
        speciesDic()
        return sectionById.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return elephants.count
        let speciesName = sectionById[section]!
        return elephantsBySpecies[speciesName]!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //cell.textLabel?.text = elephants[indexPath.row].name
        let speciesName = sectionById[indexPath.section]!
        let elephantDic = elephantsBySpecies[speciesName]!
        let someElephant = elephantDic[indexPath.row]
        cell.textLabel?.text = someElephant.name ?? ""
        
        DispatchQueue.global().async {
            guard let stringURL = someElephant.image else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                cell.imageView?.image = UIImage(data: imageData)
            }
        }
        
        return cell
    }

   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionById[section]
    }
    
    func didUpdate(results: [Elephant]?) {
        print("Start didUpdate")
        if let act = results {
            DispatchQueue.main.async {
                //print(act)
                self.elephants = act
                self.tableView.reloadData()
            }
        } else {
            print("No results from fetchElephants")
        }
    }
    
    func fetchElephants() {
        
        guard let url = URL(string: jsonUrlElephants) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                self.elephants = try decoder.decode([Elephant].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
            }.resume()
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
        fetchElephantsBySpecies()
        var index = 0
        let species = elephantsBySpecies.map { $0.0 } .sorted(by: < )
        for item in species {
            sectionById[index] = item
            index += 1
        }
    }
    
    // Создаем словарь слонов по конкретному виду
    func elephantsDic(seciesName: String) {
        if let someElephants = elephantsBySpecies[seciesName] {
            let sortedsomeElephants = someElephants.sorted(by: { ($0.name ?? "") < ($1.name ?? "") })
            var index = 0
            for item in sortedsomeElephants {
                elephantsInSection[index] = item
                index += 1
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
