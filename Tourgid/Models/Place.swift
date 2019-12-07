//
//  Place.swift
//  Tourgid
//
//  Created by Akan Akysh on 12/5/19.
//  Copyright © 2019 Akysh Akan. All rights reserved.
//

import UIKit

struct Place {
    var name: String
    var description: String
    var image: UIImage
    
    init(name: String, description: String, image: UIImage) {
        self.name = name
        self.description = description
        self.image = image
    }
}
