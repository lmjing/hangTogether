//
//  TripTableViewCell.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 8..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    let dateLabel = UILabel()
    @IBOutlet weak var circleView: UIView!
    
    @IBOutlet weak var topLineView: UIView!
    
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var placeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        circleView.layer.cornerRadius = circleView.frame.width / 2
//        circleView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)

        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    func makeDateLabel(date: String) {
        dateLabel.removeFromSuperview()
        contentView.addSubview(dateLabel)
        dateLabel.text = date
        dateLabel.textAlignment = .right
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        let marginGuide = contentView.layoutMarginsGuide
        dateLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: placeLabel.leadingAnchor, constant: -21.5).isActive = true
    }

    func makeLine(index: IndexPath, count: IndexPath) {
        topLineView.alpha = 1; bottomLineView.alpha = 1
        // count 가 0,0인 경우 = 총 1개 : 라인을 생성하지 않는다.
        if count.equalTo(IndexPath(row: 0, section: 0)) {
            topLineView.alpha = 0
            bottomLineView.alpha = 0
        }
        // 첫번째인 경우 위의 부분은 없다.
        else if index.equalTo(IndexPath(row: 0, section: 0)) {
            topLineView.alpha = 0
        }
        // 마지막인 경우 아래의 부분은 없다.
        else if index.equalTo(count) {
            bottomLineView.alpha = 0
        }
    }
}
