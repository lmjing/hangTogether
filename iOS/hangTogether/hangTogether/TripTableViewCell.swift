//
//  TripTableViewCell.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 8..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var placeCollectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)

        print("table touch")
    }

    func makeLine(index: Int, count: Int) {
        let line = UIView()
        contentView.addSubview(line)
        line.backgroundColor = UIColor.pointColor
        line.translatesAutoresizingMaskIntoConstraints = false
        line.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        line.widthAnchor.constraint(equalToConstant: 1.3).isActive = true
        
        switch index {
        case 0:
            line.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -(contentView.frame.height / 2)).isActive = true
            line.topAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true
        case count - 1:
            line.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -(contentView.frame.height / 2)).isActive = true
        default:
            line.heightAnchor.constraint(equalToConstant: self.frame.height).isActive = true
        }
        
    }
}
