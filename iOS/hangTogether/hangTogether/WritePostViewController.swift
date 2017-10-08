//
//  WritePostViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 6..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class WritePostViewController: UIViewController {
    @IBOutlet weak var tripListViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tripListView: UITableView!
    
    @IBOutlet weak var titleTextField: UITextField!
    //TODO: 논의 후 placehorder 있는 라이브러리 사용하기
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var addPlaceButton: UIButton!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    
    let datePicker = UIDatePicker()
    var post:[String:Any] = [:]
    var tripList:[[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        titleTextField.delegate = self
        contentTextView.delegate = self
        
        tripListView.delegate = self
        tripListView.dataSource = self
        
        initView()
        addPlaceButton.addTarget(self, action: #selector(moveAddTripView), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tripListViewHeight.constant = CGFloat(30 * tripList.count)
        tripListView.reloadData()
    }
    
    func initView() {
//        tripListViewHeight.constant = 0
        navigationItem.title = "글 작성"
        
        let okButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check"), style: .done, target: self, action: #selector(writeDone))
        navigationItem.setRightBarButton(okButton, animated: true)
        
        contentTextView.layer.borderWidth = 1.5
        contentTextView.layer.borderColor = UIColor.pointColor.cgColor
        
        createDatePicker(textField: startDateTextField)
        createDatePicker(textField: endDateTextField)
    }
    
    
    func createDatePicker(textField: UITextField) {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(pickerDone))
        toolbar.setItems([doneButton], animated: true)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
        datePicker.datePickerMode = .date
    }
    
    func pickerDone(button: UIBarButtonItem) {
        //TODO: 데이터에 담긴걸로 텍스트 변경
        startDateTextField.text = DateFormatter.date().string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func writeDone(button: UIBarButtonItem) {
        print("ok button 눌림")
    }
    
    func moveAddTripView(button: UIButton) {
        let addPlaceViewController = UIStoryboard.addPlaceStoryboard.instantiateViewController(withIdentifier: "addPlace") as! AddPlaceViewController
        navigationController?.pushViewController(addPlaceViewController, animated: true)
    }
}

extension WritePostViewController: UITextFieldDelegate, UITextViewDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let newLength = text.characters.count + string.characters.count - range.length
        return newLength <= 20
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let str = textView.text else { return true }
        let newLength = str.characters.count + text.characters.count - range.length
        return newLength <= 200
    }
}

extension WritePostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tripList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripDateCell", for: indexPath) as! TripTableViewCell
        
        if let date = tripList[indexPath.row]["date"] as? String {
            cell.dateLabel.text = date.monthDay()
        }else {
            cell.dateLabel.text = "무관"
        }
        if tripList.count > 1 {
            cell.makeLine(index: indexPath.row, count: tripList.count)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
}
