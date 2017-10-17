//
//  TripPlaceTableViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 16..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit
import AlamofireImage

class TripPlaceTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripPlaceCell", for: indexPath) as! TripPlaceTableViewCell
        
        if let imageURL = URL(string: "http://social.lge.co.kr/wp-content/uploads/2015/10/%EC%98%AC%EB%A0%88%EB%93%9CTV%EC%99%80-%ED%95%A8%EA%BB%98%ED%95%98%EB%8A%94-%EA%B2%BD%EB%B3%B5%EA%B6%81%EC%9D%98-%EB%B0%A4-2-1024x681.jpg") {
            cell.placeImageView.af_setImage(withURL: imageURL)
        }
        cell.placeNameLabel.text = "경복궁"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
