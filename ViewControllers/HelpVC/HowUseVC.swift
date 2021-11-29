//
//  HowUseVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 8/28/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit

class HowUseVC: UIViewController {

    @IBOutlet weak var labelText: UILabel!
    override func viewDidLoad() {
        self.view.lock()
        super.viewDidLoad()
        DispatchQueue.main.async{
        ServerManger.instance.getTermOfUse { (response, error) in
            if error == nil{
                let res = response.result.value?.privacy_policy!
                self.labelText.text = res
                
            }
             self.view.unlock()
        }
           
    }
    }
    

   

}
