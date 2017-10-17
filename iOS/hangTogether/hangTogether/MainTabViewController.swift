//
//  MainTabViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 17..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    enum TabType: Int {
        case Tab1 = 0, Tab2, Tab3, Tab4
        struct Attribute {
            let selectedImage: UIImage
            let normalImage: UIImage
        }
        
        var attribute: Attribute? {
            switch self {
            case .Tab1:
                return Attribute(selectedImage: #imageLiteral(resourceName: "tab1Main"), normalImage: #imageLiteral(resourceName: "tab1Main"))
            case .Tab2:
                return Attribute(selectedImage: #imageLiteral(resourceName: "tab2Travel"), normalImage: #imageLiteral(resourceName: "tab2Travel"))
            case .Tab3:
                return Attribute(selectedImage: #imageLiteral(resourceName: "tab3Message"), normalImage: #imageLiteral(resourceName: "tab3Message"))
            case .Tab4:
                return Attribute(selectedImage: #imageLiteral(resourceName: "tab4Mypage"), normalImage: #imageLiteral(resourceName: "tab4Mypage"))
            default:
                return nil
            }
        }
    }
    
    var tabButtonArray: [UIButton] = []
    lazy var buttonWidth: CGFloat = {
        return self.tabBar.frame.width/4
    }()
    lazy var buttonHeight: CGFloat = {
        return self.tabBar.frame.height
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isHidden = true
        self.tabBar.backgroundImage = #imageLiteral(resourceName: "tabBackgroud")
        
        for i in 0..<4 {
            let button = makeButton(tag: i)
            tabButtonArray.append(button)
            tabBar.addSubview(button)
        }
    }
    
    func makeButton(tag: Int) -> UIButton {
        let x = CGFloat(tag) * buttonWidth
        let button = UIButton()
        button.frame = CGRect(x: x, y: 0, width: buttonWidth, height: buttonHeight)
        button.setImage(TabType(rawValue: tag)?.attribute?.normalImage , for: UIControlState.normal)
        button.setImage(TabType(rawValue: tag)?.attribute?.selectedImage , for: UIControlState.selected)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.center
        button.tag = tag
        button.addTarget(self, action: #selector(clickTab), for: UIControlEvents.touchUpInside)
        return button
    }
    
    func clickTab(button: UIButton) {
        let tag = button.tag
        if tag == 2 || tag == 3 {
            if UserDefaults.standard.object(forKey: "userId") == nil {
                let title = tag == 2 ? "메세지 함" : "마이 페이지"
                let alert = UIAlertController.loginAlert(title: title)
                present(alert, animated: true, completion: nil)
                return
            }
        }
        
        for btn in tabButtonArray {
            btn.isSelected = false
        }
        button.isSelected = true
        self.selectedIndex = tag
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
