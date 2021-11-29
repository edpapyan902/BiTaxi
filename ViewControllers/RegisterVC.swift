//
//  RegisterVC.swift
//  BiTaxi
//
//  Created by Alaa Khalil on 7/17/19.
//  Copyright © 2019 Alaa Khalil. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RegisterVC: UIViewController{
    
    @IBOutlet weak var scroll: UIScrollView!
    var city = [Cities]()
    var national = [Nationalities]()
    var cityID : Int = 0
    var nationalID : Int = 0

   // @IBOutlet weak var chooseNationality: UIButton!
    @IBOutlet weak var chooseCity: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var mobileTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var nameTxtField: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTxtField: SkyFloatingLabelTextField!
    
    var lastPressedButton: UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.touch))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        scroll.addGestureRecognizer(recognizer)
        
     

        chooseCity.addTarget(self, action:#selector(buttonClicked(sender:)), for: .touchUpInside)
//        chooseNationality.addTarget(self, action:#selector(buttonClicked(sender:)), for: .touchUpInside)
        pickerView.isHidden = true

        }
    
    @objc func buttonClicked(sender:UIButton!) {
        
        lastPressedButton = sender
        if lastPressedButton == chooseCity {
            self.handleCity()
            pickerView.isHidden = false
        }
//        else if lastPressedButton == chooseNationality {
//             self.handleNationality()
//            pickerView.isHidden = false
//        }
    }
    @objc func touch() {
        self.view.endEditing(true)
    }
    
    @IBAction func backBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        self.handleRegister()
    }
    
    func handleRegister(){
        guard let name = nameTxtField.text , nameTxtField.text != "" else {return}
        guard let email = emailTxtField.text , emailTxtField.text != "" else {return}
        guard let pass = passwordTxtField.text , passwordTxtField.text != "" else {return}
         guard let mobile = mobileTxtField.text , mobileTxtField.text != "" else {return}
        DispatchQueue.main.async {
        self.view.lock()
        AuthManger.instance.registerUser(email: email, password: pass, name: name, mobile: mobile, cityId: String(self.cityID), nationalID: String(1), completion: { (success) in
            if success{
                
                AuthManger.instance.logIn(mobile: mobile, password: pass, completion: { (success) in
                    if(success){
                        print(AuthManger.instance.authToken)
                        print(" -------------register success------------")
                        self.performSegue(withIdentifier: "MainVC", sender: nil)
                    }
                })
            }
            else{
                print("---------error in Register---------")

            }
            self.view.unlock()
        })
    }
    }
  
    
}




extension RegisterVC: UIPickerViewDelegate , UIPickerViewDataSource {
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if lastPressedButton == chooseCity {
            return city[row].name
}
//            else if lastPressedButton == chooseNationality {
//            return national[row].name
//        }
        return " "
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if lastPressedButton == chooseCity {
            return city.count;
        }
//         else if lastPressedButton == chooseNationality {
//            return national.count;
//        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if lastPressedButton == chooseCity {
            chooseCity.setTitle(city[row].name, for: .normal)
            self.cityID = city[row].id!
        }
//        else if lastPressedButton == chooseNationality {
//            // chooseNationality.setTitle(national[row].name, for: .normal)
//            self.nationalID = national[row].id!
//        }
        pickerView.isHidden = true
        print("City id ::::::: \(self.cityID)")
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var pickerLabel: UILabel? = (view as? UILabel)
        
        pickerLabel = UILabel()
        pickerLabel?.font = UIFont(name: "JF-Flat-medium.ttf", size: 30)
        pickerLabel?.textAlignment = .center
        if lastPressedButton == chooseCity {
             pickerLabel?.text = city[row].name
        }
//        else if lastPressedButton == chooseNationality {
//             pickerLabel?.text = national[row].name
//        }

        pickerLabel?.textColor = UIColor.black
        
        return pickerLabel!
    }
//    @IBAction func chooseNationalityBtnPressed(_ sender: UIButton) {
//        self.handleNationality()
//        pickerView.isHidden = false
//
//    }
//
//    @IBAction func chooseCityBtnPressed(_ sender: UIButton) {
//
//        self.handleCity()
//        pickerView.isHidden = false
//
//    }
    func handleCity(){
        ServerManger.instance.getCity { (response, error) in
            if error == nil{
                let res = response.result.value!
                self.city = res.cities!
                self.pickerView.reloadAllComponents()
                
            }
            else{
                print(error!)
            }
        }
    }
    
    func handleNationality(){
        ServerManger.instance.getNationality { (response, error) in
            if error == nil{
                let res = response.result.value!
                self.national = res.nationalities!
                self.pickerView.reloadAllComponents()
                
            }
            else{
                print(error!)
            }
        }
    }
    
    
   
    
}
