//
//  PropertyCollectionViewCell.swift
//  PR DRS
//
//  Created by xr on 5/2/18.
//  Copyright © 2018 Dusan. All rights reserved.
//

import UIKit

class PropertyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var timestamp: UILabel!
    var item: PropertyItem?
    
    func initializeCell(propertyItem: PropertyItem) {
        self.photo.image = propertyItem.image
        self.timestamp.text = TextUtils.getTimeStamp(propertyItem.timestamp)
    }
}
