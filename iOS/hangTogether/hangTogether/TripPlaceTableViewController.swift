//
//  TripPlaceTableViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 16..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

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
        return 5
    }
}
