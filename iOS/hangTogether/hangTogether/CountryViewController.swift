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
    @IBOutlet weak var languagePickerView: UIView!
    @IBOutlet weak var languagePicker: UIPickerView!
    @IBOutlet var selectedLanguagesLabel: [PaddingLabel]!
    
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
            }
        }
    }
    
    var languages: [String] = []
    var selectedLanguages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Networking.getLanguages();
        NotificationCenter.default.addObserver(self, selector: #selector(getLanguages), name: Notification.Name.getLanguages, object: nil)

        // navigation 설정
        let cancleButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        let joinButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(moveNext))
        
        navigationItem.leftBarButtonItem = cancleButton
        navigationItem.rightBarButtonItem = joinButton
        navigationItem.title = "회원가입"
        
        languagePicker.delegate = self
        languagePicker.dataSource = self
        languagePickerView.isHidden = true
        initLanguageLabel()
    }
    
    func initLanguageLabel() {
        for i in 0..<3 {
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(deleteLanguage(_:)))
            selectedLanguagesLabel[i].isUserInteractionEnabled = true
            selectedLanguagesLabel[i].addGestureRecognizer(tap)
        }
    }
    
    func deleteLanguage(_ sender: AnyObject) {
        let tag = sender.view!.tag
        if selectedLanguages.count >= tag + 1 {
            let language = selectedLanguages[tag]
            let alert = UIAlertController.cancleOkAlert(title: language, message: "삭제하시겠습니까?", action: { _ in
                self.selectedLanguages.remove(at: tag)
                
                let count = self.selectedLanguages.count
                for i in 0..<count {
                    self.selectedLanguagesLabel[i].language(text: self.selectedLanguages[i])
                }
                for i in (count)..<3 {
                    self.selectedLanguagesLabel[i].notSelect()
                }
            })
            present(alert, animated: true, completion: nil)
        }
    }
    
    func getLanguages(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String:[String]] else { return }
        if let data = userInfo["languages"] {
            languages = data
            languagePicker.reloadAllComponents()
        }
    }
    
    func initCountryButton() {
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
    @IBAction func showLanguagePickerView(_ sender: Any) {
        if selectedLanguages.count >= 3 {
            let alert = UIAlertController.okAlert(title: nil, message: "최대 3개가지 설정 가능합니다.")
            present(alert, animated: true, completion: nil)
        }else {
            languagePickerView.isHidden = false
        }
    }
    
    @IBAction func pickerCancle(_ sender: Any) {
        languagePicker.selectRow(0, inComponent: 0, animated: false)
        languagePickerView.isHidden = true
    }
    
    @IBAction func pickerAdd(_ sender: Any) {
        let selected = languagePicker.selectedRow(inComponent: 0)
        let language = languages[selected]
        if !selectedLanguages.contains(language) {
            selectedLanguages.append(language)
            selectedLanguagesLabel[selectedLanguages.count - 1].language(text: language)
            
            languagePicker.selectRow(0, inComponent: 0, animated: false)
            languagePickerView.isHidden = true
        }else {
            let alert = UIAlertController.okAlert(title: nil, message: "이미 선택한 언어입니다.")
            present(alert, animated: true, completion: nil)
        }
    }
}

extension CountryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
}
