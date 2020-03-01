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
    //var someElephant: Elephant!
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(false)
//        
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appController = AppController.shared
        appController.delegate = self
        
        AppController.shared.fetchElephants()
        print("Elephant species \(AppController.shared.fetchElephantsBySpecies())")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //AppController.shared.speciesDic().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let speciesName = AppController.shared.speciesDic()[section]!
//        return AppController.shared.elephantsDic(seciesName: speciesName).count
        return elephants.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//        let speciesName = AppController.shared.speciesDic()[indexPath.section]!
//        let elephantDic = AppController.shared.elephantsDic(seciesName: speciesName)
//        cell.textLabel?.text = elephantDic[indexPath.row]?.name
        cell.textLabel?.text = elephants[indexPath.row].name
        return cell
    }

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return AppController.shared.speciesDic()[section]
//    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
