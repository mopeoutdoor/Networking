//
//  ElephantTableViewCell.swift
//  Networking
//
//  Created by Irina Kopchenova on 02.03.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

import UIKit

class ElephantCell: UITableViewCell {
    
    @IBOutlet weak var elephantImage: ImageView!
    @IBOutlet weak var elephantName: UILabel!
    @IBOutlet weak var elephantDescription: UILabel!
    
    func configure(with elephant: Elephant) {
        elephantName.text = elephant.name
        elephantDescription.text = elephant.note
        self.elephantImage.fetchImage(for: elephant.image ?? "")
        
    }
    
}
