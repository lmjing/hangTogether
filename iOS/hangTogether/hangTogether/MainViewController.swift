//
//  MainViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 4..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit
import AlamofireImage

class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var plusFloatingButton: UIButton!
    
    var mainList:[Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "글 목록"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        plusFloatingButton.addTarget(self, action: #selector(moveToWrite), for: .touchUpInside)
        
        Networking.getMainList()
        NotificationCenter.default.addObserver(self, selector: #selector(recieve), name: Notification.Name.mainList, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func moveToWrite() {
        let writePostViewController = UIStoryboard.writePostStoryboard.instantiateViewController(withIdentifier: "writePost") as! WritePostViewController
        navigationController?.pushViewController(writePostViewController, animated: true)
        
        //전체 화면 차지하나 navigationbar 생기지 않음
//음       self.present(writePostViewController, animated: true, completion: nil)
        //같은 navigationbar가 아니라서 backbutton 생기지 않음
//        let test = UINavigationController(rootViewController: writePostViewController)
//        self.present(test, animated: true, completion: nil)
    }

    func recieve(notification: Notification) {
        if let data = notification.userInfo?["mainList"] as? [Post] {
            mainList = data
            tableView.reloadData()
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as! MainTableViewCell
//        if let profileURL = URL(string: "https://scontent-icn1-1.xx.fbcdn.net/v/t31.0-8/18815155_1337595106348251_8140129323514750362_o.jpg?oh=6be0546d8c1c4399b1076a7bc49d3e75&oe=5A462372") {
//            cell.profileImageView.af_setImage(withURL: profileURL)
//        }
        let post = mainList[indexPath.row]
        cell.titleLabel.text = post.title
        cell.nicknameLabel.text = post.writer.nickname
        //TODO: date 안됨
        cell.tripDateLabel.text = post.tripDate
        
        if let profileURL = URL(string: "https://scontent-icn1-1.xx.fbcdn.net/v/t31.0-8/18815155_1337595106348251_8140129323514750362_o.jpg?oh=6be0546d8c1c4399b1076a7bc49d3e75&oe=5A462372") {
            cell.profileImageView.af_setImage(withURL: profileURL)
        }
        
        cell.makeLanguages(languages: post.writer.languages)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userProfileViewController = UIStoryboard.userProfileStoryboard.instantiateViewController(withIdentifier: "userProfile") as! UserProfileViewController
        userProfileViewController.user = mainList[indexPath.row].writer
        navigationController?.pushViewController(userProfileViewController, animated: true)
    }
}
