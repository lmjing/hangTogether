//
//  TripPlaceTableViewCell.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 16..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class TripPlaceTableViewCell: UITableViewCell {
    @IBOutlet weak var placeNameLabel: UILabel!
    @IBOutlet weak var placeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
