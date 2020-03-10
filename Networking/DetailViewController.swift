//
//  ViewController.swift
//  Networking
//
//  Created by Irina Kopchenova on 29.02.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var elephantImage: ImageView!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var dodLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    var elephant: Elephant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    func updateUI() {
        navigationItem.title = elephant.name ?? ""
        sexLabel.text = "Sex: \(elephant.sex ?? "")"
        dobLabel.text = "Day of Birthday: \(elephant.dob ?? "")"
        dodLabel.text = "Day of Death: \(elephant.dod ?? "")"
        descriptionText.text = elephant.note ?? ""
        elephantImage.fetchImage(for: elephant.image ?? "")
    }
}

