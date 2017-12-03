//
//  HistoryTableViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 12. 3..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var history: [String:[[String:Any]]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(received), name: Notification.Name.history, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func received(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String:Any] else { return }
        guard let result = userInfo["result"] as? String else { return }
        if result == "success" {
            guard let data = userInfo["data"] as? [String:[[String:Any]]] else { return }
            history = data
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! MainTableViewCell

        cell.nicknameLabel.text = "nickname"
        cell.tripDateLabel.text = "2011/11/11"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = self.view.frame.width
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        view.backgroundColor = UIColor.pointColor
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: 30))
        title.textAlignment = .center
        title.text = section == 0 ? "Doing" : "Done"
        title.textColor = UIColor.white
        title.shadowOffset = CGSize(width: 100, height: 100)
        title.shadowColor = UIColor.white
        
//        let line = UIView(frame: CGRect(x: 0, y: 15, width: width, height: 20))
//        line.backgroundColor = UIColor.white
//        
//        view.addSubview(line)
        view.addSubview(title)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
