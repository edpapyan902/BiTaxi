//
//  LoginVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/17/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class LoginVC: UIViewController {

    @IBOutlet weak var passwordTxt: SkyFloatingLabelTextFieldWithIcon!
    @IBOutlet weak var mobileTxt: SkyFloatingLabelTextFieldWithIcon!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    
    func logIn(){
        if passwordTxt.text == "" || mobileTxt.text == ""{
            showMassage(massageTitle: "", massageBody: "يجب ادخال رقم التليفون وكلمه المرور اولا", place: 1, layout: .centeredView)
        }
        else{
            guard let password = passwordTxt.text , passwordTxt.text != "" else {return}
            guard let mobile = mobileTxt.text , mobileTxt.text != "" else {return}
            DispatchQueue.main.async {
                
                self.view.lock()
            AuthManger.instance.logIn(mobile: mobile, password: password, completion: { (success) in
                if(success){
                    
                    print(AuthManger.instance.authToken)
                    print("success")
                    showMassage(massageTitle: "", massageBody: AuthManger.instance.massage! , place: 1, layout: .centeredView)
                    self.performSegue(withIdentifier: "ToMainVC", sender: nil)
                }
                else{
                    
                    print("---------error in logIn---------")
                }
            })
                self.view.unlock()
    }
            
        }
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func logInPressedBtn(_ sender: Any) {
        self.logIn()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }



}
