//
//  ElephantsTableViewController.swift
//  Networking
//
//  Created by Irina Kopchenova on 01.03.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

import UIKit

class ElephantsTableViewController: UITableViewController {
    var elephants = [Elephant]()
    private var elephantsBySpecies = [String: [Elephant]]()
    private var sectionById = [Int: String]()
    private var elephantsInSection = [Int: Elephant]()
    private let jsonUrlElephants = "https://elephant-api.herokuapp.com/elephants"
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        
        fetchElephants()
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionById.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let speciesName = sectionById[section]!
        return elephantsBySpecies[speciesName]!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ElephantCell
        let someSpecies = sectionById[indexPath.section]!
        elephantsDic(speciesName: someSpecies)
        let someElephant = elephantsInSection[indexPath.row]!
        cell.configure(with: someElephant)
        
        return cell
    }

   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionById[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let someSpecies = sectionById[indexPath.section]!
        elephantsDic(speciesName: someSpecies)
        let someElephant = elephantsInSection[indexPath.row]!
        performSegue(withIdentifier: "ToDetail", sender: someElephant)
    }
    
    func fetchElephants() {
        
        guard let url = URL(string: jsonUrlElephants) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                self.elephants = try decoder.decode([Elephant].self, from: data)
                
                DispatchQueue.main.async {
                    self.fetchElephantsBySpecies()
                    self.speciesDic()
                    self.tableView.reloadData()
                    self.activityIndicatorView.stopAnimating()
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
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.elephant = sender as? Elephant
    }
    

}
