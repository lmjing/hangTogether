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
    var tripList:[Trip] = []
    
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
        tripList.sort(by: {
            if let date1 = $0.date?.convertString(), let date2 = $1.date?.convertString() {
                return date1 < date2
            }
            return false
        })
        tripListViewHeight.constant = CGFloat(30 * tripList.count)
        tripListView.reloadData()
    }
    
    func initView() {
        navigationItem.title = "글 작성"
        
        let okButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check"), style: .done, target: self, action: #selector(writeDone))
        navigationItem.setRightBarButton(okButton, animated: true)
        
        contentTextView.layer.borderWidth = 1.5
        contentTextView.layer.borderColor = UIColor.pointColor.cgColor
        
        datePicker.withTextField(startDateTextField, selector: #selector(pickerDone))
        datePicker.withTextField(endDateTextField, selector: #selector(pickerDone))
    }
    
    func pickerDone(button: UIBarButtonItem) {
        switch button.tag {
        case 1:
            startDateTextField.text = DateFormatter.date().string(from: datePicker.date)
        case 2:
            endDateTextField.text = DateFormatter.date().string(from: datePicker.date)
        default:
            print("error: datePickerDone")
            break
        }
        self.view.endEditing(true)
    }
    
    func writeDone(button: UIBarButtonItem) {
        print("ok button 눌림")
    }
    
    func moveAddTripView(button: UIButton) {
        if let min = startDateTextField.text, let max = endDateTextField.text, !min.isEmpty && !max.isEmpty {
            let addPlaceViewController = UIStoryboard.addPlaceStoryboard.instantiateViewController(withIdentifier: "addPlace") as! AddPlaceViewController
            addPlaceViewController.datePicker.minimumDate = min.convertDate()
            addPlaceViewController.datePicker.maximumDate = max.convertDate()
            navigationController?.pushViewController(addPlaceViewController, animated: true)
        }else {
            let alert = UIAlertController.okAlert(title: nil, message: "여행 기간을 입력해주세요.")
            self.present(alert, animated: true, completion: nil)
        }
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
        
        if let date = tripList[indexPath.row].date?.convertString() {
            cell.dateLabel.text = date.monthDay()
        }else {
            cell.dateLabel.text = "무관"
        }
        if tripList.count > 1 {
            cell.makeLine(index: indexPath.row, count: tripList.count)
        }
        cell.placeCollectionView.delegate = self
        cell.placeCollectionView.dataSource = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
}

extension WritePostViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeCell", for: indexPath) as! PlaceCollectionViewCell
        
        cell.placeNameLabel.text = "테스트"
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//        return 100
//    }
}
