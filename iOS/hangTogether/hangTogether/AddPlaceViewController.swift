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
    
//    var trip:[String:Any] = {
//        var data:[String:Any] = [:]
//        var place:[String:String] = [:]; data["place"] = place
//        return data
//    }()
    
    var datePicker = UIDatePicker()
    override func viewDidLoad() {
        super.viewDidLoad()

        let okButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check"), style: .done, target: self, action: #selector(done))
        navigationItem.setRightBarButton(okButton, animated: true)
        navigationItem.title = "장소 추가"
        datePicker.withTextField(dateTextField, selector: #selector(pickerDone))
        
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
        var tripdate: String?, placeName: String, placeAddress: String?
        if dateSwitch.isOn, let date = dateTextField.text, date != "" {
//            trip["date"] = date
            tripdate = date
        }else if !dateSwitch.isOn {
//            trip["date"] = nil
            tripdate = nil
        }else {
            let dialog = UIAlertController.okAlert(title: nil, message: "날짜를 선택해주세요.")
            self.present(dialog, animated: true, completion: nil)
            return
        }

        if let place = placeTextField.text, place != "" {
            placeName = place
//            var data = trip["place"] as? [String:String] {
//            data["name"] = place
//            trip["place"] = data
        }else {
            let dialog = UIAlertController.okAlert(title: nil, message: "장소를 입력해주세요.")
            self.present(dialog, animated: true, completion: nil)
            return
        }

        navigationController?.popViewController(animated: true)
//        let cv = navigationController?.viewControllers.last as! WritePostViewController
//        cv.tripList.append(trip)
        appendTripData(date: tripdate, placeName: placeName, placeAddress: placeAddress)
    }
    
    func appendTripData(date: String?, placeName: String, placeAddress: String?) {
        let cv = navigationController?.viewControllers.last as! WritePostViewController
        
        var newPlace: [String:String] = [:]
        newPlace["name"] = placeName
        if let address = placeAddress {
            newPlace["address"] = address
        }
        
        //TODO: notFound가 필요없는지 확인 후 필요없으면 삭제 할 것!
        var notFound = true
        print(cv.tripList, "before")
        cv.tripList = cv.tripList.map { oldtrip -> [String:Any] in
            if let oldDate = oldtrip["date"] as? String, oldDate == date {
                if var array = oldtrip["places"] as? [[String:String]] {
                    array.append(newPlace)
                    notFound = false
                }
            }
            return oldtrip
        }
        
        if notFound {
            var newTrip: [String:Any] = [:]
            newTrip["date"] = date
            newTrip["places"] = [newPlace]
            cv.tripList.append(newTrip)
        }
        print(cv.tripList, "after")
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
