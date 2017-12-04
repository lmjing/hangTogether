//
//  TabBarViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 16..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    let customTabBarView = UIView()
    let tabButton1 = UIButton()
    let tabButton2 = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isHidden = true

        customTabBarView.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 70)
        customTabBarView.backgroundColor = UIColor.white
        
        let buttonWidth = self.tabBar.frame.width/2
        let buttonHeight = self.customTabBarView.frame.height
        
        tabButton1.frame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
        tabButton2.frame = CGRect(x: buttonWidth, y: 0, width: buttonWidth, height: buttonHeight)
        
        initButton(button: tabButton1, title: "메세지함", tag: 0)
        initButton(button: tabButton2, title: "알림함", tag: 1)
        
        self.view.addSubview(customTabBarView)
        tabButton1.isSelected = true
    }
    
    func initButton(button: UIButton, title: String, tag: Int) {
        button.setTitle(title, for: UIControlState.normal)
        button.setTitleShadowColor(UIColor.black, for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.setTitleColor(UIColor.black, for: UIControlState.selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "tabUnselect"), for: UIControlState.normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "tabSelect"), for: UIControlState.selected)
        
        button.tag = tag
        button.addTarget(self, action: #selector(clickTab), for: UIControlEvents.touchUpInside)
        self.customTabBarView.addSubview(button)
    }
    
    @objc func clickTab(button: UIButton) {
        self.tabButton1.isSelected = false
        self.tabButton2.isSelected = false
        
        button.isSelected = true
        
        self.selectedIndex = button.tag
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
