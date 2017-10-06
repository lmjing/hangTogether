//
//  WritePostViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 6..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class WritePostViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var tripListViewHeight: NSLayoutConstraint!
    @IBOutlet weak var tripListView: UITableView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        
        titleTextField.delegate = self
        contentTextView.delegate = self
        
        tripListView.delegate = self
        tripListView.dataSource = self
        
        initView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        tripListViewHeight.constant = 0
        navigationItem.title = "글 작성"
        
        let okButton = UIBarButtonItem(image: #imageLiteral(resourceName: "check"), style: .done, target: self, action: #selector(done))
        navigationItem.setRightBarButton(okButton, animated: true)
    }
    
    func done(button: UIBarButtonItem) {
        print("ok button 눌림")
    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension WritePostViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
