//
//  MainTableViewCell.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 4..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var tripDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageStackView: UIStackView!
    @IBOutlet weak var userProfileStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.drawCircle()
    }
    
    func makeLanguages(languages: [String]) {
        for language in languages {
            let label = paddingLabel()
            label.backgroundColor = UIColor.pointColor
            label.textColor = UIColor.white
            label.font = UIFont.boldSystemFont(ofSize: 12)
            label.text = language
            label.textAlignment = .center
            languageStackView.addArrangedSubview(label)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = UITableViewCellSelectionStyle.none
        // Configure the view for the selected state
    }
}

class paddingLabel: UILabel {
    @IBInspectable var padding: UIEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    
    override func drawText(in rect: CGRect) {
        let paddingRect = UIEdgeInsetsInsetRect(rect, padding)
        super.drawText(in: paddingRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
}
