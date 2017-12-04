//
//  MainTabViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 17..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

protocol focusToTabDelegate {
    func focusOn(_ tab: Int)
}

class MainTabViewController: UITabBarController, focusToTabDelegate {
    /*
     NOTE: 커스텀하게 만든 이유 : 기존의 방법을 사용하면 didSelect만 되어 로그인이 안 되있을 경우 이전 페이지로 돌아가는 코드를 짤 수 없다.
     하지만 이렇게 작성하면 페이지 이동 전에 예외처리를 할 수 있음
     그리고 이미지도 센터에 제대로 놓을 수 있다.
     */
    enum TabType: Int {
        case Tab1 = 0, Tab2, Tab3, Tab4
        struct Attribute {
            let selectedImage: UIImage
            let normalImage: UIImage
        }
        
        var attribute: Attribute? {
            switch self {
            case .Tab1:
                return Attribute(selectedImage: #imageLiteral(resourceName: "tab1MainSelect"), normalImage: #imageLiteral(resourceName: "tab1Main"))
            case .Tab2:
                return Attribute(selectedImage: #imageLiteral(resourceName: "tab2TravelSelect"), normalImage: #imageLiteral(resourceName: "tab2Travel"))
            case .Tab3:
                return Attribute(selectedImage: #imageLiteral(resourceName: "tab3MessageSelect"), normalImage: #imageLiteral(resourceName: "tab3Message"))
            case .Tab4:
                return Attribute(selectedImage: #imageLiteral(resourceName: "tab4MypageSelect"), normalImage: #imageLiteral(resourceName: "tab4Mypage"))
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
    
    @objc func clickTab(button: UIButton) {
        let tag = button.tag
        if tag == 2 || tag == 3 {
            if UserDefaults.standard.object(forKey: "user") == nil {
                let title = tag == 2 ? "메세지 함" : "마이 페이지"
                let alert = UIAlertController.loginAlert(title: title, vc: self, moveTab: tag)
                present(alert, animated: true, completion: nil)
                return
            }
        }
        focusOn(tag)
    }
    
    func focusOn(_ tab: Int) {
        for btn in tabButtonArray {
            btn.isSelected = false
        }
        tabButtonArray[tab].isSelected = true
        
        self.selectedIndex = tab
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
