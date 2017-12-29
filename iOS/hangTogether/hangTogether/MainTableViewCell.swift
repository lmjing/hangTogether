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
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var userProfileStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func makeLanguages(languages: [String]) {
        for language in languages {
            let label = PaddingLabel()
            label.language(text: language)
            languageStackView.addArrangedSubview(label)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.selectionStyle = UITableViewCellSelectionStyle.none
        // Configure the view for the selected state
    }
}
