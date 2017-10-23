//
//  CountryViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 22..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    @IBOutlet var countryButton: [UIButton]!
    @IBOutlet var languageLabel: [paddingLabel]!
    @IBOutlet weak var languageSelectButton: UIButton!
    
    enum Country: Int {
        case Foreigner = 0, Korean
        struct Attribute {
            let selectedImage: UIImage
            let normalImage: UIImage
        }
        
        var attribute: Attribute? {
            switch self {
            case .Foreigner:
                return Attribute(selectedImage: #imageLiteral(resourceName: "foreignerSelect"), normalImage: #imageLiteral(resourceName: "foreignerUnselect"))
            case .Korean:
                return Attribute(selectedImage: #imageLiteral(resourceName: "koreanSelect"), normalImage: #imageLiteral(resourceName: "koreanUnselect"))
            default:
                return nil
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // navigation 설정
        let cancleButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        let joinButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(moveNext))
        
        navigationItem.leftBarButtonItem = cancleButton
        navigationItem.rightBarButtonItem = joinButton
        navigationItem.title = "회원가입"
        
        initButton()
    }
    
    func initButton() {
        countryButton[0].addTarget(self, action: #selector(selectCountry), for: .touchUpInside)
        countryButton[1].addTarget(self, action: #selector(selectCountry), for: .touchUpInside)
        
        for i in 0..<2 {
            countryButton[i].addTarget(self, action: #selector(selectCountry), for: .touchUpInside)
            countryButton[i].setBackgroundImage(Country(rawValue: i)?.attribute?.normalImage, for: UIControlState.normal)
            countryButton[i].setBackgroundImage(Country(rawValue: i)?.attribute?.selectedImage, for: UIControlState.selected)
        }
    }

    func dismissView(button: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func selectCountry(button: UIButton) {
        let tag = button.tag
        countryButton[tag].isSelected = true
        countryButton[1 - tag].isSelected = false
    }
    
    func moveNext(button: UIBarButtonItem) {
        let joinViewController = UIStoryboard.joinStoryboard.instantiateViewController(withIdentifier: "join") as! JoinViewController
        navigationController?.pushViewController(joinViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
