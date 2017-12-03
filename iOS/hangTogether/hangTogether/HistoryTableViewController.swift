//
//  HistoryTableViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 12. 3..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class HistoryTableViewController: UITableViewController {

    var history: [String:[Post]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let id = UserDefaults.standard.string(forKey: "id") {
            Networking.getHistory(userId: id)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(received), name: Notification.Name.history, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func received(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String:Any] else { return }
        guard let result = userInfo["result"] as? String else { return }
        if result == "success" {
            guard let data = userInfo["data"] as? [String:[Post]] else { return }
            history = data
            print(history)
            self.tableView.reloadData()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = section == 0 ? "ing" : "end"
        if let data = history[key] {
            return data.count == 0 ? 1 : data.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = indexPath.section == 0 ? "ing" : "end"
        if history[key]?.count == 0 {
            let cell = UITableViewCell(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 20))
            cell.textLabel?.text = "작성된 글이 없습니다."
            cell.textLabel?.textAlignment = .center
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! MainTableViewCell
        guard let post = history[key]?[indexPath.row] else { return cell }
        
        cell.nicknameLabel.text = post.writer.nickname
        cell.makeLanguages(languages: post.writer.languages)
        if let profile = post.writer.profileUrl, let url = URL(string: profile) {
            cell.profileImageView.af_setImage(withURL: url)
        }
        
        cell.titleLabel.text = post.title
        cell.tripDateLabel.text = "\(post.tripDate.start.string) ~ \(post.tripDate.end.string)"
        cell.timeLabel.text = post.created.time
        
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
        
        view.addSubview(title)
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let key = indexPath.section == 0 ? "ing" : "end"
        return history[key]?.count == 0 ? 20 : 107
    }
}
