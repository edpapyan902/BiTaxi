//
//  UsageInstructionVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 8/28/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit

class UsageInstructionVC: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
         self.view.lock()
        ServerManger.instance.getPrivacyPolicy { (response, error) in
            if error == nil{
                let res = response.result.value?.privacy_policy!
                self.textLabel.text = res 
                
            }
            self.view.unlock()
        }
          
    }
        
    }
    

    
}
