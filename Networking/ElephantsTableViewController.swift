//
//  ElephantsTableViewController.swift
//  Networking
//
//  Created by Irina Kopchenova on 01.03.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

import UIKit

class ElephantsTableViewController: UITableViewController {
    //var elephants = [Elephant]()
    private var elephantsBySpecies = [String: [Elephant]]()
    private var sectionById = [Int: String]()
    private var elephantsInSection = [Int: Elephant]()
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = activityIndicatorView
        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.startAnimating()
        
        let restoreElephants = DataManager.shared.restoreElephants()
        
        if restoreElephants.isEmpty {
            JsonData.shared.fetchElephants { (jsonData) in
                AppController.shared.elephants = jsonData
                self.elephantsBySpecies = AppController.shared.fetchElephantsBySpecies()
                self.sectionById = AppController.shared.speciesDic()
                print("Load elephants from network")
                self.tableView.reloadData()
            }
        } else {
            print("Load elephants from UserDefaults")
            AppController.shared.elephants = restoreElephants
            elephantsBySpecies = AppController.shared.fetchElephantsBySpecies()
            sectionById = AppController.shared.speciesDic()
            tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let someSpecies = sectionById[indexPath.section]!
            let someElephant = AppController.shared.elephantsDic(speciesName: someSpecies)[indexPath.row]!
            AppController.shared.removeElephant(elephant: someElephant)
            elephantsBySpecies = AppController.shared.fetchElephantsBySpecies()
            sectionById = AppController.shared.speciesDic()
            
            if elephantsBySpecies[someSpecies] == nil {
                let indexSet = IndexSet(arrayLiteral: indexPath.section)
                tableView.deleteSections(indexSet, with: .left)
            } else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
        }
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.elephant = sender as? Elephant
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        DataManager.shared.saveElephants()
    }
    
}
