//
//  WritePostViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 6..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

/*
 TODO: 스크롤 뷰 안에 테이블 뷰가 들어있는 안 좋은 형태의 View다. 배민때 처럼 전체를 테이블 뷰로 변경해 새로 시도 할 것
 why? 테이블 뷰 안에 콜렉션뷰가 있기 때문에 높이가 가변적이며 높이를 정확히 알 수 없어 테이블 뷰의 높이를 다시 재 설정해야하는 문제가 발생한다. -> 즉, 높이 재 설정을 막고 자동으로 측정할 수 있게 한다.
 */
class WritePostViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        
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
        tableView.reloadData()
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
        cell.placeCollectionView.tag = indexPath.row
        cell.placeCollectionView.reloadData()
        
        cell.collectionViewHeight.constant = cell.placeCollectionView.collectionViewLayout.collectionViewContentSize.height
        cell.contentView.setNeedsLayout()
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100.0
//    }
}

extension WritePostViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tripList[collectionView.tag].places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "placeCell", for: indexPath) as! PlaceCollectionViewCell
        
        let place = tripList[collectionView.tag].places[indexPath.row]
        cell.placeNameLabel.text = place["name"]
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        let count = CGFloat(tripList[collectionView.tag].places.count / 2) + 1
//        return CGSize(width: 100, height: 30.0 * count)
//    }
}
