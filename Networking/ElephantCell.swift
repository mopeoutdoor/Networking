//
//  ElephantTableViewCell.swift
//  Networking
//
//  Created by Irina Kopchenova on 02.03.2020.
//  Copyright © 2020 Mikhail Scherbina. All rights reserved.
//

import UIKit

class ElephantCell: UITableViewCell {

    @IBOutlet weak var elephantImage: UIImageView!
    @IBOutlet weak var elephantName: UILabel!
    @IBOutlet weak var elephantDescription: UILabel!
    
    func configure(with elephant: Elephant) {
        elephantName.text = elephant.name
        elephantDescription.text = elephant.note
        DispatchQueue.global().async {
            guard let stringURL = elephant.image else { return }
            guard let imageURL = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: imageURL) else { return }
            
            DispatchQueue.main.async {
                self.elephantImage?.image = UIImage(data: imageData)
            }
        }
    }

}
