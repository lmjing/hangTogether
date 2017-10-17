//
//  AddPlaceViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 6..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

protocol SelectPlaceDelegate {
    func redrawMap(position: CLLocationCoordinate2D)
}

class AddPlaceViewController: UIViewController, SelectPlaceDelegate {
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dateSwitch: UISwitch!
    @IBOutlet weak var placeTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var mapView: GMSMapView!
    
    var selectPlaceDelegate: SelectPlaceDelegate?
    var datePicker = UIDatePicker()
    var newPlace: [String:Any] = [:]
    var pickDate: String? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPlaceDelegate = self

        drawMap()
        let okButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check"), style: .done, target: self, action: #selector(done))
        navigationItem.setRightBarButton(okButton, animated: true)
        navigationItem.title = "장소 추가"
        datePicker.withTextField(dateTextField, selector: #selector(pickerDone))
        
        dateSwitch.addTarget(self, action: #selector(checkDate), for: .valueChanged)
        searchButton.addTarget(self, action: #selector(moveAutoComplete), for: .touchUpInside)
    }
    
    func redrawMap(position: CLLocationCoordinate2D) {
        let camera = GMSCameraPosition.camera(withLatitude: position.latitude, longitude: position.longitude, zoom: 15.0)
        mapView.camera = camera
        
        guard let title = newPlace["name"] as? String, let address = newPlace["address"] as? String,
        let lat = newPlace["lat"] as? Double, let lng = newPlace["lng"] as? Double else { return }
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: lng)
        marker.title = title
        marker.snippet = address
        marker.map = mapView
    }
    
    func drawMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 37.5547823, longitude: 126.9681966, zoom: 15.0)
        mapView.camera = camera
    }
    
    func moveAutoComplete() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
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
        if dateSwitch.isOn && pickDate == nil {
            let dialog = UIAlertController.okAlert(title: nil, message: "날짜를 선택해주세요.")
            self.present(dialog, animated: true, completion: nil)
            return
        }
        
        if newPlace["name"] == nil || newPlace["address"] == nil {
            if let inputPlaceName = placeTextField.text, inputPlaceName != "" {
                newPlace["name"] = inputPlaceName
                newPlace["address"] = nil
            }else {
                let dialog = UIAlertController.okAlert(title: nil, message: "장소를 입력해주세요.")
                self.present(dialog, animated: true, completion: nil)
                return
            }
        }

        appendTripData()
        navigationController?.popViewController(animated: true)
    }
    
    func appendTripData() {
        let cv = navigationController?.viewControllers.first as! WritePostViewController
        
        var notFound = true

        // 기존에 현재와 같은 값이 있는 경우 append 해준다.
        cv.tripList = cv.tripList.flatMap { (oldTrip: [String:Any]) -> [String:Any]? in
            let oldDate = oldTrip["date"] as? String
            
            if oldDate == pickDate {
                notFound = false
                var newTrip = oldTrip
                guard var places = newTrip["places"] as? [[String:Any]] else { return nil }
                places.append(newPlace)
                newTrip["places"] = places
                return newTrip
            }
            return oldTrip
        }
        
        // 값이 없을 경우 새로 추가한다.
        if notFound {
            var newTrip: [String:Any] = [:]
            newTrip["date"] = pickDate
            newTrip["places"] = [newPlace]
            cv.tripList.append(newTrip)
        }
    }
    
    func pickerDone(button: UIBarButtonItem) {
        dateTextField.text = datePicker.date.string
        pickDate = datePicker.date.string
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension AddPlaceViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        placeTextField.text = place.name
        newPlace["name"] = place.name
        newPlace["address"] = place.formattedAddress
        newPlace["lat"] = place.coordinate.latitude
        newPlace["lng"] = place.coordinate.longitude
        selectPlaceDelegate?.redrawMap(position: place.coordinate)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
