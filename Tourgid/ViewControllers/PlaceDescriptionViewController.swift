//
//  PlaceDescriptionViewController.swift
//  Tourgid
//
//  Created by Akan Akysh on 12/5/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

class PlaceDescriptionViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var place: Place!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue()
    }
    
    func setValue() {
        if place != nil {
            nameLabel.text = place.name
            descriptionLabel.text = place.description
            imageView.image = place.image
        }
    }

}
