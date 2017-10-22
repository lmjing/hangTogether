//
//  CountryViewController.swift
//  hangTogether
//
//  Created by 이미정 on 2017. 10. 22..
//  Copyright © 2017년 이미정. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {
    @IBOutlet var countryImageView: [UIImageView]!
    @IBOutlet var languageLabel: [paddingLabel]!
    @IBOutlet weak var languageSelectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
