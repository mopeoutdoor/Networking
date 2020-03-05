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
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        
        JsonData.shared.fetchElephants { (jsonData) in
            AppController.shared.elephants = jsonData
            self.elephantsBySpecies = AppController.shared.fetchElephantsBySpecies()
            self.sectionById = AppController.shared.speciesDic()
            self.tableView.reloadData()
        }
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
        let someElephant = AppController.shared.elephantsDic(speciesName: someSpecies)[indexPath.row]!
        cell.configure(with: someElephant)
        
        return cell
    }

   override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionById[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let someSpecies = sectionById[indexPath.section]!
        let someElephant = AppController.shared.elephantsDic(speciesName: someSpecies)[indexPath.row]!
        performSegue(withIdentifier: "ToDetail", sender: someElephant)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.elephant = sender as? Elephant
    }
    

}
