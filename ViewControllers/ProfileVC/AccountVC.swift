//
//  MyProfileVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/31/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit

class AccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func logOutBtnPressed(_ sender: Any) {
        AuthManger.instance.logOut()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! UINavigationController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func toProfileBtnPresed(_ sender: Any) {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "toProfileVC") as! UINavigationController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
