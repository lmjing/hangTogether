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
    var newPlace: [String:String] = [:]
    
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
        
        guard let title = newPlace["name"], let address = newPlace["address"] else { return }
        
        let marker = GMSMarker()
        marker.position = position
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
        autocompleteController.searchDisplayController?.searchBar.text = placeTextField.text
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
        var tripdate: String?
        if dateSwitch.isOn, let date = dateTextField.text, date != "" {
            tripdate = date
        }else if !dateSwitch.isOn {
            tripdate = nil
        }else {
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

        appendTripData(date: tripdate)
        navigationController?.popViewController(animated: true)
    }
    
    func appendTripData(date: String?) {
        let cv = navigationController?.viewControllers.first as! WritePostViewController
        
        var notFound = true

        cv.tripList = cv.tripList.flatMap { (oldTrip: Trip) -> Trip? in
            if oldTrip.date?.string == date {
                notFound = false
                var newtrip = oldTrip
                newtrip.places.append(newPlace)
                return newtrip
            }
            return oldTrip
        }
        
        if notFound {
            var newTrip = Trip()
            newTrip.date = date?.date
            newTrip.places = [newPlace]
            cv.tripList.append(newTrip)
        }
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

extension AddPlaceViewController: GMSAutocompleteViewControllerDelegate {
    
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        placeTextField.text = place.name
        newPlace["name"] = place.name
        newPlace["address"] = place.formattedAddress
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
