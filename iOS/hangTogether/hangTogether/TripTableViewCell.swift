//
//  TripTableViewCell.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 8..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class TripTableViewCell: UITableViewCell {
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var cancleButton: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        circleView.alpha = 0
        dateLabel.alpha = 0
    }
    
    override func prepareForReuse() {
        circleView.alpha = 0
        dateLabel.alpha = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)

        self.selectionStyle = UITableViewCellSelectionStyle.none
    }
    
    func deleteCancleButton() {
        cancleButton.alpha = 0
    }
    
    func makeFirstView(date: String?) {
        dateLabel.alpha = 1
        if let dateStr = date?.monthDay {
            dateLabel.text = dateStr
        }else {
            dateLabel.text = "무관"
        }
        dateLabel.textAlignment = .right
        
        circleView.alpha = 1
        circleView.layer.cornerRadius = circleView.frame.width / 2
        circleView.clipsToBounds = true
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
