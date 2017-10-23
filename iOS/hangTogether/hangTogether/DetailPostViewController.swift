//
//  DetailPostViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 15..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class DetailPostViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var languageStackView: UIStackView!
    @IBOutlet weak var userProfileView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    var post = Post()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tabBarController?.tabBar.isHidden = true
        
        initView()
    }
    
    func initView() {
        titleLabel.text = post.title
        guard let writer = post.writer else { print("no writer"); return }
        if let profileURL = URL(string: "https://scontent-icn1-1.xx.fbcdn.net/v/t31.0-8/18815155_1337595106348251_8140129323514750362_o.jpg?oh=6be0546d8c1c4399b1076a7bc49d3e75&oe=5A462372") {
            profileImageView.af_setImage(withURL: profileURL)
        }
        nicknameLabel.text = writer.nickname
        userInfoLabel.text = "\(writer.birth.age) \(writer.sex.rawValue)"
        startDateLabel.text = post.tripDate.start.string
        endDateLabel.text = post.tripDate.end.string
        contentLabel.text = post.content
        makeLanguages(post.writer.languages)
        designView()
    }
    
    func makeLanguages(_ languages: [String]) {
        for language in languages {
            let label = PaddingLabel()
            label.language(text: language)
            languageStackView.addArrangedSubview(label)
        }
    }
    
    func designView() {
        profileImageView.drawCircle()
        contentView.drawLine()
        firstButton.drawLine()
        secondButton.drawLine()
    }
    
    //TODO: userProfileView누르면 이동하도록 구현할 것
    func moveUserProfile() {
        let userProfileViewController = UIStoryboard.userProfileStoryboard.instantiateViewController(withIdentifier: "userProfile") as! UserProfileViewController
        userProfileViewController.user = post.writer
        navigationController?.pushViewController(userProfileViewController, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DetailPostViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return post.trip.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.trip[section].places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripDateCell", for: indexPath) as! TripTableViewCell
        
        let trip = post.trip[indexPath.section]
        let place = trip.places[indexPath.row]

        // 첫번째일 경우 날짜 라벨 생성
        if indexPath.row == 0 {
            cell.makeFirstView(date: trip.date?.string)
        }

        let lastSection = tableView.numberOfSections - 1
        let lastIndexPath = IndexPath(row: tableView.numberOfRows(inSection: lastSection) - 1, section: lastSection)
        cell.makeLine(index: indexPath, count: lastIndexPath)
        if let name = place["name"] as? String {
            cell.placeLabel.text = name
        }
        cell.deleteCancleButton()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
}
