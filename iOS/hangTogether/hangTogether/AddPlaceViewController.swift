//
//  AddPlaceViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 6..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class AddPlaceViewController: UIViewController {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var placeTextField: UITextField!
    
    var trip:[String:Any] = {
        var data:[String:Any] = [:]
        var place:[String:String] = [:]; data["place"] = place
        return data
    }()
    
    let datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()

        let okButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check"), style: .done, target: self, action: #selector(done))
        navigationItem.setRightBarButton(okButton, animated: true)
        navigationItem.title = "장소 추가"
        createDatePicker()
        
        dateSwitch.addTarget(self, action: #selector(checkDate), for: .valueChanged)
    }
    
    func checkDate() {
        if !dateSwitch.isOn {
            dateTextField.text = "무관"
            dateTextField.isEnabled = false
        }else {
            dateTextField.text = nil
            dateTextField.isEnabled = true
        }
    }
    
    func done(button: UIBarButtonItem) {
        if dateSwitch.isOn, let date = dateTextField.text, date != "" {
            trip["date"] = date
        }else if !dateSwitch.isOn {
            trip["date"] = nil
        }else {
            let dialog = UIAlertController.okAlert(title: nil, message: "날짜를 선택해주세요.")
            self.present(dialog, animated: true, completion: nil)
            return
        }

        if let place = placeTextField.text, place != "",
            var data = trip["place"] as? [String:String] {
            data["name"] = place
            trip["place"] = data
        }else {
            let dialog = UIAlertController.okAlert(title: nil, message: "장소를 입력해주세요.")
            self.present(dialog, animated: true, completion: nil)
            return
        }

        navigationController?.popViewController(animated: true)
        let cv = navigationController?.viewControllers.last as! WritePostViewController
        cv.tripList.append(trip)
    }
    
    func createDatePicker() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(pickerDone))
        toolbar.setItems([doneButton], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    func pickerDone(button: UIBarButtonItem) {
        dateTextField.text = DateFormatter.date().string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
