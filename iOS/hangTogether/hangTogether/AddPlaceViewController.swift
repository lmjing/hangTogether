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
        var tripdate: String?, placeName: String, placeAddress: String?
        if dateSwitch.isOn, let date = dateTextField.text, date != "" {
            tripdate = date
        }else if !dateSwitch.isOn {
            tripdate = nil
        }else {
            let dialog = UIAlertController.okAlert(title: nil, message: "날짜를 선택해주세요.")
            self.present(dialog, animated: true, completion: nil)
            return
        }

        if let place = placeTextField.text, place != "" {
            placeName = place
        }else {
            let dialog = UIAlertController.okAlert(title: nil, message: "장소를 입력해주세요.")
            self.present(dialog, animated: true, completion: nil)
            return
        }

        navigationController?.popViewController(animated: true)
        appendTripData(date: tripdate, placeName: placeName, placeAddress: placeAddress)
    }
    
    func appendTripData(date: String?, placeName: String, placeAddress: String?) {
        let cv = navigationController?.viewControllers.last as! WritePostViewController
        
        newPlace["name"] = placeName
        if let address = placeAddress {
            newPlace["address"] = address
        }
        
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
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        placeTextField.text = place.name
        newPlace["name"] = place.name
        newPlace["address"] = place.formattedAddress
        selectPlaceDelegate?.redrawMap(position: place.coordinate)
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
