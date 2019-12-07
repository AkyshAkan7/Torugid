//
//  PlaceTableViewCell.swift
//  Tourgid
//
//  Created by Akan Akysh on 12/4/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeName: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(place: Place) {
        placeName.text = place.name
        placeImageView.image = place.image
    }
    
}
